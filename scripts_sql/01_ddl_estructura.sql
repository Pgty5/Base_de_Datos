CREATE TABLE estadia (
    id_estadia INT,
    fch_ingreso DATE,
    fch_salida DATE,
    hr_ingreso TIME,
    hr_salida TIME,
    id_empleado INT,
    id_reserva INT
);

CREATE TABLE huesped (
    id_huesped INT,
    nombres VARCHAR(25),
    apellidos VARCHAR(25),
    dni CHAR(8),
    historial TEXT,
    telefono VARCHAR(15),
);

CREATE TABLE reserva (
    id_reserva INT,
    fch_reserva DATE,
    fch_inicio DATE,
    fch_fin DATE,
    estado_reserva VARCHAR(20),
    id_huesped INT,
    id_habitacion INT
);

CREATE TABLE estd_habitacion (
    id_estado INT,
    nombre_estado VARCHAR(20),
    descripcion TEXT
);

CREATE TABLE empleado (
    id_empleado INT,
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    dni CHAR(8),
    telefono VARCHAR(15),
    correo VARCHAR(25),
    id_rol INT,
    id_turno INT
);

CREATE TABLE consumo_srvicio (
    id_consumo_srvc INT,
    fch_consumo DATE,
    cantidad INT,
    sub_total NUMERIC(5,2),
    descripcion TEXT,
    id_estadia INT,
    id_servicio INT,
    id_empleado INT
);
