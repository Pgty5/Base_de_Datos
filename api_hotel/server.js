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
// TRANSACCION: INSERTAR RESERVA COMPLETA
app.post("/reservas-completas", async (req, res) => {
    const client = await pool.connect();

    try {
        const datos = req.body;

        await client.query("BEGIN");

        const reserva = await client.query(`
            INSERT INTO reserva
            (fch_reserva, estado_reserva, cantidad_personas, id_huesped, id_habitacion, id_empleado)
            VALUES ($1,$2,$3,$4,$5,$6)
            RETURNING id_reserva
        `,[
            datos.fch_reserva,
            datos.estado_reserva,
            datos.cantidad_personas,
            datos.id_huesped,
            datos.id_habitacion,
            datos.id_empleado
        ]);

        const id_reserva = reserva.rows[0].id_reserva;

        const estadia = await client.query(`
            INSERT INTO estadia
            (fch_ingreso,fch_salida,hr_ingreso,hr_salida,id_empleado,id_reserva)
            VALUES ($1,$2,$3,$4,$5,$6)
            RETURNING id_estadia
        `,[
            datos.fch_ingreso,
            datos.fch_salida,
            datos.hr_ingreso,
            datos.hr_salida,
            datos.id_empleado,
            id_reserva
        ]);

        const pago = await client.query(`
            INSERT INTO pago
            (fch_pago,monto_total,estado_pago,id_reserva,id_metodo)
            VALUES ($1,$2,$3,$4,$5)
            RETURNING id_pago
        `,[
            datos.fch_pago,
            datos.monto_total,
            datos.estado_pago,
            id_reserva,
            datos.id_metodo
        ]);

        const id_pago = pago.rows[0].id_pago;

        const detalle = await client.query(`
            INSERT INTO detalle_pago
            (monto_abonado,descripcion,id_pago,id_servicio)
            VALUES ($1,$2,$3,$4)
            RETURNING id_detalle
        `,[
            datos.monto_abonado,
            datos.descripcion,
            id_pago,
            datos.id_servicio
        ]);

        await client.query("COMMIT");

        res.json({
            mensaje:"Reserva registrada correctamente",
            id_reserva:id_reserva,
            id_estadia:estadia.rows[0].id_estadia,
            id_pago:id_pago,
            id_detalle:detalle.rows[0].id_detalle
        });

    } catch(error){

        await client.query("ROLLBACK");

        res.status(500).json({
            mensaje:"Error en la transacción",
            error:error.message
        });

    } finally{
        client.release();
    }
});

