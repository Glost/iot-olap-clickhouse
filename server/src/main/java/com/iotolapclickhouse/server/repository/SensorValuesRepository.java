package com.iotolapclickhouse.server.repository;

import com.iotolapclickhouse.server.model.entity.SensorValues;
import com.iotolapclickhouse.server.model.entity.SensorValuesKey;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SensorValuesRepository extends JpaRepository<SensorValues, SensorValuesKey> {
}
