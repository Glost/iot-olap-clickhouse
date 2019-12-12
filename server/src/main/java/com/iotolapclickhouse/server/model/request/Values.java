package com.iotolapclickhouse.server.model.request;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.validation.constraints.NotNull;
import java.util.Objects;

public class Values {

    @NotNull
    private final Double airTemperature;

    @NotNull
    private final Double airHumidity;

    @NotNull
    private final Double windSpeed;

    @NotNull
    private final Boolean isRaining;

    @NotNull
    private final Double illuminance;

    @JsonCreator
    public Values(@JsonProperty("air_temperature") Double airTemperature,
                  @JsonProperty("air_humidity") Double airHumidity,
                  @JsonProperty("wind_speed") Double windSpeed,
                  @JsonProperty("is_raining") Boolean isRaining,
                  @JsonProperty("illuminance") Double illuminance) {
        this.airTemperature = airTemperature;
        this.airHumidity = airHumidity;
        this.windSpeed = windSpeed;
        this.isRaining = isRaining;
        this.illuminance = illuminance;
    }

    public Double getAirTemperature() {
        return airTemperature;
    }

    public Double getAirHumidity() {
        return airHumidity;
    }

    public Double getWindSpeed() {
        return windSpeed;
    }

    public Boolean getRaining() {
        return isRaining;
    }

    public Double getIlluminance() {
        return illuminance;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        Values values = (Values) o;
        return Objects.equals(airTemperature, values.airTemperature) &&
                Objects.equals(airHumidity, values.airHumidity) &&
                Objects.equals(windSpeed, values.windSpeed) &&
                Objects.equals(isRaining, values.isRaining) &&
                Objects.equals(illuminance, values.illuminance);
    }

    @Override
    public int hashCode() {
        return Objects.hash(airTemperature, airHumidity, windSpeed, isRaining, illuminance);
    }

    @Override
    public String toString() {
        return "Values{" +
                "airTemperature=" + airTemperature +
                ", airHumidity=" + airHumidity +
                ", windSpeed=" + windSpeed +
                ", isRaining=" + isRaining +
                ", illuminance=" + illuminance +
                '}';
    }
}
