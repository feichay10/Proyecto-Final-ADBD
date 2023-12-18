CREATE TABLE animales_autoctonos (
    id_animales_autoctonos SERIAL PRIMARY KEY,
    ser_vivo_id INT REFERENCES seres_vivos(id_seres_vivos),
    isla_id INTEGER NOT NULL,
    invasoras BOOLEAN NOT NULL,
    dieta VARCHAR(50) NOT NULL,
    foto VARCHAR(100) NOT NULL,
    CONSTRAINT animales_autoctonos_isla_fkey
        FOREIGN KEY (isla_id)
        REFERENCES isla (id_isla) ON DELETE CASCADE
);