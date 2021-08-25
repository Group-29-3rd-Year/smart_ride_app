const router = require("express").Router();
const { response } = require("express");
const pool = require("../db");

router.post("/getuserstart", async(req, res) => {

    try {
        
        const {bus_id} = req.body;

        const loc = await pool.query("SELECT latitude, longitude FROM bus WHERE bus_id = $1",
            [ bus_id ]        
        );

        if( loc.rows.length === 0) {
            return res.status(401).json("Error loading data");
        }

        res.json(loc.rows[0]);

    } catch (err) {
        console.error(err.message);
        res.status(500).send("Server error");
    }
}); 


module.exports = router;