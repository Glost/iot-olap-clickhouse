package com.iotolapclickhouse.server.util;

import java.time.format.DateTimeFormatter;

public class DateTimeUtil {

    public static final String DATE_TIME_REQUEST_PATTERN = "yyyy-MM-dd['T'][ ]HH:mm:ss.SSSXXXX";

    public static final String DATE_TIME_RESPONSE_PATTERN = "yyyy-MM-dd HH:mm:ss.SSSXXXX";

    public static final String DATE_TIME_CLICKHOUSE_PATTERN = "yyyy-MM-dd HH:mm:ss";

    public static final DateTimeFormatter DATE_TIME_REQUEST_FORMATTER =
            DateTimeFormatter.ofPattern(DATE_TIME_REQUEST_PATTERN);

    public static final DateTimeFormatter DATE_TIME_RESPONSE_FORMATTER =
            DateTimeFormatter.ofPattern(DATE_TIME_RESPONSE_PATTERN);

    public static final DateTimeFormatter DATE_TIME_CLICKHOUSE_FORMATTER =
            DateTimeFormatter.ofPattern(DATE_TIME_CLICKHOUSE_PATTERN);

    private DateTimeUtil() {
        throw new AssertionError();
    }
}
