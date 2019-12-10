import express from "express";
import helmet from "helmet";
import rateLimit from "express-rate-limit";

import { CronJob } from "cron";
import fetch from "node-fetch";

import logger from "./logger";
import commonRoutes from "./routes";
import { generate } from "./generator";

// Setup an app
const app = express();

// Limit overall RPS to 5 RPS per user
app.use(new rateLimit({
    windowMs: 1 * 60 * 1000, // 1 minute
    max: 300, // limit each IP to 120 requests per windowMs
}));

// Add some security
app.use(helmet());

// Log before the routes
app.use(logger);

// Body Parser
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.use(commonRoutes);

new CronJob("* * * * * *", async () => {
    const stub = generate();

    const res = await fetch("http://localhost:3000/serverStub", {
      method: "POST",
      body: JSON.stringify(stub),
      headers: { "Content-Type": "application/json" }
    })
      .then(() => {})
      .catch(() => {});
  }, null, true, "America/Los_Angeles"
);

export default app;
