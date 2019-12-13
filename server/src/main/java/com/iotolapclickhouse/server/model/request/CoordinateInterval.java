package com.iotolapclickhouse.server.model.request;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.validation.constraints.NotNull;
import java.util.Objects;

public class CoordinateInterval {

    @NotNull
    private final Double from;

    @NotNull
    private final Double to;

    @JsonCreator
    public CoordinateInterval(@JsonProperty("from") Double from,
                              @JsonProperty("to") Double to) {
        this.from = from;
        this.to = to;
    }

    public Double getFrom() {
        return from;
    }

    public Double getTo() {
        return to;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        CoordinateInterval that = (CoordinateInterval) o;
        return Objects.equals(from, that.from) &&
                Objects.equals(to, that.to);
    }

    @Override
    public int hashCode() {
        return Objects.hash(from, to);
    }

    @Override
    public String toString() {
        return "CoordinateInterval{" +
                "from=" + from +
                ", to=" + to +
                '}';
    }
}
