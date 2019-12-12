package com.iotolapclickhouse.server.exception;

public class SensorValuesException extends RuntimeException {

    public SensorValuesException(String message) {
        super(message);
    }

    public SensorValuesException(String message, Throwable cause) {
        super(message, cause);
    }
}
