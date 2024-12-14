CREATE SCHEMA IF NOT EXISTS ods;

DROP TABLE IF EXISTS ods.flight_statistics;

CREATE TABLE ods.flight_statistics (
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

DROP TABLE IF EXISTS ods.weather_conditions;

CREATE TABLE ods.weather_conditions (
    local_time TEXT,
    t TEXT,
    p0 TEXT,
    p TEXT,
    u TEXT,
    dd TEXT,
    ff TEXT,
    ff10 text,
    ww TEXT,
    w_w TEXT,
    c TEXT,
    vv TEXT,
    td TEXT,
    empty TEXT,
    tech_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tech_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

