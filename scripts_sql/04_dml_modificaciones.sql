UPDATE pago
SET estado_pago= 'Pagado'
WHERE id_pago= 104;
----------------------------------------------
UPDATE cancelacion_reserva
SET penalidad = 0.00
WHERE id_cancelacion = 4;

UPDATE reserva
SET estado_reserva = 'Cancelada'
WHERE id_reserva = 5004;
