const express = require("express");
const mongoose = require("mongoose");

const app = express();

mongoose.connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB Connected"))
  .catch(err => console.log(err));

app.get("/", (req, res) => {
  res.send("Hello from Vishal Docker App 🚀");
});

app.listen(3000, () => console.log("Server running on port 3000"));