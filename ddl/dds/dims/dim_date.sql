CREATE TABLE dds.dim_date (
    date_id SERIAL PRIMARY KEY,
    calendar_date DATE NOT NULL,
    year INT NOT NULL,
    quarter INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    day_of_week VARCHAR(10),
    is_weekend BOOLEAN,
    tech_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tech_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO dds.dim_date (calendar_date, year, quarter, month, day, day_of_week, is_weekend)
SELECT DISTINCT
    flight_date AS calendar_date,
    EXTRACT(YEAR FROM flight_date) AS year,
    EXTRACT(QUARTER FROM flight_date) AS quarter,
    EXTRACT(MONTH FROM flight_date) AS month,
    EXTRACT(DAY FROM flight_date) AS day,
    TO_CHAR(flight_date, 'Day') AS day_of_week,
    CASE WHEN EXTRACT(DOW FROM flight_date) IN (0, 6) THEN TRUE ELSE FALSE END AS is_weekend
FROM stg.flight_statistics
WHERE flight_date IS NOT NULL
ON CONFLICT (calendar_date) DO NOTHING;