// PUT: actualizar reserva completa
app.put("/reservas-completas/:id", async (req, res) => {

    const client = await pool.connect();

    try{

        const id_reserva = req.params.id;
        const datos = req.body;

        await client.query("BEGIN");

        const reserva = await client.query(`
            UPDATE reserva
            SET
                fch_reserva=$1,
                estado_reserva=$2,
                cantidad_personas=$3,
                id_huesped=$4,
                id_habitacion=$5,
                id_empleado=$6
            WHERE id_reserva=$7
            RETURNING id_reserva
        `,[
            datos.fch_reserva,
            datos.estado_reserva,
            datos.cantidad_personas,
            datos.id_huesped,
            datos.id_habitacion,
            datos.id_empleado,
            id_reserva
        ]);

        if(reserva.rows.length===0){
            await client.query("ROLLBACK");
            return res.status(404).json({mensaje:"Reserva no encontrada"});
        }

        await client.query(`
            UPDATE estadia
            SET
                fch_ingreso=$1,
                fch_salida=$2,
                hr_ingreso=$3,
                hr_salida=$4,
                id_empleado=$5
            WHERE id_reserva=$6
        `,[
            datos.fch_ingreso,
            datos.fch_salida,
            datos.hr_ingreso,
            datos.hr_salida,
            datos.id_empleado,
            id_reserva
        ]);

        const pago = await client.query(`
            UPDATE pago
            SET
                fch_pago=$1,
                monto_total=$2,
                estado_pago=$3,
                id_metodo=$4
            WHERE id_reserva=$5
            RETURNING id_pago
        `,[
            datos.fch_pago,
            datos.monto_total,
            datos.estado_pago,
            datos.id_metodo,
            id_reserva
        ]);

        const id_pago = pago.rows[0].id_pago;

        await client.query(`
            UPDATE detalle_pago
            SET
                monto_abonado=$1,
                descripcion=$2,
                id_servicio=$3
            WHERE id_pago=$4
        `,[
            datos.monto_abonado,
            datos.descripcion,
            datos.id_servicio,
            id_pago
        ]);

        await client.query("COMMIT");

        res.json({
            mensaje:"Reserva actualizada correctamente",
            id_reserva:id_reserva
        });

    }catch(error){

        await client.query("ROLLBACK");

        res.status(500).json({
            mensaje:"Error al actualizar",
            error:error.message
        });

    }finally{
        client.release();
    }

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

// REPORTE CON GROUP BY Y HAVING
app.get("/reportes/consumos", async (req, res) => {
    try {
        const sql = `
            SELECT
                e.nombre AS nombre_empleado,
                e.apellido AS apellido_empleado,
                s.nombre_servicio,
                COUNT(c.id_consumo_srvc) AS cantidad_consumos,
                SUM(c.cantidad) AS total_cantidad,
                SUM(c.sub_total) AS total_recaudado
            FROM consumo_srvicio c
            INNER JOIN servicio s ON c.id_servicio = s.id_servicio
            INNER JOIN empleado e ON c.id_empleado = e.id_empleado
            WHERE c.id_empleado = 2
            GROUP BY e.nombre, e.apellido, s.nombre_servicio
            HAVING SUM(c.sub_total) >= 20
            ORDER BY total_recaudado DESC;
        `;

        const resultado = await pool.query(sql);
        res.json(resultado.rows);

    } catch (error) {
        console.log(error);
        res.status(500).json({ mensaje: "Error al generar reporte" });
    }
});

// EXPORTAR REPORTE A CSV
app.get("/reportes/consumos/exportar", async (req, res) => {
    try {
        const sql = `
            SELECT
                e.nombre AS nombre_empleado,
                e.apellido AS apellido_empleado,
                s.nombre_servicio,
                COUNT(c.id_consumo_srvc) AS cantidad_consumos,
                SUM(c.cantidad) AS total_cantidad,
                SUM(c.sub_total) AS total_recaudado
            FROM consumo_srvicio c
            INNER JOIN servicio s ON c.id_servicio = s.id_servicio
            INNER JOIN empleado e ON c.id_empleado = e.id_empleado
            WHERE c.id_empleado = 2
            GROUP BY e.nombre, e.apellido, s.nombre_servicio
            HAVING SUM(c.sub_total) >= 20
            ORDER BY total_recaudado DESC;
        `;

        const resultado = await pool.query(sql);

        let csv = "nombre_empleado,apellido_empleado,nombre_servicio,cantidad_consumos,total_cantidad,total_recaudado\n"; // encabezados
        //resueltado.rows = arreeglo de objetos de js , cada objeto representa una fila 
        resultado.rows.forEach(fila => { // fila es cada elemento de resultado.rows
            csv += `${fila.nombre_empleado},${fila.apellido_empleado},${fila.nombre_servicio},${fila.cantidad_consumos},${fila.total_cantidad},${fila.total_recaudado}\n`;
        }); // Crea una línea de texto usando los valores de cada propiedad de fila, separados por comas.

        res.setHeader("Content-Type", "text/csv"); // asegurar que se esta enviando un archivo csv para que no lo interprete como texto
        res.setHeader("Content-Disposition", "attachment; filename=reporte_consumos.csv"); //descargar esto como archivo con el nombre 
        res.send(csv);

    } catch (error) {
        console.log(error);
        res.status(500).json({ mensaje: "Error al exportar reporte" });
    }
});
// GET: listar reservas completas
app.get("/reservas-completas", async (req, res) => {
    try {
        const sql = `
            SELECT
                r.id_reserva,
                r.fch_reserva,
                r.estado_reserva,
                r.cantidad_personas,

                r.id_huesped,
                r.id_habitacion,
                r.id_empleado,

                es.id_estadia,
                es.fch_ingreso,
                es.fch_salida,
                es.hr_ingreso,
                es.hr_salida,

                p.id_pago,
                p.fch_pago,
                p.monto_total,
                p.estado_pago,
                p.id_metodo,

                dp.id_detalle,
                dp.monto_abonado,
                dp.descripcion AS descripcion_detalle,
                dp.id_servicio
            FROM reserva r
            INNER JOIN estadia es 
                ON r.id_reserva = es.id_reserva
            INNER JOIN pago p 
                ON r.id_reserva = p.id_reserva
            INNER JOIN detalle_pago dp 
                ON p.id_pago = dp.id_pago
            ORDER BY r.id_reserva DESC;
        `;

        const resultado = await pool.query(sql);
        res.json(resultado.rows);

    } catch (error) {
        console.log(error);
        res.status(500).json({
            mensaje: "Error al listar reservas completas",
            error: error.message
        });
    }
});

app.listen(3000, () => {
    console.log("Servidor corriendo en http://localhost:3000");
});


