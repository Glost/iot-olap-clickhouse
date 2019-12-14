import { Router } from "express";

import { getSensorsFromDumpSync } from "./handlers/sensors";
import { mergeSensorsWithIndications } from "./handlers/requestFormatter";
import { getIndicationsFromDumpSync, updateIndications, dumpIndicationsSync } from "./handlers/indications";

const commonRoutes = Router();

commonRoutes.get("/", (_req, res) => {
    res.status(200).send("ok");
});

commonRoutes.get("/ping", (_req, res) => {
    res.status(200).send("ok");
});

commonRoutes.post("/pushData", (req, res) => {
  console.log("data received, head element: ", req.body[0]);
  res.status(200).send();
});

// Trigger indication poll manually
commonRoutes.get("/poll", (_req, res) => {
  try {
    const SENSORS = getSensorsFromDumpSync();
    const INDICATIONS = getIndicationsFromDumpSync();

    const updatedIndications = updateIndications(INDICATIONS);
    const requestBody = mergeSensorsWithIndications(SENSORS, updatedIndications);

    dumpIndicationsSync(updatedIndications);
    res.status(200).send(requestBody);
  } catch (error) {
    res.status(503).send("internal server error");
  }
});

export default commonRoutes;
