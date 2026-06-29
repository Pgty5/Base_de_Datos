const express = require("express"); 
const { Pool } = require("pg"); 

const app = express();
app.use(express.json());

// CONEXION A POSTGRESQL
const pool = new Pool({
    user: "postgres",
    host: "localhost",
    database: "hotel",
    password: "1234",
    port: 5432
});


