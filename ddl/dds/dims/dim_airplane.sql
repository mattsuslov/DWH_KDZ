CREATE TABLE dds.dim_airplane (
    airplane_id SERIAL PRIMARY KEY,
    tail_number VARCHAR(50) NOT NULL, -- Хвостовой номер самолета
    model VARCHAR(100),
    manufacturer VARCHAR(100),
    capacity INT,
    tech_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tech_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO dds.dim_airplane (tail_number, model, manufacturer, capacity)
SELECT DISTINCT
    airline_tail_number AS tail_number,
    NULL AS model, -- Placeholder, если данных нет
    NULL AS manufacturer, -- Placeholder
    NULL AS capacity -- Placeholder
FROM stg.flight_statistics
WHERE airline_tail_number IS NOT NULL
ON CONFLICT (tail_number) DO NOTHING;