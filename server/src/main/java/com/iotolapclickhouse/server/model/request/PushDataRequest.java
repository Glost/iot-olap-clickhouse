package com.iotolapclickhouse.server.model.request;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.iotolapclickhouse.server.model.Coordinates;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.time.OffsetDateTime;
import java.util.Objects;

public class PushDataRequest {

    @NotNull
    @Valid
    private final Coordinates coordinates;

    @NotNull
    @Valid
    private final Values values;

    @NotNull
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSSZ")
    private final OffsetDateTime timestamp;

    @JsonCreator
    public PushDataRequest(@JsonProperty("coordinates") Coordinates coordinates,
                           @JsonProperty("values") Values values,
                           @JsonProperty("timestamp") OffsetDateTime timestamp) {
        this.coordinates = coordinates;
        this.values = values;
        this.timestamp = timestamp;
    }

    public Coordinates getCoordinates() {
        return coordinates;
    }

    public Values getValues() {
        return values;
    }

    public OffsetDateTime getTimestamp() {
        return timestamp;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        PushDataRequest that = (PushDataRequest) o;
        return Objects.equals(coordinates, that.coordinates) &&
                Objects.equals(values, that.values) &&
                Objects.equals(timestamp, that.timestamp);
    }

    @Override
    public int hashCode() {
        return Objects.hash(coordinates, values, timestamp);
    }

    @Override
    public String toString() {
        return "PushDataRequest{" +
                "coordinates=" + coordinates +
                ", values=" + values +
                ", timestamp=" + timestamp +
                '}';
    }
}
