CREATE SCHEMA IF NOT EXISTS stg;

DROP TABLE IF EXISTS stg.flight_statistics;
CREATE TABLE stg.flight_statistics (
    id SERIAL PRIMARY KEY,
    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    fl_date TIMESTAMP,
    op_unique_carrier VARCHAR(10),
    tail_num VARCHAR(20),
    op_carrier_fl_num INTEGER,
    origin_airport_id VARCHAR(3),
    dest_airport_id VARCHAR(3),
    crs_dep_time INTEGER,
    dep_time INTEGER,
    dep_delay_new NUMERIC(6,2),
    cancelled NUMERIC(3,2),
    cancellation_code VARCHAR(10),
    air_time NUMERIC(6,2),
    distance NUMERIC(8,2),
    weather_delay NUMERIC(6,2),
    tech_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tech_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS stg.weather_conditions;
CREATE TABLE stg.weather_conditions (
    observation_time TIMESTAMP,
    temperature_c NUMERIC(5,1),
    pressure_station_mm NUMERIC(6,1),
    pressure_sealevel_mm NUMERIC(6,1),
    relative_humidity NUMERIC(3,0),
    wind_direction TEXT,
    wind_speed_ms NUMERIC(5,1) default 0,
    wind_gust_ms NUMERIC(5,1) default 0,
    weather_phenomena TEXT,
    recent_weather TEXT,
    cloud_cover TEXT,
    visibility_km NUMERIC(5,1),
    dewpoint_c NUMERIC(5,1),
    tech_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tech_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
