import { Router } from "express";
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
  res.status(200).send("not implemented");
});

commonRoutes.post("/serverStub", (req, res) => {
  console.log("data received: ", req.body[0]);
  res.status(200).send("ok");
});

export default commonRoutes;
