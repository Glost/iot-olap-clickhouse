package com.iotolapclickhouse.server.model.response;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.iotolapclickhouse.server.model.Coordinates;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.Objects;

public class SensorAggregatedValues {

    @Valid
    private final Coordinates coordinates;

    @NotNull
    @Valid
    private final AggregatedValues aggregatedValues;

    @JsonCreator
    public SensorAggregatedValues(@JsonProperty("coordinates") Coordinates coordinates,
                                  @JsonProperty("aggregated_values") AggregatedValues aggregatedValues) {
        this.coordinates = coordinates;
        this.aggregatedValues = aggregatedValues;
    }

    public Coordinates getCoordinates() {
        return coordinates;
    }

    public AggregatedValues getAggregatedValues() {
        return aggregatedValues;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        SensorAggregatedValues that = (SensorAggregatedValues) o;
        return Objects.equals(coordinates, that.coordinates) &&
                Objects.equals(aggregatedValues, that.aggregatedValues);
    }

    @Override
    public int hashCode() {
        return Objects.hash(coordinates, aggregatedValues);
    }

    @Override
    public String toString() {
        return "SensorAggregatedValues{" +
                "coordinates=" + coordinates +
                ", aggregatedValues=" + aggregatedValues +
                '}';
    }
}
