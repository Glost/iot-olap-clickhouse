import path from "path";
import { Router } from "express";

const commonRoutes = Router();

commonRoutes.get("/", (_req, res) => {
    res.sendFile(
        path.resolve("../client/dist/index.html")
    );
});

commonRoutes.get("/generate", (_req, res) => {
    // TODO: generate data
    res
        .status(200)
        .send("ok");
});

commonRoutes.get("/ping", (_req, res) => {
    res
        .status(200)
        .send("ok");
});

export default commonRoutes;
