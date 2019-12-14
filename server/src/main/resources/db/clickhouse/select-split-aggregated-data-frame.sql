SELECT latitude, longitude, altitude, timestamp_rounded,
       min_air_temperature,
       max_air_temperature,
       avg_air_temperature,
       median_air_temperature,
       var_air_temperature,
       min_air_humidity,
       max_air_humidity,
       avg_air_humidity,
       median_air_humidity,
       var_air_humidity,
       min_wind_speed,
       max_wind_speed,
       avg_wind_speed,
       median_wind_speed,
       var_wind_speed,
       min_illuminance,
       max_illuminance,
       avg_illuminance,
       median_illuminance,
       var_illuminance,
       avg_rains
FROM (SELECT latitude, longitude, altitude, timestamp_rounded,
             min(air_temperature) AS min_air_temperature,
             max(air_temperature) AS max_air_temperature,
             avg(air_temperature) AS avg_air_temperature,
             median(air_temperature) AS median_air_temperature,
             varPop(air_temperature) AS var_air_temperature,
             min(air_humidity) AS min_air_humidity,
             max(air_humidity) AS max_air_humidity,
             avg(air_humidity) AS avg_air_humidity,
             median(air_humidity) AS median_air_humidity,
             varPop(air_humidity) AS var_air_humidity,
             min(wind_speed) AS min_wind_speed,
             max(wind_speed) AS max_wind_speed,
             avg(wind_speed) AS avg_wind_speed,
             median(wind_speed) AS median_wind_speed,
             varPop(wind_speed) AS var_wind_speed,
             min(illuminance) AS min_illuminance,
             max(illuminance) AS max_illuminance,
             avg(illuminance) AS avg_illuminance,
             median(illuminance) AS median_illuminance,
             varPop(illuminance) AS var_illuminance,
             toFloat64(sum(is_raining)) AS avg_rains
      FROM sensor_values
      WHERE timestamp BETWEEN ? AND ? ${coordinate_intervals}
      GROUP BY latitude, longitude, altitude, ${timestamp_rounding_function}(timestamp) AS timestamp_rounded
      UNION ALL
      SELECT NULL AS latitude, NULL AS longitude, NULL AS altitude, timestamp_rounded,
          min(air_temperature) AS min_air_temperature,
          max(air_temperature) AS max_air_temperature,
          avg(air_temperature) AS avg_air_temperature,
          median(air_temperature) AS median_air_temperature,
          varPop(air_temperature) AS var_air_temperature,
          min(air_humidity) AS min_air_humidity,
          max(air_humidity) AS max_air_humidity,
          avg(air_humidity) AS avg_air_humidity,
          median(air_humidity) AS median_air_humidity,
          varPop(air_humidity) AS var_air_humidity,
          min(wind_speed) AS min_wind_speed,
          max(wind_speed) AS max_wind_speed,
          avg(wind_speed) AS avg_wind_speed,
          median(wind_speed) AS median_wind_speed,
          varPop(wind_speed) AS var_wind_speed,
          min(illuminance) AS min_illuminance,
          max(illuminance) AS max_illuminance,
          avg(illuminance) AS avg_illuminance,
          median(illuminance) AS median_illuminance,
          varPop(illuminance) AS var_illuminance,
          (SELECT avg(rains) FROM (SELECT sum(is_raining) AS rains
                                   FROM sensor_values
                                   WHERE timestamp BETWEEN ? AND ? ${coordinate_intervals}
                                   GROUP BY latitude, longitude, altitude,
                                   ${timestamp_rounding_function}(timestamp))) AS avg_rains
      FROM (SELECT timestamp, air_temperature, air_humidity, wind_speed, is_raining, illuminance
            FROM sensor_values
            WHERE timestamp BETWEEN ? AND ? ${coordinate_intervals})
      GROUP BY ${timestamp_rounding_function}(timestamp) AS timestamp_rounded)
ORDER BY latitude, longitude, altitude, timestamp_rounded;
