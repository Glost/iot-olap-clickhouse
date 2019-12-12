--liquibase formatted sql

--changeset Glost:#1-add-sensor-values-table

CREATE TABLE IF NOT EXISTS sensor_values (
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    altitude DOUBLE PRECISION NOT NULL,
    timestamp TIMESTAMP NOT NULL,
    air_temperature DOUBLE PRECISION NOT NULL,
    air_humidity DOUBLE PRECISION NOT NULL,
    wind_speed DOUBLE PRECISION NOT NULL,
    is_raining BOOLEAN NOT NULL,
    illuminance DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (latitude, longitude, altitude, timestamp)
);

--rollback DROP TABLE IF EXISTS sensor_values;

--changeset Glost:#1-add-scheduled-pushing-data-to-clickhouse-log-table

CREATE TABLE IF NOT EXISTS scheduled_pushing_data_to_clickhouse_log (
    timestamp TIMESTAMP PRIMARY KEY,
    pushed_rows_count INTEGER NOT NULL,
    clickhouse_query_duration INTEGER NOT NULL
);

--rollback DROP TABLE IF EXISTS scheduled_pushing_data_to_clickhouse_log;
