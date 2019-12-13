package com.iotolapclickhouse.server.model.response;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.Collection;
import java.util.Objects;

public class GetAggregatedDataResponse {

    @NotNull
    private final Boolean isSuccess;

    private final String errorMessage;

    private final Integer clickHouseQueryExecutionTime;

    @Valid
    private final Collection<@NotNull SensorAggregatedValues> sensorAggregatedValues;

    @JsonCreator
    public GetAggregatedDataResponse(@JsonProperty("is_success") Boolean isSuccess,
                                     @JsonProperty("error_message") String errorMessage,
                                     @JsonProperty("click_house_query_execution_time")
                                             Integer clickHouseQueryExecutionTime,
                                     @JsonProperty("sensor_aggregated_values")
                                             Collection<SensorAggregatedValues> sensorAggregatedValues) {
        this.isSuccess = isSuccess;
        this.errorMessage = errorMessage;
        this.clickHouseQueryExecutionTime = clickHouseQueryExecutionTime;
        this.sensorAggregatedValues = sensorAggregatedValues;
    }

    public Boolean getSuccess() {
        return isSuccess;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public Integer getClickHouseQueryExecutionTime() {
        return clickHouseQueryExecutionTime;
    }

    public Collection<SensorAggregatedValues> getSensorAggregatedValues() {
        return sensorAggregatedValues;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        GetAggregatedDataResponse that = (GetAggregatedDataResponse) o;
        return Objects.equals(isSuccess, that.isSuccess) &&
                Objects.equals(errorMessage, that.errorMessage) &&
                Objects.equals(clickHouseQueryExecutionTime, that.clickHouseQueryExecutionTime) &&
                Objects.equals(sensorAggregatedValues, that.sensorAggregatedValues);
    }

    @Override
    public int hashCode() {
        return Objects.hash(isSuccess, errorMessage, clickHouseQueryExecutionTime, sensorAggregatedValues);
    }

    @Override
    public String toString() {
        return "GetAggregatedDataResponse{" +
                "isSuccess=" + isSuccess +
                ", errorMessage='" + errorMessage + '\'' +
                ", clickHouseQueryExecutionTime=" + clickHouseQueryExecutionTime +
                ", sensorAggregatedValues=" + sensorAggregatedValues +
                '}';
    }
}
