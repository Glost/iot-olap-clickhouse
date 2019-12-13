package com.iotolapclickhouse.server.model.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.time.OffsetDateTime;
import java.util.Objects;

@Entity
@Table(name = "scheduled_pushing_data_to_clickhouse_log")
public class ScheduledPushingDataToClickHouseLog {

    @Id
    private OffsetDateTime timestamp;

    private Integer pushedRowsCount;

    @Column(name = "clickhouse_query_duration")
    private Integer clickHouseQueryDuration;

    public ScheduledPushingDataToClickHouseLog() {
    }

    public ScheduledPushingDataToClickHouseLog(OffsetDateTime timestamp,
                                               Integer pushedRowsCount,
                                               Integer clickHouseQueryDuration) {
        this.timestamp = timestamp;
        this.pushedRowsCount = pushedRowsCount;
        this.clickHouseQueryDuration = clickHouseQueryDuration;
    }

    public OffsetDateTime getTimestamp() {
        return timestamp;
    }

    public ScheduledPushingDataToClickHouseLog setTimestamp(OffsetDateTime timestamp) {
        this.timestamp = timestamp;
        return this;
    }

    public Integer getPushedRowsCount() {
        return pushedRowsCount;
    }

    public ScheduledPushingDataToClickHouseLog setPushedRowsCount(Integer pushedRowsCount) {
        this.pushedRowsCount = pushedRowsCount;
        return this;
    }

    public Integer getClickHouseQueryDuration() {
        return clickHouseQueryDuration;
    }

    public ScheduledPushingDataToClickHouseLog setClickHouseQueryDuration(Integer clickHouseQueryDuration) {
        this.clickHouseQueryDuration = clickHouseQueryDuration;
        return this;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        ScheduledPushingDataToClickHouseLog that = (ScheduledPushingDataToClickHouseLog) o;
        return Objects.equals(timestamp, that.timestamp) &&
                Objects.equals(pushedRowsCount, that.pushedRowsCount) &&
                Objects.equals(clickHouseQueryDuration, that.clickHouseQueryDuration);
    }

    @Override
    public int hashCode() {
        return Objects.hash(timestamp, pushedRowsCount, clickHouseQueryDuration);
    }

    @Override
    public String toString() {
        return "ScheduledPushingDataToClickHouseLog{" +
                "timestamp=" + timestamp +
                ", pushedRowsCount=" + pushedRowsCount +
                ", clickHouseQueryDuration=" + clickHouseQueryDuration +
                '}';
    }
}
