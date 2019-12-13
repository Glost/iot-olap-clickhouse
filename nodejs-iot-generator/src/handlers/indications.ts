import { writeFileSync, readFileSync } from "fs";
import { modifyIndication } from "./indicationsModifier";

export type IndicationValue<T> = {
    value: T;
    leftBoundary: T;
    rightBoundary: T;
};

export type Indication = {
    air_temperature: IndicationValue<number>;
    air_humidity: IndicationValue<number>;
    wind_speed: IndicationValue<number>;
    is_raining: IndicationValue<boolean>;
    illuminance: IndicationValue<number>;
};

export type IndicationsMap = {
    [key: string]: Indication;
};

const INDICATIONS_SRC = "./src/dumps/indications.json";

export const getIndicationsFromDumpSync = (): IndicationsMap =>
    JSON.parse(readFileSync(INDICATIONS_SRC, "utf8"));

export const dumpIndicationsSync = (indicationMap: IndicationsMap): void => {
    writeFileSync(INDICATIONS_SRC, JSON.stringify(indicationMap));
};

export const updateIndications = (previousIndications: IndicationsMap): IndicationsMap => {
    const newIndications = {};

    for (const [index, indication] of Object.entries(previousIndications)) {
        newIndications[index] = modifyIndication(indication);
    }

    return newIndications;
};
