
--дедубликация
WITH dedubl_cte AS (
    SELECT * FROM (
        SELECT
            *,
            CASE WHEN ROW_NUMBER() OVER (
                PARTITION BY local_time,t,p0,p,u,dd,ff,ff10,ww,w_w,c,vv,td
                ORDER BY tech_created DESC
            ) > 1 THEN TRUE ELSE FALSE END AS is_duplicate
        FROM ods.weather_conditions
    ) marked_src WHERE marked_src.is_duplicate = false   
)
--очискта битых строк
, cleared_cte AS (
    SELECT * FROM dedubl_cte
    WHERE 1=1
)
--приведение данных и вставка
-- Выполняем вставку из ODS в staging с преобразованием форматов.
INSERT INTO stg.weather_conditions (
    observation_time,
    temperature_c,
    pressure_station_mm,
    pressure_sealevel_mm,
    relative_humidity,
    wind_direction,
    wind_speed_ms,
    wind_gust_ms,
    weather_phenomena,
    recent_weather,
    cloud_cover,
    visibility_km,
    dewpoint_c
)
SELECT 
    -- Преобразуем дату/время из текста в TIMESTAMP
    to_timestamp(local_time, 'DD.MM.YYYY HH24:MI'),
    -- Преобразуем текстовые значения в числовые
    t::numeric(5,1),
    p0::numeric(6,1),
    p::numeric(6,1),
    u::numeric(3,0),
    dd,
    ff::numeric(5,1),
    (case ff10 WHEN '' THEN NULL ELSE ff10 END)::numeric(5,1),
    ww,
    w_w,
    c,
    vv::numeric(5,1),
    td::numeric(5,1)
FROM cleared_cte;
