import { readFileSync } from "fs";

export type SensorCoordinates = {
    latitude: number;
    longitude: number;
    altitude: number;
};

export type SensorsMap = {
    [key: string]: SensorCoordinates;
};

const SENSORS_SRC = "./src/dumps/sensors.json";

export const getSensorsFromDumpSync = (): SensorsMap =>
    JSON.parse(readFileSync(SENSORS_SRC, "utf8"));
