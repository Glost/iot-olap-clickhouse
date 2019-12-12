package com.iotolapclickhouse.server.model.entity;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import java.util.Objects;

@Entity
public class SensorValues {

    @EmbeddedId
    private SensorValuesKey key;

    private Double airTemperature;

    private Double airHumidity;

    private Double windSpeed;

    private Boolean isRaining;

    private Double illuminance;

    public SensorValues() {
    }

    public SensorValues(SensorValuesKey key,
                        Double airTemperature,
                        Double airHumidity,
                        Double windSpeed,
                        Boolean isRaining,
                        Double illuminance) {
        this.key = key;
        this.airTemperature = airTemperature;
        this.airHumidity = airHumidity;
        this.windSpeed = windSpeed;
        this.isRaining = isRaining;
        this.illuminance = illuminance;
    }

    public SensorValuesKey getKey() {
        return key;
    }

    public SensorValues setKey(SensorValuesKey key) {
        this.key = key;
        return this;
    }

    public Double getAirTemperature() {
        return airTemperature;
    }

    public SensorValues setAirTemperature(Double airTemperature) {
        this.airTemperature = airTemperature;
        return this;
    }

    public Double getAirHumidity() {
        return airHumidity;
    }

    public SensorValues setAirHumidity(Double airHumidity) {
        this.airHumidity = airHumidity;
        return this;
    }

    public Double getWindSpeed() {
        return windSpeed;
    }

    public SensorValues setWindSpeed(Double windSpeed) {
        this.windSpeed = windSpeed;
        return this;
    }

    public Boolean getRaining() {
        return isRaining;
    }

    public SensorValues setRaining(Boolean raining) {
        isRaining = raining;
        return this;
    }

    public Double getIlluminance() {
        return illuminance;
    }

    public SensorValues setIlluminance(Double illuminance) {
        this.illuminance = illuminance;
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
        SensorValues that = (SensorValues) o;
        return Objects.equals(key, that.key) &&
                Objects.equals(airTemperature, that.airTemperature) &&
                Objects.equals(airHumidity, that.airHumidity) &&
                Objects.equals(windSpeed, that.windSpeed) &&
                Objects.equals(isRaining, that.isRaining) &&
                Objects.equals(illuminance, that.illuminance);
    }

    @Override
    public int hashCode() {
        return Objects.hash(key, airTemperature, airHumidity, windSpeed, isRaining, illuminance);
    }

    @Override
    public String toString() {
        return "SensorValues{" +
                "key=" + key +
                ", airTemperature=" + airTemperature +
                ", airHumidity=" + airHumidity +
                ", windSpeed=" + windSpeed +
                ", isRaining=" + isRaining +
                ", illuminance=" + illuminance +
                '}';
    }
}
