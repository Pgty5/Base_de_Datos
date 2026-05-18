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
