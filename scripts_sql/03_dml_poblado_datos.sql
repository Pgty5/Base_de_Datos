INSERT INTO empleado (id_empleado, nombre, apellido, dni, telefono, correo, id_rol, id_turno) VALUES
(1, 'Pedro', 'Salas', '40111222', '999111222', 'psalas@htel.com', 1, 1),
(2, 'Edward', 'Poma', '40222333', '999222333', 'edwardp@htel.com', 2, 2),
(3, 'Ronal', 'Cueto', '40333444', '999333444', 'rcuetillo@htel.com', 3, 3),
(4, 'Alhy', 'Chura', '40444555', '999444555', 'alhyplayer15@htel.com', 4, 4),
(5, 'Diego', 'Castro', '40555666', '999555666', 'dcastro@htel.com', 5, 5);

INSERT INTO huesped (id_huesped, nombres, apellidos, dni, historial, telefono) VALUES
(1, 'Carlos', 'Mendoza', '70111222', 'Sin observaciones', '958111222'),
(2, 'Lucia', 'Torres', '70222333', 'Cliente frecuente', '958222333'),
(3, 'Mario', 'Ramos', '70333444', 'Solicita habitación tranquila', '958333444'),
(4, 'Ana', 'Flores', '70444555', 'Sin observaciones', '958444555'),
(5, 'Jorge', 'Quispe', '70555666', 'Pagos puntuales', '958555666');

INSERT INTO servicio (id_servicio, nombre_servicio, descripcion, precio_unitario) 
VALUES (1, 'Hospedaje Habitacion Simple' , 'Servicio de alojamiento simple por noche', 15.00),
(2,'Hospedaje Habitacion Doble', 'Servicio de alojamiento para dos Personas por noche', 30.00),
(3,'Servicio de Minibar', 'Consumo de bebidas y snacks en la habitacion', 8.00),
(4,'Acceso a Spa y Masajes','Uso de instalaciones de relajacion por hora', 20.00),
(5,'Almuerzo Ejecutivo Hotelero','Menu completo servido en el restaurante principal',15.00);

INSERT INTO mtd_pago (id_metodo, nombre_pago,descripcion) 
VALUES (1, 'Pago por Efectivo','Pago Fisico'),
(2,'Pago por Tarjeta','Pago electronico'),
(3,'Transferencia Bancaria','Transferencia directa'),
(4,'Billetera Digital','Pago por aplicaciones'),
(5,'Pago por Criptomonedas','Uso de criptomonedas como metodo de pago');

INSERT INTO pago (id_pago, fch_pago, monto_total, estado_pago, id_reserva, id_metodo)
VALUES (101, '2026-05-15', 45.00, 'Pagado', 5001, 1),
(102, '2026-05-16', 95.00, 'Pagado', 5002, 2),
(103, '2026-05-18', 60.00, 'Pagado', 5003, 2),
(104, '2026-05-20', 50.00, 'Pendiente', 5004, 3),
(105, '2026-05-22', 125.00, 'Pagado', 5005, 4);

INSERT INTO detalle_pago (id_detalle, monto_abonado, descripcion, id_pago, id_servicio)
VALUES (201, 45.00, 'Pago por 1 noche en habitacion simple', 101, 1),
(202, 80.00, 'Pago por 1 noche en habitacion doble', 102, 2),
(203, 15.50, 'Pago por consumo de chocolates del minibar', 102, 3),
(204, 80.00, 'Abono parcial de alojamiento doble', 103, 2),
(206, 50.00, 'Reserva de sesion de masajes terapeuicos', 104,4),
(206, 45.00, 'Alojamiento base del huesped de la reserva 5005', 105, 1),
(207, 80.00, 'Consumo asociado de suite doble en el mismo periodo', 105, 2);

INSERT INTO comprobante (id_comprobante, serie, fch_emision, descripcion, id_pago)
VALUES (301, 'B001-000041', '2026-05-15', 'Boleta de venta electronica por hospedaje rapido', 101),
(302, 'F001-000012', '2026-05-16', 'Factura corporativa con desglose de consumos', 102),
(303, 'B001-000042', '2026-05-18', 'Boleta emitida al cerrar estadia', 103),
(304, 'B001-000043', '2026-05-20', 'Boleta de adelanto por transferencia', 104),
(305, 'F001-000013', '2026-05-22', 'Factura por adelantos integrales de alojamiento', 105);
---------------------------------------------------------------------------------------
INSERT INTO rol_empleado (id_rol, descripcion) VALUES
(1, 'Recepcionista'),
(2, 'Gerente'),
(3, 'Personal de limpieza'),
(4, 'Mantenimiento'),
(5, 'Conserje');

