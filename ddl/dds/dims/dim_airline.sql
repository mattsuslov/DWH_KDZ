CREATE TABLE dds.dim_airline (
    airline_id SERIAL PRIMARY KEY,
    airline_name VARCHAR(50) NOT NULL,
    airline_code VARCHAR(10) NOT NULL, -- Код авиакомпании (например, 'DL' для Delta)
    tech_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tech_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO dds.dim_airline (airline_name, airline_code)
SELECT DISTINCT
    reporting_airline AS airline_name,
    SUBSTRING(reporting_airline, 1, 2) AS airline_code
FROM stg.flight_statistics
WHERE reporting_airline IS NOT NULL
ON CONFLICT (airline_name) DO NOTHING;