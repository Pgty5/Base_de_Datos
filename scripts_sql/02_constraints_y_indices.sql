--constraints tabla estadia
ALTER TABLE estadia
ADD CONSTRAINT pk_estadia PRIMARY KEY (id_estadia);

ALTER TABLE estadia
ALTER COLUMN fch_ingreso SET NOT NULL;

ALTER TABLE estadia
ALTER COLUMN id_empleado SET NOT NULL;

ALTER TABLE estadia
ALTER COLUMN id_reserva SET NOT NULL;

ALTER TABLE estadia
ADD CONSTRAINT fk_estadia_empleado FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

ALTER TABLE estadia
ADD CONSTRAINT fk_estadia_reserva FOREIGN KEY (id_reserva)
REFERENCES reserva(id_reserva);

ALTER TABLE estadia 
ADD CONSTRAINT ck_estadia_fechas
CHECK (fch_salida >= fch_ingreso);

--constraints tabla huesped
ALTER TABLE huesped
ADD CONSTRAINT pk_huesped PRIMARY KEY (id_huesped);

ALTER TABLE huesped
ALTER COLUMN nombre SET NOT NULL;

ALTER TABLE huesped
ALTER COLUMN apellido SET NOT NULL;

ALTER TABLE huesped
ALTER COLUMN dni SET NOT NULL;

ALTER TABLE huesped
ALTER COLUMN historial SET NOT NULL;

ALTER TABLE huesped
ADD CONSTRAINT uk_huesped_dni UNIQUE (dni);

--constraints tabla reserva 
ALTER TABLE reserva
ADD CONSTRAINT pk_reserva PRIMARY KEY (id_reserva);

ALTER TABLE reserva
ALTER COLUMN fch_reserva SET NOT NULL;

ALTER TABLE reserva
ALTER COLUMN estado_reserva SET NOT NULL;

ALTER TABLE reserva
ALTER COLUMN cantidad_personas SET NOT NULL;

ALTER TABLE reserva
ALTER COLUMN id_huesped SET NOT NULL;

ALTER TABLE reserva
ALTER COLUMN id_habitacion SET NOT NULL;

ALTER TABLE reserva
ALTER COLUMN id_empleado SET NOT NULL;

ALTER TABLE reserva
ADD CONSTRAINT fk_reserva_huesped FOREIGN KEY (id_huesped)
REFERENCES huesped(id_huesped);

ALTER TABLE reserva
ADD CONSTRAINT fk_reserva_habitacion FOREIGN KEY (id_habitacion)
REFERENCES habitacion(id_habitacion);

ALTER TABLE reserva
ADD CONSTRAINT fk_reserva_empleado FOREIGN KEY (id_empleado)
REFERENCES empleado(id_empleado);

ALTER TABLE reserva
ADD CONSTRAINT ck_reserva_cantidad_personas
CHECK (cantidad_personas > 0);

--constraints tabla estd_habitacion
ALTER TABLE estd_habitacion
ADD CONSTRAINT pk_estd_habitacion PRIMARY KEY (id_estado);

ALTER TABLE estd_habitacion
ALTER COLUMN nombre_estado SET NOT NULL;

ALTER TABLE estd_habitacion
ADD CONSTRAINT uk_estd_habitacion_nombre_estado UNIQUE (nombre_estado);

-- constraints tabla empleado
ALTER TABLE empleado
ADD CONSTRAINT pk_empleado PRIMARY KEY (id_empleado);

ALTER TABLE empleado
ALTER COLUMN nombre SET NOT NULL;

ALTER TABLE empleado
ALTER COLUMN apellido SET NOT NULL;

ALTER TABLE empleado
ALTER COLUMN dni SET NOT NULL;

ALTER TABLE empleado
ALTER COLUMN telefono SET NOT NULL;

ALTER TABLE empleado
ALTER COLUMN id_rol SET NOT NULL;

ALTER TABLE empleado
ALTER COLUMN id_turno SET NOT NULL;

ALTER TABLE empleado
ADD CONSTRAINT uk_empleado_dni UNIQUE (dni);

ALTER TABLE empleado
ADD CONSTRAINT uk_empleado_correo UNIQUE (correo);

ALTER TABLE empleado
ADD CONSTRAINT fk_empleado_rol FOREIGN KEY (id_rol)
REFERENCES rol_empleado(id_rol);

ALTER TABLE empleado
ADD CONSTRAINT fk_empleado_turno FOREIGN KEY (id_turno)
REFERENCES turno(id_turno);
