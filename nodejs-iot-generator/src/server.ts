import express from "express";
import helmet from "helmet";
import rateLimit from "express-rate-limit";

import logger from "./logger";
import commonRoutes from "./routes";

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

export default app;
