

BEGIN;

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
    5006,
    CURRENT_DATE,
    'Confirmada',
    2,
    1,
    2,
    1
);

INSERT INTO pago (
    id_pago,
    fch_pago,
    monto_total,
    estado_pago,
    id_reserva,
    id_metodo
)
VALUES (
    106,
    CURRENT_DATE,
    150.00,
    'Pagado',
    5006,
    1
);


INSERT INTO comprobante (
    id_comprobante,
    serie,
    fch_emision,
    descripcion,
    id_pago
)
VALUES (
    306,
    'B001-000044',
    CURRENT_DATE,
    'Comprobante generado por nueva reserva',
    106
);

COMMIT;
