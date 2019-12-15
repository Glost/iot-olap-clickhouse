package com.iotolapclickhouse.server.service;

import com.google.common.base.Throwables;
import com.google.common.collect.ImmutableMap;
import com.google.common.primitives.Doubles;
import com.iotolapclickhouse.server.exception.SensorValuesClickHouseException;
import com.iotolapclickhouse.server.model.Coordinates;
import com.iotolapclickhouse.server.model.entity.SensorValues;
import com.iotolapclickhouse.server.model.entity.SensorValuesKey;
import com.iotolapclickhouse.server.model.request.AggregatedPeriod;
import com.iotolapclickhouse.server.model.request.CoordinateInterval;
import com.iotolapclickhouse.server.model.request.GetAggregatedDataRequest;
import com.iotolapclickhouse.server.model.request.TimestampInterval;
import com.iotolapclickhouse.server.model.response.AggregatedRainValue;
import com.iotolapclickhouse.server.model.response.AggregatedValue;
import com.iotolapclickhouse.server.model.response.AggregatedValues;
import com.iotolapclickhouse.server.model.response.GetAggregatedDataResponse;
import com.iotolapclickhouse.server.model.response.SensorAggregatedValues;
import com.iotolapclickhouse.server.util.DateTimeUtil;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.yandex.clickhouse.ClickHouseConnection;
import ru.yandex.clickhouse.ClickHousePreparedStatement;
import ru.yandex.clickhouse.ClickHouseStatement;
import ru.yandex.clickhouse.domain.ClickHouseFormat;
import ru.yandex.clickhouse.response.ClickHouseResponse;
import ru.yandex.clickhouse.util.ClickHouseRowBinaryStream;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class SensorValuesClickHouseService {

    private static final Logger log = LoggerFactory.getLogger(SensorValuesClickHouseService.class);

    private static final String CREATE_TABLE_SQL_PATH = "/db/clickhouse/create-sensor-values-table.sql";
    private static final String INSERT_INTO_SQL_PATH = "/db/clickhouse/insert-into-sensor-values.sql";
    private static final String SELECT_SPLIT_FRAME_SQL_PATH = "/db/clickhouse/select-split-aggregated-data-frame.sql";
    private static final String SELECT_TOTAL_FRAME_SQL_PATH = "/db/clickhouse/select-total-aggregated-data-frame.sql";
    private static final String COORDINATE_INTERVAL_SQL_PATH = "/db/clickhouse/coordinate-interval.sql";

    private static final String COORDINATE_INTERVALS_PLACEHOLDER = "${coordinate_intervals}";
    private static final String TIMESTAMP_ROUNDING_FUNCTION_PLACEHOLDER = "${timestamp_rounding_function}";
    private static final String COORDINATE_PLACEHOLDER = "${coordinate}";

    private static final String LATITUDE_COORDINATE = "latitude";
    private static final String LONGITUDE_COORDINATE = "longitude";
    private static final String ALTITUDE_COORDINATE = "altitude";

    private static final Map<AggregatedPeriod, String> AGGREGATED_PERIODS_FUNCTION_NAMES_MAP = ImmutableMap.of(
            AggregatedPeriod.MINUTE, "toStartOfMinute",
            AggregatedPeriod.HOUR, "toStartOfHour",
            AggregatedPeriod.DAY, "toStartOfDay"
    );

    private static final int COORDINATES_COUNT = 3;
    private static final int AGGREGATES_COUNT = 21;

    private final ClickHouseConnection clickHouseConnection;

    private final String createTableSql;
    private final String insertIntoSql;
    private final String selectSplitSql;
    private final String selectTotalSql;
    private final String coordinateIntervalSql;

    @Autowired
    public SensorValuesClickHouseService(ClickHouseConnection clickHouseConnection) {
        this.clickHouseConnection = clickHouseConnection;

        this.createTableSql = readSql(CREATE_TABLE_SQL_PATH);
        this.insertIntoSql = readSql(INSERT_INTO_SQL_PATH);
        this.selectSplitSql = readSql(SELECT_SPLIT_FRAME_SQL_PATH);
        this.selectTotalSql = readSql(SELECT_TOTAL_FRAME_SQL_PATH);
        this.coordinateIntervalSql = readSql(COORDINATE_INTERVAL_SQL_PATH);
    }

    public int pushDataToClickHouse(Collection<SensorValues> data) throws SQLException {
        createTableIfNotExists();

        ClickHouseStatement statement = clickHouseConnection.createStatement();

        long startTime = System.currentTimeMillis();

        statement.write().send(insertIntoSql,
                stream -> writeDataToClickHouseRowBinaryStream(data, stream),
                ClickHouseFormat.RowBinary);

        long endTime = System.currentTimeMillis();

        return (int) (endTime - startTime);
    }

    public GetAggregatedDataResponse getAggregatedDataFromClickHouse(GetAggregatedDataRequest request)
            throws SQLException {
        String selectFrameSql = request.getNeedSplitByCoordinates() ? selectSplitSql : selectTotalSql;

        String selectSql = replacePlaceholders(selectFrameSql, request);

        ClickHousePreparedStatement preparedStatement =
                (ClickHousePreparedStatement) clickHouseConnection.prepareStatement(selectSql);
        setPreparedStatementParameters(preparedStatement, request);

        long startTime = System.currentTimeMillis();

        ClickHouseResponse clickHouseResponse = preparedStatement.executeQueryClickhouseResponse();

        long endTime = System.currentTimeMillis();

        int time = (int) (endTime - startTime);

        return convertResponse(clickHouseResponse, time, request.getNeedSplitByCoordinates());
    }

    private void createTableIfNotExists() throws SQLException {
        ClickHouseStatement statement = clickHouseConnection.createStatement();
        statement.execute(createTableSql);
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

    private String replacePlaceholders(String selectFrameSql, GetAggregatedDataRequest request) {
        String coordinateIntervalsSql =
                buildCoordinateConstraints(request.getLatitudeIntervals(), LATITUDE_COORDINATE) +
                buildCoordinateConstraints(request.getLongitudeIntervals(), LONGITUDE_COORDINATE) +
                buildCoordinateConstraints(request.getAltitudeIntervals(), ALTITUDE_COORDINATE);

        return selectFrameSql
                .replace(COORDINATE_INTERVALS_PLACEHOLDER, coordinateIntervalsSql)
                .replace(TIMESTAMP_ROUNDING_FUNCTION_PLACEHOLDER, AGGREGATED_PERIODS_FUNCTION_NAMES_MAP.get(
                        request.getAggregatedPeriod()));
    }

    private String buildCoordinateConstraints(Collection<CoordinateInterval> coordinateIntervals,
                                              String coordinateName) {
        return Optional.of(CollectionUtils.emptyIfNull(coordinateIntervals).stream()
                .map(coordinateInterval -> coordinateIntervalSql.replace(COORDINATE_PLACEHOLDER, coordinateName))
                .collect(Collectors.joining(" OR ")))
                .filter(s -> !s.isEmpty())
                .map(s -> " AND (" + s + ")")
                .orElse("");
    }

    private void setPreparedStatementParameters(ClickHousePreparedStatement preparedStatement,
                                                GetAggregatedDataRequest request) throws SQLException {
        int i = 1;

        i = setPreparedStatementParametersBlock(preparedStatement, request, i);
        i = setPreparedStatementParametersBlock(preparedStatement, request, i);

        if (request.getNeedSplitByCoordinates()) {
            setPreparedStatementParametersBlock(preparedStatement, request, i);
        }
    }

    private int setPreparedStatementParametersBlock(ClickHousePreparedStatement preparedStatement,
                                                    GetAggregatedDataRequest request,
                                                    int i) throws SQLException {
        TimestampInterval timestampInterval = request.getTimestampInterval();

        preparedStatement.setTimestamp(i++, Timestamp.from(timestampInterval.getFrom().toInstant()));
        preparedStatement.setTimestamp(i++, Timestamp.from(timestampInterval.getTo().toInstant()));

        i = setPreparedStatementsParametersForCoordinateIntervals(preparedStatement, request.getLatitudeIntervals(), i);
        i = setPreparedStatementsParametersForCoordinateIntervals(preparedStatement,
                request.getLongitudeIntervals(), i);
        i = setPreparedStatementsParametersForCoordinateIntervals(preparedStatement, request.getAltitudeIntervals(), i);

        return i;
    }

    private int setPreparedStatementsParametersForCoordinateIntervals(ClickHousePreparedStatement preparedStatement,
            Collection<CoordinateInterval> coordinateIntervals,
            int i) throws SQLException {
        for (CoordinateInterval coordinateInterval : CollectionUtils.emptyIfNull(coordinateIntervals)) {
            preparedStatement.setDouble(i++, coordinateInterval.getFrom());
            preparedStatement.setDouble(i++, coordinateInterval.getTo());
        }

        return i;
    }

    private GetAggregatedDataResponse convertResponse(ClickHouseResponse clickHouseResponse,
                                                      int time,
                                                      boolean isSplit) {
        return new GetAggregatedDataResponse(
                true,
                null,
                time,
                convertSensorAggregatedValues(clickHouseResponse, isSplit)
        );
    }

    private Collection<SensorAggregatedValues> convertSensorAggregatedValues(ClickHouseResponse clickHouseResponse,
                                                                             boolean isSplit) {
        Collection<SensorAggregatedValues> sensorAggregatedValues = new ArrayList<>();

        Coordinates currentCoordinates = null;
        SensorAggregatedValues currentSensorAggregatedValuesElement = null;

        for (List<String> dataRow : CollectionUtils.emptyIfNull(clickHouseResponse.getData())) {
            int expectedDataRowSize = AGGREGATES_COUNT + 1 + (isSplit ? COORDINATES_COUNT : 0);

            if (dataRow == null || dataRow.size() != expectedDataRowSize) {
                throw new SensorValuesClickHouseException("Data row size was invalid or data row was null");
            }

            int i = isSplit ? COORDINATES_COUNT : 0;

            Coordinates coordinates = null;

            if (isSplit && dataRow.get(0) != null) {
                i = 0;

                coordinates = new Coordinates(
                        parseDouble(dataRow.get(i++), "latitude"),
                        parseDouble(dataRow.get(i++), "longitude"),
                        parseDouble(dataRow.get(i++), "altitude")
                );
            }

            if (!Objects.equals(coordinates, currentCoordinates)) {
                currentCoordinates = coordinates;

                if (Objects.nonNull(currentSensorAggregatedValuesElement)) {
                    sensorAggregatedValues.add(currentSensorAggregatedValuesElement);
                }

                currentSensorAggregatedValuesElement = createSensorAggregatedValues(currentCoordinates);
            }

            if (Objects.isNull(currentSensorAggregatedValuesElement)) {
                currentSensorAggregatedValuesElement = createSensorAggregatedValues(currentCoordinates);
            }

            OffsetDateTime timestamp = LocalDateTime.parse(dataRow.get(i++),
                    DateTimeUtil.DATE_TIME_CLICKHOUSE_FORMATTER)
                    .atZone(clickHouseConnection.getTimeZone().toZoneId())
                    .toOffsetDateTime();

            AggregatedValues aggregatedValues = currentSensorAggregatedValuesElement.getAggregatedValues();

            i = createAndAddAggregatedValue(
                    aggregatedValues.getAirTemperature(), timestamp, dataRow, i, "air_temperature");
            i = createAndAddAggregatedValue(
                    aggregatedValues.getAirHumidity(), timestamp, dataRow, i, "air_humidity");
            i = createAndAddAggregatedValue(
                    aggregatedValues.getWindSpeed(), timestamp, dataRow, i, "wind_speed");
            i = createAndAddAggregatedValue(
                    aggregatedValues.getIlluminance(), timestamp, dataRow, i, "illuminance");

            AggregatedRainValue aggregatedRainValue =
                    new AggregatedRainValue(timestamp, parseDouble(dataRow.get(i), "avg_rains"));
            aggregatedValues.getAvgRainsValues().add(aggregatedRainValue);
        }

        if (Objects.nonNull(currentSensorAggregatedValuesElement)) {
            sensorAggregatedValues.add(currentSensorAggregatedValuesElement);
        }

        return Optional.of(sensorAggregatedValues)
                .filter(c -> !c.isEmpty())
                .orElse(null);
    }

    private SensorAggregatedValues createSensorAggregatedValues(Coordinates coordinates) {
        AggregatedValues aggregatedValues = new AggregatedValues(
                new ArrayList<>(),
                new ArrayList<>(),
                new ArrayList<>(),
                new ArrayList<>(),
                new ArrayList<>()
        );

        return new SensorAggregatedValues(coordinates, aggregatedValues);
    }

    private int createAndAddAggregatedValue(Collection<AggregatedValue> aggregatedValues,
                                            OffsetDateTime timestamp,
                                            List<String> dataRow,
                                            int i,
                                            String valueName) {
        AggregatedValue aggregatedValue = new AggregatedValue(
                timestamp,
                parseDouble(dataRow.get(i++), "min_" + valueName),
                parseDouble(dataRow.get(i++), "max_" + valueName),
                parseDouble(dataRow.get(i++), "avg_" + valueName),
                parseDouble(dataRow.get(i++), "median_" + valueName),
                parseDouble(dataRow.get(i++), "var_" + valueName)
        );

        aggregatedValues.add(aggregatedValue);

        return i;
    }

    @SuppressWarnings("UnstableApiUsage")
    private Double parseDouble(String doubleString, String name) {
        return Optional.ofNullable(doubleString)
                .map(Doubles::tryParse)
                .orElseThrow(() -> new SensorValuesClickHouseException(name + " from ClickHouse was invalid or null"));
    }

    private String readSql(String sqlPath) {
        try {
            InputStream inputStream = Optional.ofNullable(SensorValuesClickHouseService.class
                    .getResourceAsStream(sqlPath))
                    .orElseThrow(() -> new FileNotFoundException("The resource " + sqlPath + " was not found"));
            return IOUtils.toString(inputStream, StandardCharsets.UTF_8);
        } catch (IOException e) {
            throw new IllegalStateException("Exception while reading the ClickHouse SQL script file " + sqlPath, e);
        }
    }
}
