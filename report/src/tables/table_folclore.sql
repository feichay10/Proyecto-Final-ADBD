CREATE TABLE folclore (
    id_folclore SERIAL PRIMARY KEY,
    id_artesania INT REFERENCES artesania(id_artesania),
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL
);