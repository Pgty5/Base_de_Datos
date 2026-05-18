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
