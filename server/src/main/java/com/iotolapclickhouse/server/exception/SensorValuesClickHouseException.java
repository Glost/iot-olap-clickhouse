package com.iotolapclickhouse.server.exception;

public class SensorValuesClickHouseException extends SensorValuesException {

    public SensorValuesClickHouseException(String message) {
        super(message);
    }

    public SensorValuesClickHouseException(String message, Throwable cause) {
        super(message, cause);
    }
}
