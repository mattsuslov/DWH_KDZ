CREATE SCHEMA IF NOT EXISTS ods;

CREATE TABLE ods.flight_statistics (
    id SERIAL PRIMARY KEY,
    year INT NOT NULL,
    quarter INT NOT NULL,
    month INT NOT NULL,
    flight_date DATE NOT NULL,
    reporting_airline VARCHAR(50) NOT NULL,
    airline_tail_number VARCHAR(50),
    airplane_id VARCHAR(50),
    flight_number_reporting_airline VARCHAR(50),
    origin_airport VARCHAR(10) NOT NULL,
    dest_airport VARCHAR(10) NOT NULL,
    dep_delay_minutes INT,
    cancelled BOOLEAN,
    cancellation_code VARCHAR(10),
    weather_delay INT,
    dep_time TIME,
    crs_dep_time TIME,
    distance INT,
    tech_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tech_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ods.weather_conditions (
    id SERIAL PRIMARY KEY,
    weather_date DATE NOT NULL,
    airport_code VARCHAR(10) NOT NULL,
    temperature FLOAT,
    wind_speed FLOAT,
    precipitation FLOAT,
    weather_description VARCHAR(255),
    tech_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tech_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

