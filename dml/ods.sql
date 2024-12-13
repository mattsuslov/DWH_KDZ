COPY ods.flight_statistics (
    year, quarter, month, flight_date, reporting_airline, airline_tail_number,
    airplane_id, flight_number_reporting_airline, origin_airport, dest_airport,
    dep_delay_minutes, cancelled, cancellation_code, weather_delay, dep_time,
    crs_dep_time, distance
)
FROM '/csv_data/flight_statistics_test_data.csv'
DELIMITER ','
CSV HEADER;

COPY ods.weather_conditions (
    weather_date, airport_code, temperature, wind_speed, precipitation, weather_description
)
FROM '/csv_data/weather_conditions_test_data.csv'
DELIMITER ','
CSV HEADER;