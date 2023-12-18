CREATE TABLE artesania (
    id_artesania SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    creador VARCHAR,
    tipo VARCHAR(50) NOT NULL
);