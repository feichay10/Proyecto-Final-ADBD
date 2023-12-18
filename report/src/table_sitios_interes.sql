CREATE TABLE sitios_interes (
    id_sitios_interes SERIAL PRIMARY KEY,
    isla_id INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    latitud DECIMAL(9,6) NOT NULL,
    longitud DECIMAL(9,6) NOT NULL,
    foto VARCHAR(100) NOT NULL,
    CONSTRAINT sitios_interes_isla_fkey
        FOREIGN KEY (isla_id)
        REFERENCES isla  (id_isla) ON DELETE CASCADE
);