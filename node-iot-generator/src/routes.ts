import path from "path";
import { Router } from "express";

import { generate } from "./generator";

const commonRoutes = Router();

// Common
commonRoutes.get("/", (_req, res) => {
  res.status(200).send("ok");
});

commonRoutes.get("/ping", (_req, res) => {
  res.status(200).send("ok");
});

// Specific
commonRoutes.get("/generate", (_req, res) => {
  res.status(200).send(generate());
});

commonRoutes.post("/serverStub", (req, res) => {
  console.log("data received: ", req.body);
  res.status(200);
});

export default commonRoutes;
