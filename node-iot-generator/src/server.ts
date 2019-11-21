import bodyParser from "body-parser";
import compression from "compression";
import cookieParser from "cookie-parser";
import cors from "cors";
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

// Enable CORS
app.use(cors());

// Add some compression
app.use(compression());

// Cookie Parser
app.use(cookieParser());

// Log before the routes
app.use(logger);

// Body Parser
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Routes
app.use(commonRoutes);

app.use((_req, res, next) => {
    res.status(404);
    next();
});

// TODO: log errors after the routes

// Debug redir to /
if (process.env.NODE_ENV !== "production") {
    app.use((_req, res, next) => {
        res.redirect("/");
        next();
    });
}

export default app;
