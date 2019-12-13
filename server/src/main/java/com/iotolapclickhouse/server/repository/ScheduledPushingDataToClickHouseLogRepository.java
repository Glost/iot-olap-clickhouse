package com.iotolapclickhouse.server.repository;

import com.iotolapclickhouse.server.model.entity.ScheduledPushingDataToClickHouseLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.OffsetDateTime;

@Repository
public interface ScheduledPushingDataToClickHouseLogRepository
        extends JpaRepository<ScheduledPushingDataToClickHouseLog, OffsetDateTime> {
}
