INSERT INTO empleado (id_empleado, nombre, apellido, dni, telefono, correo, id_rol, id_turno) VALUES
(1, 'Pedro', 'Salas', '40111222', '999111222', 'psalas@htel.com', 1, 1),
(2, 'Edward', 'Poma', '40222333', '999222333', 'edwardp@htel.com', 2, 2),
(3, 'Ronal', 'Cueto', '40333444', '999333444', 'rcuetillo@htel.com', 3, 3),
(4, 'Alhy', 'Chura', '40444555', '999444555', 'alhyplayer15@htel.com', 4, 4),
(5, 'Diego', 'Castro', '40555666', '999555666', 'dcastro@htel.com', 5, 5);

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
