package com.iotolapclickhouse.server.configuration;

import com.iotolapclickhouse.server.service.SensorValuesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

@Configuration
@EnableScheduling
public class SchedulerConfiguration {

    private static final String DEFAULT_PUSH_DATA_TO_CLICK_HOUSE_CRON = "0 0 * * * *";

    private final SensorValuesService sensorValuesService;

    @Autowired
    public SchedulerConfiguration(SensorValuesService sensorValuesService) {
        this.sensorValuesService = sensorValuesService;
    }

    @Scheduled(cron = "${scheduled.pushDataToClickHouse.cron:" + DEFAULT_PUSH_DATA_TO_CLICK_HOUSE_CRON + "}")
    public void pushDataToClickHouse() {
        sensorValuesService.pushDataToClickHouse();
    }
}
