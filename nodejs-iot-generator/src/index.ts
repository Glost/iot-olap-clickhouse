import request from "request";
import { CronJob } from "cron";

import server from "./server";
import { getSensorsFromDumpSync } from "./handlers/sensors";
import { mergeSensorsWithIndications } from "./handlers/requestFormatter";
import { getIndicationsFromDumpSync, updateIndications, dumpIndicationsSync } from "./handlers/indications";

server.listen(3000, () => {
    const SENSORS = getSensorsFromDumpSync();
    let INDICATIONS = getIndicationsFromDumpSync();

    // Every 30 seconds sends the data
    // */30 for one per 30 sec
    new CronJob("* * * * * *", () => {
        const updatedIndications = updateIndications(INDICATIONS);
        const requestBody = mergeSensorsWithIndications(SENSORS, updatedIndications);

        request.post({
            url: "http://localhost:3000/serverStub",
            json: true,
            body: requestBody
        }, (err) => {
            if (err) {
                 return console.warn(err);
            }

            INDICATIONS = updatedIndications;
            dumpIndicationsSync(updatedIndications);
            console.log("sended");
        });
    }, null, true, "America/Los_Angeles");

    console.log(`Express web server started: http://localhost:3000`);
});
