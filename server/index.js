const express = require("express");
const app =  express();
const cors = require("cors");
  
app.use(express.json());
app.use(cors());

//fare rates
app.use("/fare", require('./routes/fareRate'));

//past travels
app.use("/pasttravels", require('./routes/pastTravel'));

app.listen(5002, () => { 
    console.log("server is running on port 5002");
});