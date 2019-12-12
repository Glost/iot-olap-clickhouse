CREATE TABLE IF NOT EXISTS sensor_values (
    latitude Float64,
    longitude Float64,
    altitude Float64,
    timestamp DateTime,
    air_temperature Float64,
    air_humidity Float64,
    wind_speed Float64,
    is_raining UInt8,
    illuminance Float64
) ENGINE = MergeTree()
PARTITION BY (toRelativeDayNum(timestamp), toRelativeHourNum(timestamp), toRelativeMinuteNum(timestamp))
ORDER BY (timestamp, longitude, latitude, altitude);
