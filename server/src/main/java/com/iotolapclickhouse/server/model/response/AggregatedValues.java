package com.iotolapclickhouse.server.model.response;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.Collection;
import java.util.Objects;

public class AggregatedValues {

    @NotEmpty
    @Valid
    private final Collection<@NotNull AggregatedValue> airTemperature;

    @NotEmpty
    @Valid
    private final Collection<@NotNull AggregatedValue> airHumidity;

    @NotEmpty
    @Valid
    private final Collection<@NotNull AggregatedValue> windSpeed;

    @NotEmpty
    @Valid
    private final Collection<@NotNull AggregatedValue> illuminance;

    @NotEmpty
    @Valid
    private final Collection<@NotNull AggregatedRainValue> avgRainsValues;

    @JsonCreator
    public AggregatedValues(@JsonProperty("air_temperature") Collection<AggregatedValue> airTemperature,
                            @JsonProperty("air_humidity") Collection<AggregatedValue> airHumidity,
                            @JsonProperty("wind_speed") Collection<AggregatedValue> windSpeed,
                            @JsonProperty("illuminance") Collection<AggregatedValue> illuminance,
                            @JsonProperty("avg_rains_values") Collection<AggregatedRainValue> avgRainsValues) {
        this.airTemperature = airTemperature;
        this.airHumidity = airHumidity;
        this.windSpeed = windSpeed;
        this.illuminance = illuminance;
        this.avgRainsValues = avgRainsValues;
    }

    public Collection<AggregatedValue> getAirTemperature() {
        return airTemperature;
    }

    public Collection<AggregatedValue> getAirHumidity() {
        return airHumidity;
    }

    public Collection<AggregatedValue> getWindSpeed() {
        return windSpeed;
    }

    public Collection<AggregatedValue> getIlluminance() {
        return illuminance;
    }

    public Collection<AggregatedRainValue> getAvgRainsValues() {
        return avgRainsValues;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        AggregatedValues that = (AggregatedValues) o;
        return Objects.equals(airTemperature, that.airTemperature) &&
                Objects.equals(airHumidity, that.airHumidity) &&
                Objects.equals(windSpeed, that.windSpeed) &&
                Objects.equals(illuminance, that.illuminance) &&
                Objects.equals(avgRainsValues, that.avgRainsValues);
    }

    @Override
    public int hashCode() {
        return Objects.hash(airTemperature, airHumidity, windSpeed, illuminance, avgRainsValues);
    }

    @Override
    public String toString() {
        return "AggregatedValues{" +
                "airTemperature=" + airTemperature +
                ", airHumidity=" + airHumidity +
                ", windSpeed=" + windSpeed +
                ", illuminance=" + illuminance +
                ", avgRainsValues=" + avgRainsValues +
                '}';
    }
}
