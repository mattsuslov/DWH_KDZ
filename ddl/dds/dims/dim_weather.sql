CREATE TABLE dds.dim_weather (
    weather_id SERIAL PRIMARY KEY,
    weather_date DATE NOT NULL,
    airport_id INT NOT NULL, -- Ссылка на аэропорт
    temperature FLOAT,
    wind_speed FLOAT,
    precipitation FLOAT,
    weather_description VARCHAR(255),
    tech_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tech_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (airport_id) REFERENCES dds.dim_airport(airport_id)
);

INSERT INTO dds.dim_weather (weather_date, airport_id, temperature, wind_speed, precipitation, weather_description)
SELECT DISTINCT
    wc.weather_date,
    da.airport_id,
    wc.temperature,
    wc.wind_speed,
    wc.precipitation,
    wc.weather_description
FROM stg.weather_conditions wc
JOIN dds.dim_airport da ON wc.airport_code = da.airport_code
ON CONFLICT (weather_date, airport_id) DO NOTHING;