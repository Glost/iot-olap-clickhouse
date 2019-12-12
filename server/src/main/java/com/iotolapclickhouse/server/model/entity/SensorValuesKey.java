package com.iotolapclickhouse.server.model.entity;

import javax.persistence.Embeddable;
import java.io.Serializable;
import java.time.OffsetDateTime;
import java.util.Objects;

@Embeddable
public class SensorValuesKey implements Serializable {

    private Double latitude;

    private Double longitude;

    private Double altitude;

    private OffsetDateTime timestamp;

    public SensorValuesKey() {
    }

    public SensorValuesKey(Double latitude, Double longitude, Double altitude, OffsetDateTime timestamp) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.altitude = altitude;
        this.timestamp = timestamp;
    }

    public Double getLatitude() {
        return latitude;
    }

    public SensorValuesKey setLatitude(Double latitude) {
        this.latitude = latitude;
        return this;
    }

    public Double getLongitude() {
        return longitude;
    }

    public SensorValuesKey setLongitude(Double longitude) {
        this.longitude = longitude;
        return this;
    }

    public Double getAltitude() {
        return altitude;
    }

    public SensorValuesKey setAltitude(Double altitude) {
        this.altitude = altitude;
        return this;
    }

    public OffsetDateTime getTimestamp() {
        return timestamp;
    }

    public SensorValuesKey setTimestamp(OffsetDateTime timestamp) {
        this.timestamp = timestamp;
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
        SensorValuesKey that = (SensorValuesKey) o;
        return Objects.equals(latitude, that.latitude) &&
                Objects.equals(longitude, that.longitude) &&
                Objects.equals(altitude, that.altitude) &&
                Objects.equals(timestamp, that.timestamp);
    }

    @Override
    public int hashCode() {
        return Objects.hash(latitude, longitude, altitude, timestamp);
    }

    @Override
    public String toString() {
        return "SensorValuesKey{" +
                "latitude=" + latitude +
                ", longitude=" + longitude +
                ", altitude=" + altitude +
                ", timestamp=" + timestamp +
                '}';
    }
}
