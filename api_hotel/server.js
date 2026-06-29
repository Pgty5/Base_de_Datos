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






//DELETE
app.delete("/reservas-completas/:id", async (req, res) => {
    const client = await pool.connect();

    try {
        const id_reserva = req.params.id;

        await client.query("BEGIN");

        const pagos = await client.query(`
            SELECT id_pago
            FROM pago
            WHERE id_reserva = $1;
        `, [id_reserva]);

        for (const fila of pagos.rows) {
            await client.query(`
                DELETE FROM detalle_pago
                WHERE id_pago = $1;
            `, [fila.id_pago]);
        }

        await client.query(`
            DELETE FROM pago
            WHERE id_reserva = $1;
        `, [id_reserva]);

        await client.query(`
            DELETE FROM estadia
            WHERE id_reserva = $1;
        `, [id_reserva]);

        const reserva = await client.query(`
            DELETE FROM reserva
            WHERE id_reserva = $1
            RETURNING id_reserva;
        `, [id_reserva]);

        if (reserva.rows.length === 0) {
            await client.query("ROLLBACK");
            return res.status(404).json({
                mensaje: "Reserva no encontrada"
            });
        }

        await client.query("COMMIT");

        res.json({
            mensaje: "Reserva completa eliminada correctamente con COMMIT",
            id_reserva_eliminada: reserva.rows[0].id_reserva
        });

    } catch (error) {
        await client.query("ROLLBACK");

        console.log(error);

        res.status(500).json({
            mensaje: "Error al eliminar reserva completa. Se ejecuto ROLLBACK",
            error: error.message
        });

    } finally {
        client.release();
    }
});
