import moment from "moment";

import { SensorsMap, SensorCoordinates } from "./sensors";
import { IndicationsMap, IndicationValue } from "./indications";

type SensorsIndicationsMerged = {
    coordinates: SensorCoordinates;
    values: IndicationValue<number> | IndicationValue<boolean>;
    timestamp: string;
};

export const mergeSensorsWithIndications = (sensors: SensorsMap, indications: IndicationsMap): SensorsIndicationsMerged[] => {
    const merged = [];

    for (const [index, sensor] of Object.entries(sensors)) {
        merged.push({
            coordinates: sensor,
            values: indications[index],
            timestamp: moment(new Date(), "yyyy-MM-dd HH:mm:ss.SSSZ"),
        });
    }

    return merged;
};
