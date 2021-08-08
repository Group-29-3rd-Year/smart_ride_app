const express = require("express");
const app =  express();
const cors = require("cors");
  
app.use(express.json());
app.use(cors());
 
//register 
app.use("/add", require('./routes/passenger'));

//login
app.use("/login", require('./routes/passenger'));

//fare rates
app.use("/fare", require('./routes/fareRate'));

//past travels
app.use("/pasttravels", require('./routes/pastTravel'));

//bus locations
app.use("/buslocations", require('./routes/busLocations'));

app.listen(5002, () => { 
    console.log("server is running on port 5002");
});