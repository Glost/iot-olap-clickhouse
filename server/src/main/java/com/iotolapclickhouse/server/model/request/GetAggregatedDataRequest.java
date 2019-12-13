package com.iotolapclickhouse.server.model.request;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.Collection;
import java.util.Objects;
import java.util.Optional;

public class GetAggregatedDataRequest {

    @Valid
    private final Collection<@NotNull CoordinateInterval> latitudeIntervals;

    @Valid
    private final Collection<@NotNull CoordinateInterval> longitudeIntervals;

    @Valid
    private final Collection<@NotNull CoordinateInterval> altitudeIntervals;

    @NotNull
    @Valid
    private final TimestampInterval timestampInterval;

    @NotNull
    private final AggregatedPeriod aggregatedPeriod;

    private final Boolean needSplitByCoordinates;

    @JsonCreator
    public GetAggregatedDataRequest(@JsonProperty("latitude_intervals")
                                            Collection<CoordinateInterval> latitudeIntervals,
                                    @JsonProperty("longitude_intervals")
                                            Collection<CoordinateInterval> longitudeIntervals,
                                    @JsonProperty("altitude_intervals")
                                            Collection<CoordinateInterval> altitudeIntervals,
                                    @JsonProperty("timestamp_interval") TimestampInterval timestampInterval,
                                    @JsonProperty("aggregated_period") AggregatedPeriod aggregatedPeriod,
                                    @JsonProperty("need_split_by_coordinates") Boolean needSplitByCoordinates) {
        this.latitudeIntervals = latitudeIntervals;
        this.longitudeIntervals = longitudeIntervals;
        this.altitudeIntervals = altitudeIntervals;
        this.timestampInterval = timestampInterval;
        this.aggregatedPeriod = aggregatedPeriod;
        this.needSplitByCoordinates = Optional.ofNullable(needSplitByCoordinates).orElse(false);
    }

    public Collection<CoordinateInterval> getLatitudeIntervals() {
        return latitudeIntervals;
    }

    public Collection<CoordinateInterval> getLongitudeIntervals() {
        return longitudeIntervals;
    }

    public Collection<CoordinateInterval> getAltitudeIntervals() {
        return altitudeIntervals;
    }

    public TimestampInterval getTimestampInterval() {
        return timestampInterval;
    }

    public AggregatedPeriod getAggregatedPeriod() {
        return aggregatedPeriod;
    }

    public Boolean getNeedSplitByCoordinates() {
        return needSplitByCoordinates;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        GetAggregatedDataRequest that = (GetAggregatedDataRequest) o;
        return Objects.equals(latitudeIntervals, that.latitudeIntervals) &&
                Objects.equals(longitudeIntervals, that.longitudeIntervals) &&
                Objects.equals(altitudeIntervals, that.altitudeIntervals) &&
                Objects.equals(timestampInterval, that.timestampInterval) &&
                aggregatedPeriod == that.aggregatedPeriod &&
                Objects.equals(needSplitByCoordinates, that.needSplitByCoordinates);
    }

    @Override
    public int hashCode() {
        return Objects.hash(
                latitudeIntervals,
                longitudeIntervals,
                altitudeIntervals,
                timestampInterval,
                aggregatedPeriod,
                needSplitByCoordinates
        );
    }

    @Override
    public String toString() {
        return "GetAggregatedDataRequest{" +
                "latitudeIntervals=" + latitudeIntervals +
                ", longitudeIntervals=" + longitudeIntervals +
                ", altitudeIntervals=" + altitudeIntervals +
                ", timestampInterval=" + timestampInterval +
                ", aggregatedPeriod=" + aggregatedPeriod +
                ", needSplitByCoordinates=" + needSplitByCoordinates +
                '}';
    }
}
