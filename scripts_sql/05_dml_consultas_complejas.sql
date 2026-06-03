SELECT 
    h.id_huesped,
    CONCAT(h.nombres, ' ', h.apellidos) AS nombre_completo,
    COUNT(p.id_pago) AS total_transacciones,
    SUM(p.monto_total) AS monto_acumulado,
    ROUND(AVG(p.monto_total), 2) AS promedio_por_pago
FROM huesped h
INNER JOIN reserva r ON h.id_huesped = r.id_huesped
INNER JOIN pago p ON r.id_reserva = p.id_reserva
WHERE p.estado_pago = 'Pagado'
GROUP BY h.id_huesped, h.nombres, h.apellidos
HAVING SUM(p.monto_total) > 200.00
ORDER BY monto_acumulado DESC;
