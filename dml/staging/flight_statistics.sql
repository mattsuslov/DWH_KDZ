--дедубликация
WITH dedubl_cte AS (
    SELECT * FROM (
        SELECT
            *,
            CASE WHEN ROW_NUMBER() OVER (
                PARTITION BY year,
						    quarter,
						    month,
						    fl_date,
						    op_unique_carrier,
						    tail_num,
						    op_carrier_fl_num,
						    origin_airport_id,
						    dest_airport_id,
						    crs_dep_time,
						    dep_time,
						    dep_delay_new,
						    cancelled,
						    cancellation_code,
						    air_time,
						    distance,
						    weather_delay
                ORDER BY tech_created DESC
            ) > 1 THEN TRUE ELSE FALSE END AS is_duplicate
        FROM ods.flight_statistics
    ) marked_src WHERE marked_src.is_duplicate = false   
)
--очискта битых строк
, cleared_cte AS (
    SELECT * FROM dedubl_cte
    WHERE 1=1
        AND dep_delay_new >= -100 
        AND distance >= 0
)
--приведение данных и вставка
INSERT INTO stg.flight_statistics
(
year,
quarter,
month,
fl_date,
op_unique_carrier,
tail_num,
op_carrier_fl_num,
origin_airport_id,
dest_airport_id,
crs_dep_time,
dep_time,
dep_delay_new,
cancelled,
cancellation_code,
air_time,
distance,
weather_delay
)
select 
    year,
    quarter,
    month,
    fl_date,
    op_unique_carrier,
    tail_num,
    op_carrier_fl_num,
    origin_airport_id,
    dest_airport_id,
    crs_dep_time,
    dep_time,
    dep_delay_new,
    cancelled,
    cancellation_code,
    air_time,
    distance,
    weather_delay
from cleared_cte;
