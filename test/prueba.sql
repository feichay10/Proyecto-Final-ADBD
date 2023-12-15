CREATE DATABASE prueba;

\connect prueba

CREATE TABLE imagenes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    contenido BYTEA
);

-- INSERT INTO imagenes (nombre, contenido) VALUES ('imagen1', bytea('img/sitios-interes/teide.jpg'));

-- Inserta una imagen directamente en la base de datos
-- INSERT INTO imagenes (nombre, contenido) VALUES ('teide', E'\\x' || encode(pg_read_binary_file('../img/sitios-interes/teide.jpg'), 'hex'));
INSERT INTO imagenes (nombre, contenido) VALUES ('teide', E'\\x' || encode(pg_read_binary_file('ruta/a/tu/imagen.jpg'), 'hex'));