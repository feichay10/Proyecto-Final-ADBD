CREATE TABLE nombres_canarios (
    id_nombres_canarios SERIAL PRIMARY KEY,
    id_isla INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT nombres_canarios_isla_fkey
        FOREIGN KEY (id_isla)
        REFERENCES isla (id_isla) ON DELETE CASCADE
);