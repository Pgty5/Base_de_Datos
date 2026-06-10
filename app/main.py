import os
import csv
import psycopg2
from psycopg2.extras import RealDictCursor
from fastapi import FastAPI
from fastapi.responses import FileResponse
from pymongo import MongoClient

app = FastAPI(title="FastAPI + Postgres + Mongo")

POSTGRES_URL = os.environ["POSTGRES_URL"]
mongo_client = MongoClient(os.environ["MONGO_URL"])


def get_pg_conn():
    return psycopg2.connect(POSTGRES_URL)


@app.get("/")
def root():
    return {"status": "ok"}


@app.get("/health/postgres")
def health_postgres():
    with get_pg_conn() as conn:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("SELECT version() AS version;")
            return cur.fetchone()


@app.get("/health/mongo")
def health_mongo():
    info = mongo_client.server_info()
    return {"mongo_version": info["version"]}


@app.get("/reservas")
def listar_reservas():

    with get_pg_conn() as conn:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:

            cur.execute("""
                SELECT *
                FROM reserva
                LIMIT 10
            """)

            return cur.fetchall()


@app.post("/reservas")
def crear_reserva():

    with get_pg_conn() as conn:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:

            try:

                cur.execute("""
                    INSERT INTO reserva (
                        id_reserva,
                        fch_reserva,
                        estado_reserva,
                        cantidad_personas,
                        id_huesped,
                        id_habitacion,
                        id_empleado
                    )
                    VALUES (
                        7000,
                        CURRENT_DATE,
                        'Confirmada',
                        2,
                        1,
                        2,
                        1
                    )
                """)

                cur.execute("""
                    INSERT INTO pago (
                        id_pago,
                        fch_pago,
                        monto_total,
                        estado_pago,
                        id_reserva,
                        id_metodo
                    )
                    VALUES (
                        7000,
                        CURRENT_DATE,
                        150.00,
                        'Pagado',
                        7000,
                        1
                    )
                """)

                cur.execute("""
                    INSERT INTO comprobante (
                        id_comprobante,
                        serie,
                        fch_emision,
                        descripcion,
                        id_pago
                    )
                    VALUES (
                        7000,
                        'B001-7000',
                        CURRENT_DATE,
                        'Comprobante generado desde FastAPI',
                        7000
                    )
                """)

                conn.commit()

                return {
                    "mensaje": "Reserva creada correctamente"
                }

            except Exception as e:

                conn.rollback()

                return {
                    "error": str(e)
                }


@app.get("/reportes/huespedes-vip")
def reporte_huespedes_vip():

    with get_pg_conn() as conn:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:

            cur.execute("""
                SELECT
                    h.id_huesped,
                    CONCAT(h.nombre, ' ', h.apellido) AS nombre_completo,
                    COUNT(p.id_pago) AS total_transacciones,
                    SUM(p.monto_total) AS monto_acumulado,
                    ROUND(AVG(p.monto_total), 2) AS promedio_por_pago
                FROM huesped h
                INNER JOIN reserva r
                    ON h.id_huesped = r.id_huesped
                INNER JOIN pago p
                    ON r.id_reserva = p.id_reserva
                WHERE p.estado_pago = 'Pagado'
                GROUP BY h.id_huesped, h.nombre, h.apellido
                HAVING SUM(p.monto_total) > 0
                ORDER BY monto_acumulado DESC
            """)

            datos = cur.fetchall()

    archivo = "reporte_huespedes_vip.csv"

    with open(archivo, "w", newline="", encoding="utf-8") as f:

        writer = csv.writer(f)

        writer.writerow([
            "id_huesped",
            "nombre_completo",
            "total_transacciones",
            "monto_acumulado",
            "promedio_por_pago"
        ])

        for fila in datos:
            writer.writerow(fila.values())
    return FileResponse(
        archivo,
        filename="reporte_huespedes_vip.csv"
    )
