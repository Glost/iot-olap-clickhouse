package com.iotolapclickhouse.server.util;

import java.time.format.DateTimeFormatter;

public class DateTimeUtil {

    public static final String DATE_TIME_PATTERN = "yyyy-MM-dd HH:mm:ss.SSSZ";

    public static final String DATE_TIME_CLICKHOUSE_PATTERN = "yyyy-MM-dd HH:mm:ss";

    public static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern(DATE_TIME_PATTERN);

    public static final DateTimeFormatter DATE_TIME_CLICKHOUSE_FORMATTER =
            DateTimeFormatter.ofPattern(DATE_TIME_CLICKHOUSE_PATTERN);

    private DateTimeUtil() {
        throw new AssertionError();
    }
}
