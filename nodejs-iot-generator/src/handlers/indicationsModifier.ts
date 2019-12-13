import { IndicationValue, Indication } from "./indications";

export const modifyIndication = (indication: Indication): Indication => {
    const newIndication = {...indication};

    for (const [key, factor] of Object.entries(indication)) {
        if (typeof factor.value === "boolean") {
            newIndication[key] = processBoolean(<any>factor);
        }

        if (typeof factor.value === "number") {
            newIndication[key] = processNumber(<any>factor);
        }
    }

    return newIndication;
};

// Rain state should not be changed frequently, 5% for its change
const processBoolean = (factor: IndicationValue<boolean>): IndicationValue<boolean> => Math.random() >= 0.95 ?
    {...factor} :
    {...factor, value: !factor.value};

const processNumber = (factor: IndicationValue<number>): IndicationValue<number> => {
    const {value, leftBoundary, rightBoundary} = factor;

    // 20% from range is maximum offset for 1 iteration
    const maxOffset = (rightBoundary - leftBoundary) * 0.2;
    const offset = Math.random() * maxOffset;

    if (value - offset <= leftBoundary) {
        return {...factor, value: value + offset};
    }

    if (value + offset >= rightBoundary) {
        return {...factor, value: value - offset};
    }

    return Math.random() >= 0.5 ?
        {...factor, value: value + offset} :
        {...factor, value: value - offset};
};
