CREATE TABLE dds.dim_airport (
    airport_id SERIAL PRIMARY KEY,
    airport_name VARCHAR(100),
    airport_code VARCHAR(10) NOT NULL, -- Код аэропорта (IATA или ICAO)
    city VARCHAR(100),
    state VARCHAR(50),
    country VARCHAR(50),
    tech_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tech_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO dds.dim_airport (airport_name, airport_code, city, state, country)
SELECT DISTINCT
    origin_airport AS airport_name,
    origin_airport AS airport_code,
    NULL AS city, -- Placeholder, если данных о городе нет
    NULL AS state, -- Placeholder
    'USA' AS country
FROM stg.flight_statistics
WHERE origin_airport IS NOT NULL
UNION
SELECT DISTINCT
    dest_airport AS airport_name,
    dest_airport AS airport_code,
    NULL AS city,
    NULL AS state,
    'USA' AS country
FROM stg.flight_statistics
WHERE dest_airport IS NOT NULL
ON CONFLICT (airport_code) DO NOTHING;