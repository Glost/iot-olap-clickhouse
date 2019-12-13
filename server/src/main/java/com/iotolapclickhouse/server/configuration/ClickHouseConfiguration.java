package com.iotolapclickhouse.server.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import ru.yandex.clickhouse.ClickHouseConnection;
import ru.yandex.clickhouse.ClickHouseDataSource;

import java.sql.SQLException;

@Configuration
public class ClickHouseConfiguration {

    private final String clickHouseUrl;

    private final String clickHouseUsername;

    private final String clickHousePassword;

    public ClickHouseConfiguration(@Value("${clickHouse.url}") String clickHouseUrl,
                                   @Value("${clickHouse.username}") String clickHouseUsername,
                                   @Value("${clickHouse.password}") String clickHousePassword) {
        this.clickHouseUrl = clickHouseUrl;
        this.clickHouseUsername = clickHouseUsername;
        this.clickHousePassword = clickHousePassword;
    }

    @Bean
    public ClickHouseConnection clickHouseConnection() throws SQLException {
        return clickHouseDataSource().getConnection(clickHouseUsername, clickHousePassword);
    }

    private ClickHouseDataSource clickHouseDataSource() {
        return new ClickHouseDataSource(clickHouseUrl);
    }
}
