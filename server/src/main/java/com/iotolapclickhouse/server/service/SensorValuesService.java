package com.iotolapclickhouse.server.service;

import com.google.common.base.Throwables;
import com.iotolapclickhouse.server.exception.SensorValuesClickHouseException;
import com.iotolapclickhouse.server.exception.SensorValuesException;
import com.iotolapclickhouse.server.model.Coordinates;
import com.iotolapclickhouse.server.model.entity.ScheduledPushingDataToClickHouseLog;
import com.iotolapclickhouse.server.model.entity.SensorValues;
import com.iotolapclickhouse.server.model.entity.SensorValuesKey;
import com.iotolapclickhouse.server.model.request.GetAggregatedDataRequest;
import com.iotolapclickhouse.server.model.request.PushDataRequest;
import com.iotolapclickhouse.server.model.request.Values;
import com.iotolapclickhouse.server.model.response.GetAggregatedDataResponse;
import com.iotolapclickhouse.server.repository.ScheduledPushingDataToClickHouseLogRepository;
import com.iotolapclickhouse.server.repository.SensorValuesRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.time.OffsetDateTime;
import java.util.Collection;

@Service
public class SensorValuesService {

    private static final Logger log = LoggerFactory.getLogger(SensorValuesService.class);

    private final SensorValuesRepository repository;

    private final ScheduledPushingDataToClickHouseLogRepository logRepository;

    private final SensorValuesClickHouseService clickHouseService;

    @Autowired
    public SensorValuesService(SensorValuesRepository repository,
                               ScheduledPushingDataToClickHouseLogRepository logRepository,
                               SensorValuesClickHouseService clickHouseService) {
        this.repository = repository;
        this.logRepository = logRepository;
        this.clickHouseService = clickHouseService;
    }

    @Transactional
    public void pushData(PushDataRequest request) {
        log.info("Handling PushDataRequest: {}", request);
        SensorValues sensorValues = convertSensorValues(request);
        log.info("Saving sensorValues: {}", sensorValues);

        if (repository.existsById(sensorValues.getKey())) {
            log.error("sensorValues with key {} already exists", sensorValues.getKey());
            throw new SensorValuesException("sensorValues with such coordinates and timestamp already exists");
        }

        repository.save(sensorValues);
    }

    public GetAggregatedDataResponse getAggregatedData(GetAggregatedDataRequest request) {
        log.info("Handling GetAggregatedDataRequest: {}", request);

        try {
            return clickHouseService.getAggregatedDataFromClickHouse(request);
        } catch (SQLException e) {
            log.error("The ClickHouse SQLException thrown {}", Throwables.getStackTraceAsString(e));
            throw new SensorValuesClickHouseException("The ClickHouse SQLException thrown", e);
        }
    }

    @Transactional
    public void pushDataToClickHouse() {
        OffsetDateTime timestamp = OffsetDateTime.now();

        log.info("Pushing data to ClickHouse...");
        Collection<SensorValues> data = repository.findAll();

        if (data.isEmpty()) {
            log.warn("No new data to be pushed to ClickHouse found");
            return;
        }

        log.info("Data to be pushed to ClickHouse: {}", data);

        try {
            int queryDuration = clickHouseService.pushDataToClickHouse(data);
            log.info("Data is pushed to ClickHouse, now will be deleted from the OLTP DB: {}", data);
            repository.deleteAll(data);

            ScheduledPushingDataToClickHouseLog logEntry =
                    new ScheduledPushingDataToClickHouseLog(timestamp, data.size(), queryDuration);
            logRepository.save(logEntry);
        } catch (SQLException e) {
            log.error("The ClickHouse SQLException thrown {}", Throwables.getStackTraceAsString(e));
            throw new SensorValuesClickHouseException("The ClickHouse SQLException thrown", e);
        }
    }

    private SensorValues convertSensorValues(PushDataRequest request) {
        Values values = request.getValues();

        return new SensorValues()
                .setKey(convertKey(request))
                .setAirTemperature(values.getAirTemperature())
                .setAirHumidity(values.getAirHumidity())
                .setWindSpeed(values.getWindSpeed())
                .setRaining(values.getRaining())
                .setIlluminance(values.getIlluminance());
    }

    private SensorValuesKey convertKey(PushDataRequest request) {
        Coordinates coordinates = request.getCoordinates();

        return new SensorValuesKey(
                coordinates.getLatitude(),
                coordinates.getLongitude(),
                coordinates.getAltitude(),
                request.getTimestamp()
        );
    }
}
