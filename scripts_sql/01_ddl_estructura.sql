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
    nombre VARCHAR(25),
    apellido VARCHAR(25),
    dni CHAR(8),
    historial TEXT,
    telefono VARCHAR(15)
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
CREATE TABLE rol_empleado(
    id_rol INTEGER,
    descripcion VARCHAR(50)
);
CREATE TABLE turno (
    id_turno  INTEGER,
    hr_inicio TIME,
    hr_fin TIME,
    descripcion VARCHAR(100)
);
CREATE TABLE habitacion (
    id_habitacion INTEGER,
    nro_habitacion INTEGER,
    piso INTEGER,
    capacidad  INTEGER,
    precio_base NUMERIC(8,2),
    id_estado INTEGER
);
CREATE TABLE mantenimiento (
    id_mantenimiento     INTEGER,
    fch_inicio  DATE,
    fch_fin  DATE,
    motivo  VARCHAR(100),
    descripcion     VARCHAR(200),
    estado_mant      VARCHAR(50),
    costo      NUMERIC(8,2),
    id_habitacion    INTEGER,
    id_empleado         INTEGER
);

CREATE TABLE cancelacion_reserva (
    id_cancelacion INTEGER,
    motivo  VARCHAR(200),
    fecha    DATE,
    penalidad     NUMERIC(8,2),
    id_reserva    INTEGER
);

CREATE TABLE servicio (
    id_servicio INT,
    nombre_servicio VARCHAR(100),
    descripcion TEXT,
    precio_unitario NUMERIC(10,2)
);

CREATE TABLE mtd_pago (
    id_metodo INT,
    nombre_pago VARCHAR(50),
    descripcion TEXT
);

CREATE TABLE pago (
    id_pago INT,
    fch_pago DATE,
    monto_total NUMERIC(10,2),
    estado_pago VARCHAR(20),
    id_reserva INT,
    id_metodo INT
);

CREATE TABLE detalle_pago (
    id_detalle INT,
    monto_abonado NUMERIC(10,2),
    descripcion TEXT,
    id_pago INT,
    id_servicio INT
);

CREATE TABLE comprobante (
    id_comprobante INT,
    serie VARCHAR(20),
    fch_emision DATE,
    descripcion TEXT,
    id_pago INT
);
    


