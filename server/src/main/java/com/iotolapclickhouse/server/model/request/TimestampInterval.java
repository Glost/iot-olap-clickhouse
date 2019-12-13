package com.iotolapclickhouse.server.model.request;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.validation.constraints.NotNull;
import java.time.OffsetDateTime;
import java.util.Objects;

public class TimestampInterval {

    @NotNull
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSSZ")
    private final OffsetDateTime from;

    @NotNull
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss.SSSZ")
    private final OffsetDateTime to;

    @JsonCreator
    public TimestampInterval(@JsonProperty("from") OffsetDateTime from,
                             @JsonProperty("to") OffsetDateTime to) {
        this.from = from;
        this.to = to;
    }

    public OffsetDateTime getFrom() {
        return from;
    }

    public OffsetDateTime getTo() {
        return to;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        TimestampInterval that = (TimestampInterval) o;
        return Objects.equals(from, that.from) &&
                Objects.equals(to, that.to);
    }

    @Override
    public int hashCode() {
        return Objects.hash(from, to);
    }

    @Override
    public String toString() {
        return "TimestampInterval{" +
                "from=" + from +
                ", to=" + to +
                '}';
    }
}
