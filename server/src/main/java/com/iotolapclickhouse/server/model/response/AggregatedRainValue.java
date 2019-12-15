package com.iotolapclickhouse.server.model.response;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.iotolapclickhouse.server.util.DateTimeUtil;

import javax.validation.constraints.NotNull;
import java.time.OffsetDateTime;
import java.util.Objects;

public class AggregatedRainValue {

    @NotNull
    @JsonFormat(pattern = DateTimeUtil.DATE_TIME_RESPONSE_PATTERN)
    private final OffsetDateTime timestamp;

    @NotNull
    private final Double avgRains;

    @JsonCreator
    public AggregatedRainValue(@JsonProperty("timestamp") OffsetDateTime timestamp,
                               @JsonProperty("avg_rains") Double avgRains) {
        this.timestamp = timestamp;
        this.avgRains = avgRains;
    }

    public OffsetDateTime getTimestamp() {
        return timestamp;
    }

    public Double getAvgRains() {
        return avgRains;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        AggregatedRainValue that = (AggregatedRainValue) o;
        return Objects.equals(timestamp, that.timestamp) &&
                Objects.equals(avgRains, that.avgRains);
    }

    @Override
    public int hashCode() {
        return Objects.hash(timestamp, avgRains);
    }

    @Override
    public String toString() {
        return "AggregatedRainValue{" +
                "timestamp=" + timestamp +
                ", avgRains=" + avgRains +
                '}';
    }
}
