const router = require("express").Router();
const { response } = require("express");
const pool = require("../db");

router.post("/register", async (req, res) => {

    try {
        
        const { uname, phone_number, email, password } = req.body;

       
        const userExist = await pool.query(
          "SELECT * FROM passenger WHERE email = $1",
          [email]
        );

        if (userExist.rows.length !== 0) {
          return res.status(401).send("Paasenger already exists");
        }
        else{
            const newPassenger = await pool.query(
              "INSERT INTO passenger (uname, phone_number, email, password) VALUES ($1, $2, $3, $4) RETURNING *",
              [uname, phone_number, email, password]
            );

            if (newPassenger) {
                res.json("Success");
            }
        }

    } catch (err) {
        console.error(err.message);
        res.status(500).send("Server error");
    }

});

module.exports = router;