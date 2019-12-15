import { Router } from "express";

import { getSensorsFromDumpSync } from "./handlers/sensors";
import { mergeSensorsWithIndications } from "./handlers/requestFormatter";
import {
  getIndicationsFromDumpSync,
  updateIndications,
  updateIndicationsIndex,
  dumpIndicationsSync
 } from "./handlers/indications";

const commonRoutes = Router();

commonRoutes.get("/", (_req, res) => {
    res.status(200).send("ok");
});

commonRoutes.get("/ping", (_req, res) => {
    res.status(200).send("ok");
});

commonRoutes.post("/pushData", (req, res) => {
  // Uncomment to debug main server /pushData method mock
  // console.log("data received, head element: ", req.body);
  res.status(200).send();
});

// Trigger indication poll for random sensor manually
commonRoutes.get("/pollRandomSensor", (_req, res) => {
  try {
    const SENSORS = getSensorsFromDumpSync();
    const INDICATIONS = getIndicationsFromDumpSync();

    // Random sensorId from 0 to last
    const randomSensorId = Math.floor(Math.random() * Object.keys(SENSORS).length).toString();

    const updatedIndications = updateIndicationsIndex(INDICATIONS, randomSensorId);
    const requestBody = mergeSensorsWithIndications(SENSORS, updatedIndications)[randomSensorId];

    dumpIndicationsSync(updatedIndications);
    res.status(200).send(requestBody);
  } catch (error) {
    console.error(error);
    res.status(500).send("500: internal server error");
  }
});

// Trigger indication poll for all sensors manually
commonRoutes.get("/pollAllSensors", (_req, res) => {
  try {
    const SENSORS = getSensorsFromDumpSync();
    const INDICATIONS = getIndicationsFromDumpSync();

    const updatedIndications = updateIndications(INDICATIONS);
    const requestBody = mergeSensorsWithIndications(SENSORS, updatedIndications);

    dumpIndicationsSync(updatedIndications);
    res.status(200).send(requestBody);
  } catch (error) {
    console.error(error);
    res.status(500).send("500: internal server error");
  }
});

export default commonRoutes;
