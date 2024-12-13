
--дедубликация
WITH dedubl_cte AS (
    SELECT * FROM (
        SELECT
            *,
            CASE WHEN ROW_NUMBER() OVER (
                PARTITION BY weather_date, airport_code, temperature, wind_speed, precipitation, weather_description
                ORDER BY tech_created DESC
            ) > 1 THEN TRUE ELSE FALSE END AS is_duplicate
        FROM ods.weather_conditions
    ) marked_src WHERE marked_src.is_duplicate = false   
)
--очискта битых строк
, cleared_cte AS (
    SELECT * FROM dedubl_cte
    WHERE 1=1
        AND temperature >= -10
)
--приведение данных и вставка
INSERT INTO stg.weather_conditions (
    weather_date, airport_code, temperature, wind_speed, precipitation, weather_description
)
select 
    weather_date, airport_code, temperature, wind_speed, precipitation, weather_description
from cleared_cte;
