package com.iotolapclickhouse.server.model.response;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.iotolapclickhouse.server.util.DateTimeUtil;

import javax.validation.constraints.NotNull;
import java.time.OffsetDateTime;
import java.util.Objects;

public class AggregatedValue {

    @NotNull
    @JsonFormat(pattern = DateTimeUtil.DATE_TIME_RESPONSE_PATTERN)
    private final OffsetDateTime timestamp;

    @NotNull
    private final Double min;

    @NotNull
    private final Double max;

    @NotNull
    private final Double avg;

    @NotNull
    private final Double median;

    @NotNull
    private final Double variance;

    @JsonCreator
    public AggregatedValue(@JsonProperty("timestamp") OffsetDateTime timestamp,
                           @JsonProperty("min") Double min,
                           @JsonProperty("max") Double max,
                           @JsonProperty("avg") Double avg,
                           @JsonProperty("median") Double median,
                           @JsonProperty("variance") Double variance) {
        this.timestamp = timestamp;
        this.min = min;
        this.max = max;
        this.avg = avg;
        this.median = median;
        this.variance = variance;
    }

    public OffsetDateTime getTimestamp() {
        return timestamp;
    }

    public Double getMin() {
        return min;
    }

    public Double getMax() {
        return max;
    }

    public Double getAvg() {
        return avg;
    }

    public Double getMedian() {
        return median;
    }

    public Double getVariance() {
        return variance;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        AggregatedValue that = (AggregatedValue) o;
        return Objects.equals(timestamp, that.timestamp) &&
                Objects.equals(min, that.min) &&
                Objects.equals(max, that.max) &&
                Objects.equals(avg, that.avg) &&
                Objects.equals(median, that.median) &&
                Objects.equals(variance, that.variance);
    }

    @Override
    public int hashCode() {
        return Objects.hash(timestamp, min, max, avg, median, variance);
    }

    @Override
    public String toString() {
        return "AggregatedValue{" +
                "timestamp=" + timestamp +
                ", min=" + min +
                ", max=" + max +
                ", avg=" + avg +
                ", median=" + median +
                ", variance=" + variance +
                '}';
    }
}
