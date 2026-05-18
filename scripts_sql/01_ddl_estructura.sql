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
