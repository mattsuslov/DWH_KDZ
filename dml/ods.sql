COPY ods.flight_statistics (
    year,
    quarter,
    month,
    fl_date,
    op_unique_carrier,
    tail_num,
    op_carrier_fl_num,
    origin_airport_id,
    dest_airport_id,
    crs_dep_time,
    dep_time,
    dep_delay_new,
    cancelled,
    cancellation_code,
    air_time,
    distance,
    weather_delay
)
FROM '/csv_data/T_ONTIME_REPORTING.csv'
DELIMITER ','
CSV HEADER;

COPY ods.weather_conditions (
    local_time,
    t,
    p0,
    p,
    u,
    dd,
    ff,
    ff10,
    ww,
    w_w,
    c,
    vv,
    td,
    empty
)
FROM PROGRAM 'tail -n +7 /csv_data/KSEA.csv'
DELIMITER ';'
CSV HEADER;