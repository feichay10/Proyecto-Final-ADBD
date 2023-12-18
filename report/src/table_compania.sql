CREATE TABLE compania (
    id_compania SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    sede VARCHAR(50) NOT NULL,
    fundacion INTEGER NOT NULL
);