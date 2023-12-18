CREATE TABLE distribucion_poblacional (
    id_distribucion_poblacional SERIAL PRIMARY KEY,
    isla_id INTEGER NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    capital VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    poblacion INTEGER NOT NULL,
    CONSTRAINT distribucion_poblacional_isla_fkey
        FOREIGN KEY (isla_id)
        REFERENCES isla (id_isla) ON DELETE CASCADE
);