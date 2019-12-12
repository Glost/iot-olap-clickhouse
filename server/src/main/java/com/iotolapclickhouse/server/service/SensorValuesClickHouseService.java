package com.iotolapclickhouse.server.service;

import com.google.common.base.Throwables;
import com.iotolapclickhouse.server.exception.SensorValuesClickHouseException;
import com.iotolapclickhouse.server.model.entity.SensorValues;
import com.iotolapclickhouse.server.model.entity.SensorValuesKey;
import com.iotolapclickhouse.server.model.request.GetAggregatedDataRequest;
import com.iotolapclickhouse.server.model.response.GetAggregatedDataResponse;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.yandex.clickhouse.ClickHouseConnection;
import ru.yandex.clickhouse.ClickHouseStatement;
import ru.yandex.clickhouse.domain.ClickHouseFormat;
import ru.yandex.clickhouse.util.ClickHouseRowBinaryStream;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Date;
import java.util.Optional;

@Service
public class SensorValuesClickHouseService {

    private static final Logger log = LoggerFactory.getLogger(SensorValuesClickHouseService.class);

    private static final String CREATE_TABLE_SQL_PATH = "db/clickhouse/create-sensor-values-table.sql";

    private static final String INSERT_INTO_SQL_PATH = "db/clickhouse/insert-into-sensor-values.sql";

    private final ClickHouseConnection clickHouseConnection;

    @Autowired
    public SensorValuesClickHouseService(ClickHouseConnection clickHouseConnection) {
        this.clickHouseConnection = clickHouseConnection;
    }

    public int pushDataToClickHouse(Collection<SensorValues> data) throws SQLException {
        createTableIfNotExists();

        ClickHouseStatement statement = clickHouseConnection.createStatement();

        String sql = readSql(INSERT_INTO_SQL_PATH);

        long startTime = System.currentTimeMillis();

        statement.write().send(sql,
                stream -> writeDataToClickHouseRowBinaryStream(data, stream),
                ClickHouseFormat.RowBinary);

        long endTime = System.currentTimeMillis();

        return (int) (endTime - startTime);
    }

    public GetAggregatedDataResponse getAggregatedDataFromClickHouse(GetAggregatedDataRequest request)
            throws SQLException {
        throw new UnsupportedOperationException("Not implemented yet."); // TODO: implement.
    }

    private void createTableIfNotExists() throws SQLException {
        ClickHouseStatement statement = clickHouseConnection.createStatement();
        statement.execute(readSql(CREATE_TABLE_SQL_PATH));
    }

    private void writeDataToClickHouseRowBinaryStream(Collection<SensorValues> data, ClickHouseRowBinaryStream stream) {
        data.forEach(sensorValues -> writeSensorValuesToClickHouseRowBinaryStream(sensorValues, stream));
    }

    private void writeSensorValuesToClickHouseRowBinaryStream(SensorValues sensorValues,
                                                              ClickHouseRowBinaryStream stream) {
        try {
            SensorValuesKey key = sensorValues.getKey();

            stream.writeFloat64(key.getLatitude());
            stream.writeFloat64(key.getLongitude());
            stream.writeFloat64(key.getAltitude());
            stream.writeDateTime(Date.from(key.getTimestamp().toInstant()));
            stream.writeFloat64(sensorValues.getAirTemperature());
            stream.writeFloat64(sensorValues.getAirHumidity());
            stream.writeFloat64(sensorValues.getWindSpeed());
            stream.writeUInt8(sensorValues.getRaining());
            stream.writeFloat64(sensorValues.getIlluminance());
        } catch (IOException e) {
            log.error("The IOException while writing into the ClickHouseRowBinaryStream occured {}",
                    Throwables.getStackTraceAsString(e));
            throw new SensorValuesClickHouseException(
                    "The IOException while writing into the ClickHouseRowBinaryStream occured", e);
        }
    }

    private String readSql(String sqlPath) {
        try {
            InputStream inputStream = Optional.ofNullable(ClassLoader.getSystemResourceAsStream(sqlPath))
                    .orElseThrow(() -> new FileNotFoundException("The resource " + sqlPath + " was not found"));
            return IOUtils.toString(inputStream, StandardCharsets.UTF_8);
        } catch (IOException e) {
            throw new IllegalStateException("Exception while reading the ClickHouse SQL script file " + sqlPath, e);
        }
    }
}
