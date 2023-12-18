CREATE TABLE plantas_autoctonas (
    id_plantas_autoctonas SERIAL PRIMARY KEY,
    ser_vivo_id INT REFERENCES seres_vivos(id_seres_vivos),
    isla_id INTEGER NOT NULL,
    invasoras BOOLEAN NOT NULL,
    foto VARCHAR(100) NOT NULL,
    CONSTRAINT plantas_autoctonas_isla_fkey
        FOREIGN KEY (isla_id)
        REFERENCES isla (id_isla) ON DELETE CASCADE
);