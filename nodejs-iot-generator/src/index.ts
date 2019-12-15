import request from "requestretry";
import { CronJob } from "cron";

import server from "./server";
import { getSensorsFromDumpSync } from "./handlers/sensors";
import { mergeSensorsWithIndications } from "./handlers/requestFormatter";
import { getIndicationsFromDumpSync, updateIndicationsIndex, dumpIndicationsSync } from "./handlers/indications";

const getNextSensorToPoll = (lastPolledSensor: string, sensorsCount: number) => {
    const lastPolledSensorNumber = parseInt(lastPolledSensor);

    if (lastPolledSensorNumber === sensorsCount - 1) {
        return "0";
    }

    return (lastPolledSensorNumber + 1).toString();
};

server.listen(3000, () => {
    const SENSORS = getSensorsFromDumpSync();

    let NEXT_SENSOR_TO_POLL = "0";
    let INDICATIONS = getIndicationsFromDumpSync();

    // Every 2 seconds sends next sensor indication
    // */2 for one per 2 sec
    new CronJob("*/2 * * * * *", () => {
        const updatedIndications = updateIndicationsIndex(INDICATIONS, NEXT_SENSOR_TO_POLL);
        const requestBody = mergeSensorsWithIndications(SENSORS, updatedIndications)[NEXT_SENSOR_TO_POLL];

        request.post({
            url: "http://localhost:80/pushData",
            // url: "http://localhost:3000/pushData",
            json: true,
            headers: {
                "Content-Type": "application/json",
                "token": "AAABACIx65Ox6LJ6X5bsAq4L3q035Qzjzf8ayNwV64uvxOtBAmseNOMbxyqp3qS8o8fU3JobIedy8R07625yqd/ChcWM0vLpMGDJ8z2XNAWr1AvLpbcKNBEkwdUoAVtlr/NBlxhjHtCiXUctZs7+3eF8T6QggIa3j0CYMh0jgk45HFPLvTOpTf0GOIlRg7VkWFA3Ir7nuoaMhjGhkej9YVu1v8LERIcghRyDDhmQ6ESQjdSvhjP0wc3eWRbftJWMl74CnthxrSCkeE8LhmK0IOF7Z4t0v1tgEGuSSQYYbbsBkq+9qZVfR3XrVf2Tg5ZYr2Snn64BKoQtHws5unT9tArEFC0AAACBAND+MRWGVIVIiUjLKcYgeBAINzPx8ot+YC5B3fSwOxyciMaH5nqgrg4q1Qg+wJ0mBNZ4FHxgWQZWGODLkGgMLUFUNu7IZX1/B+19Alo1j0lGSaYYAlgOST8ke17uOWuHaH7u5O/+lV7v76IYPFPYQs7+6tJOaxXaF8Eo57V+cb23AAAAgQDBuUMuYVt0RILTG0AYSaqLQk3rfERPpsAOjh/v61KZE9xi8y1aV4HBPudsFrlkTEI2IR8+cvLPvEBTLbEotyfo9Q4EHaOmDR/f8CxT57KFD66Yeb/kKrD0GaUQVUyJD4OOA4ldolL4TlUdVpQBvXZDLfp7Nykun7x+ZWuRH1xoeQAAAIBY5ZxWwvnia57BKJ24Hh+T7QQSqFLXpWurWR+X9lXT1gbcMfAbv0CdukWO96d8uciPOb0PBki7Hk8uNiSONFEmthfb/tNGBTaB4wXNNr0OI69ZyntcbTa6F7/sev1mOcOgSoX77sbype6CBw58SB91Sg4h5EafndF6UzovRP+xvA==",
            },
            body: requestBody,

            maxAttempts: 3,   // try 3 times
            retryDelay: 30000,  // wait for 30_000ms before trying again
        }, (err) => {
            if (err) {
                 return console.warn(err);
            }

            INDICATIONS = updatedIndications;
            NEXT_SENSOR_TO_POLL = getNextSensorToPoll(NEXT_SENSOR_TO_POLL, Object.keys(SENSORS).length);
            dumpIndicationsSync(updatedIndications);
        });
    }, null, true, "America/Los_Angeles");

    console.log(`Express web server started. Port: 3000`);
});
