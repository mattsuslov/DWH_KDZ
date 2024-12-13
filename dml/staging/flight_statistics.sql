--дедубликация
WITH dedubl_cte AS (
    SELECT * FROM (
        SELECT
            *,
            CASE WHEN ROW_NUMBER() OVER (
                PARTITION BY year, flight_date, flight_number_reporting_airline, origin_airport, dest_airport
                ORDER BY tech_created DESC
            ) > 1 THEN TRUE ELSE FALSE END AS is_duplicate
        FROM ods.flight_statistics
    ) marked_src WHERE marked_src.is_duplicate = false   
)
--очискта битых строк
, cleared_cte AS (
    SELECT * FROM dedubl_cte
    WHERE 1=1
        AND dep_delay_minutes >= -100 
        AND distance >= 0
)
--приведение данных и вставка
INSERT INTO stg.flight_statistics
(
"year"
, "quarter"
, "month"
, flight_date
, reporting_airline
, airline_tail_number
, airplane_id, flight_number_reporting_airline
, origin_airport, dest_airport
, dep_delay_minutes, cancelled
, cancellation_code, weather_delay
, dep_time, crs_dep_time
, distance
)
select 
    "year"
    , "quarter"
    , "month"
    , flight_date
    , reporting_airline
    , airline_tail_number
    , airplane_id, flight_number_reporting_airline
    , origin_airport, dest_airport
    , dep_delay_minutes, cancelled
    , cancellation_code, weather_delay
    , dep_time, crs_dep_time
    , distance
from cleared_cte;
