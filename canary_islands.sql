--
-- PostgreSQL database dump
--

-- Dumped from database version 14.10 (Ubuntu 14.10-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.10 (Ubuntu 14.10-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

DROP DATABASE IF EXISTS islas_canarias;
CREATE DATABASE islas_canarias with TEMPLATE = template0 ENCODING = 'UTF8';

ALTER DATABASE islas_canarias OWNER TO postgres;

\connect islas_canarias

DROP SCHEMA IF EXISTS public CASCADE;
CREATE SCHEMA public;

ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

-- Creación de las distintas tablas

CREATE TABLE isla (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE distribucion_poblacional (
    id SERIAL PRIMARY KEY,
    isla INTEGER NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    capital VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    poblacion INTEGER NOT NULL,
    CONSTRAINT distribucion_poblacional_isla_fkey
        FOREIGN KEY (isla) 
        REFERENCES isla (id) ON DELETE CASCADE
);

CREATE TABLE compania (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    sede VARCHAR(50) NOT NULL,
    fundacion INTEGER NOT NULL
);

CREATE TABLE sitios_interes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    isla INTEGER NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    latitud DECIMAL(9,6) NOT NULL,
    longitud DECIMAL(9,6) NOT NULL,
    foto VARCHAR(100) NOT NULL,
    CONSTRAINT sitios_interes_isla_fkey
        FOREIGN KEY (isla) 
        REFERENCES isla  (id) ON DELETE CASCADE
);

CREATE TABLE animales_autoctonos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    isla INTEGER NOT NULL,
    invasoras BOOLEAN NOT NULL,
    dieta VARCHAR(50) NOT NULL,
    foto VARCHAR(100) NOT NULL,
    CONSTRAINT animales_autoctonos_islas_fkey
        FOREIGN KEY (isla) 
        REFERENCES isla (id) ON DELETE CASCADE
);

CREATE TABLE plantas_autoctonas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    nombre_cientifico VARCHAR(50) NOT NULL,
    isla INTEGER NOT NULL,
    invasoras BOOLEAN NOT NULL,
    foto VARCHAR(100) NOT NULL,
    CONSTRAINT plantas_autoctonas_islas_fkey
        FOREIGN KEY (isla) 
        REFERENCES isla (id) ON DELETE CASCADE
);

CREATE TABLE nombres_canarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    isla INTEGER NOT NULL,
    CONSTRAINT nombres_canarios_islas_fkey
        FOREIGN KEY (isla) 
        REFERENCES isla (id) ON DELETE CASCADE
);

CREATE TABLE platos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE ingredientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE plato_ingredientes (
    plato_id INT REFERENCES platos(id),
    ingrediente_id INT REFERENCES ingredientes(id),
    PRIMARY KEY (plato_id, ingrediente_id)
);

CREATE TABLE artesania (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    creador VARCHAR,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE comestibles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    compania VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE   productos (
    comestibles_id INT REFERENCES comestibles(id),
    artesania_id INT REFERENCES artesania(id),
    PRIMARY KEY (comestibles_id, artesania_id)
);

CREATE TABLE canciones (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    autor VARCHAR(50) NOT NULL,
    lanzamiento INTEGER NOT NULL
);

-- -- Inclusión de datos en las distintas tablas

-- -- Inclusión de datos en la tabla de islas
INSERT INTO isla (nombre) VALUES ('Tenerife');
INSERT INTO isla (nombre) VALUES ('Gran Canaria');
INSERT INTO isla (nombre) VALUES ('Lanzarote');
INSERT INTO isla (nombre) VALUES ('Fuerteventura');
INSERT INTO isla (nombre) VALUES ('La Palma');
INSERT INTO isla (nombre) VALUES ('La Gomera');
INSERT INTO isla (nombre) VALUES ('El Hierro');


-- -- Inclusión de datos en la tabla de distribución poblacional
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Adeje', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Arafo', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Arico', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Arona', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Buenavista del Norte', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Candelaria', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'El Rosario', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'El Sauzal', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'El Tanque', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Fasnia', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Garachico', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Granadilla de Abona', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Guia de Isora', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Güimar', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Icod de los Vinos', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'La Guancha', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'La Matanza de Acentejo', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'La Orotava', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'La Victoria de Acentejo', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Los Realejos', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Los Silos', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Puerto de la Cruz', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'San Cristobal de La Laguna', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'San Juan de la Rambla', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'San Miguel de Abona', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Santa Ursula', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Santiago del Teide', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Tacoronte', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Tegueste', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Vilaflor', 954303);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Agaete', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Agüimes', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Artenara', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Arucas', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Firgas', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Galdar', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Ingenio', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'La Aldea de San Nicolas', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Las Palmas de Gran Canaria', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Mogan', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Moya', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'San Bartolome de Tirajana', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Santa Brigida', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Santa Lucia de Tirajana', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Santa Maria de Guia de Gran Canaria', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Tejeda', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Telde', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Teror', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Valleseco', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Valsequillo de Gran Canaria', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Vega de San Mateo', 8767192);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Arrecife', 156112);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Haria', 156112);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'San Bartolome', 156112);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Teguise', 156112);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Tias', 156112);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Tinajo', 156112);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Yaiza', 156112);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'Antigua', 113275);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'Betancuria', 113275);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'La Oliva', 113275);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'Pajara', 113275);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'Puerto del Rosario', 113275);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'Tuineje', 113275);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Barlovento', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Breña Baja', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'El Paso', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Fuencaliente de la Palma', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Garafia', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Los Llanos de Aridane', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Puntagorda', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Puntallana', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'San Andres y Sauces', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Santa Cruz de la Palma', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Tazacorte', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Tijarafe', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Villa de Mazo', 83439);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'Agulo', 21798);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'Alajero', 21798);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'Hermigua', 21798);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'San Sebastian de la Gomera', 21798);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'Valle Gran Rey', 21798);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'Vallehermoso', 21798);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (7, 'Santa Cruz de Tenerife', 'Valverde', 'El Pinar de El Hierro', 11423);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (7, 'Santa Cruz de Tenerife', 'Valverde', 'Frontera', 11423);
INSERT INTO distribucion_poblacional (isla, provincia, capital, municipio, poblacion) VALUES (7, 'Santa Cruz de Tenerife', 'Valverde', 'Valverde', 11423);


-- -- Inclusión de datos en la tabla de compañías

INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Binter Canarias', 'Aerolínea', 2, 1989);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Fred Olsen Express', 'Naviera', 2, 1974);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Naviera Armas', 'Naviera', 2, 1941);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Islas Airways', 'Aerolínea', 1, 2002);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Canarias Airlines', 'Aerolínea', 1, 2011);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Canaryfly', 'Aerolínea', 2, 2008);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Compañía Cervecera de Canarias', 'Cervecería', 1, 1939);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Compañía Insular Tabacalera Canaria', 'Tabacalera', 2, 1936);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Tirma', 'Chocolate', 2, 1941);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Destilerías Arehucas', 'Licores', 2, 1884);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Destilería Aldea', 'Licores', 2, 1936);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Ahembo', 'Refrescos', 2, 1956);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Hiperdino Supermercados', 'Servicios', 2, 1978);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Supermercados Tu Alteza', 'Supermercados', 1, 2005);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Fundación La Caja Canarias', 'Obra Social', 2, 1939);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Fundación CajaCanarias', 'Obra Social', 1, 1939);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Disa', 'Hidrocarburo', 1, 1933);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Libby´s', 'Comida', 1, 1971);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Bandama', 'Comida', 2, 1958);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Montesano', 'Comida', 1, 1965);
INSERT INTO compania (nombre, tipo, sede, fundacion) VALUES ('Kalise', 'Lácteos', 2, 1960);

-- -- Inclusión de datos en la tabla de sitios de interés

INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Parque Nacional del Teide', 1, 'La Orotava', 28.272778, -16.6425,  'img/sitios-interes/teide.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Parque Nacional de Garajonay', 6, 'San Sebastian de la Gomera', 28.12913369218417, -17.23615149033513, 'img/sitios-interes/garajonay.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Parque Nacional de Timanfaya', 3, 'Yaiza', 29.016667, -13.75, 'img/sitios-interes/timanfaya.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Parque Nacional de la Caldera de Taburiente', 5, 'El Paso', 28.666667, -17.916667, 'img/sitios-interes/caldera.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Jameos del Agua', 3, 'Haria', 29.156940, -13.432052, 'img/sitios-interes/jameos.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Cueva de los Verdes', 3, 'Haria', 29.15666604, -13.43666492, 'img/sitios-interes/cueva.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Islote de Lobos', 4, 'La Oliva', 28.751309, -13.823795, 'img/sitios-interes/lobos.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Faro de Morro Jable', 4, 'Pajara', 28.046100, -14.333000, 'img/sitios-interes/faro.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Roque Nublo', 2, 'Tejeda', 27.96843641, -15.610901987, 'img/sitios-interes/roque-nublo.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Dunas de Maspalomas', 2, 'San Bartolome de Tirajana', 27.7411868, -15.5752363, 'img/sitios-interes/dunas.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Basilica de Nuestra Señora de la Candelaria', 1, 'Candelaria', 28.351280, -16.369782, 'img/sitios-interes/basilica.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Siam Park', 1, 'Adeje', 28.0722780, -16.72556476, 'img/sitios-interes/siam-park.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Roque de Agando', 6, 'San Sebastian de la Gomera', 28.105278, -17.213611, 'img/sitios-interes/roque-agando.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Mirador de Abrante', 6, 'Agulo', 28.18642222, -17.20138288, 'img/sitios-interes/mirador.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Roque de los Muchachos', 5, 'El Paso y Garafia', 28.754167, -17.884722, 'img/sitios-interes/roque-muchachos.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Cascada de los Tilos', 5, 'San Andrés y Sauces', 28.7896888723, -17.803475562, 'img/sitios-interes/tilos.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('El Sabinar', 7, 'Frontera', 27.74907188, -18.126686897, 'img/sitios-interes/sabinar.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Piscina Natural de La Maceta', 7, 'Frontera', 27.7867001, -18.00821632, 'img/sitios-interes/piscina.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Playa de las Conchas', 8, 'Teguise', 29.275086, -13.515858, 'img/sitios-interes/conchas.jpg');
INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Montaña Amarilla', 8, 'Teguise', 29.22265552, -13.540063179, 'img/sitios-interes/amarilla.jpg');

-- -- Inclusión de datos en la tabla de animales autóctonos

-- | ID | Nombre | Nombre Científico | Islas | Invasoras | Dieta | Foto |
-- |----|--------|-------------------|-------|-----------|-------|------|
-- | 1  | Lagarto Gigante de El Hierro | Gallotia simonyi | El Hierro | false | Insectívoro | imagen lagarto |
-- | 2  | Lagarto Canario Moteado | Gallotia intermedia | Tenerife | false | Insectívoro | imagen lagarto |
-- | 3  | Lagarto Gigante de La Gomera | Gallotia bravoana | La Gomera | false | Insectívoro | imagen lagarto |
-- | 4  | Lagarto Gigante de La Palma | Gallotia auaritae | La Palma | false | Insectívoro | imagen lagarto |
-- | 5  | Lagarto Gigante de Gran Canaria | Gallotia stehlini | Gran Canaria | false | Insectívoro | imagen lagarto |
-- | 6  | Cuervo Canario | Corvus corax canariensis Hartert & Kleinschmidt | Lanzarote, Fuerteventura, Gran Canaria, Tenerife, La Palma, La Gomera, El Hierro | false | Omnívoro | imagen cuervo |
-- | 7  | Guirre | Neophron percnopterus majorensis | Lanzarote, Fuerteventura, Gran Canaria, Tenerife, La Gomera | false | Carnívoro | imagen guirre |
-- | 8  | Cernícalo Canario | Falco tinnunculus dacotiae | Lanzarote, Fuerteventura, Gran Canaria, Tenerife, La Gomera, La Palma, El Hierro | false | Carnívoro | imagen cernicalo |
-- | 9  | Pinzón Azul | Fringilla teydea Webb |  Gran Canaria, Tenerife | false | Insectívoro | imagen pinzón azul |
-- | 10 | Hubara Canaria | Chlamydotis undulata fuertaventurae | Lanzarote, Fuerteventura,  Tenerife | false | Omnívoro | imagen hubara canaria |
-- | 11 | Cabra Majorera | Capra aegagrus hircus | Fuerteventura | false | Hervíboro | imagen cabra majorera |
-- | 12 | Perro Majorero | Canis lupus familiaris Linnaeus | Lanzarote, Fuerteventura, Gran Canaria, Tenerife, La Palma, La Gomera, El Hierro | false | Omnívoro | imagen perro majorero |
-- | 13 | Presa Canario | Canis lupus familiaris Linnaeus | Lanzarote, Fuerteventura, Gran Canaria, Tenerife, La Palma, La Gomera, El Hierro | false | Omnívoro | imagen presa canario |
-- | 14 | Cochino Negro | Sus scrofa domestica | Lanzarote, Fuerteventura, Gran Canaria, Tenerife, La Palma, La Gomera, El Hierro | false | Hervíboro | imagen cochino negro |
-- | 15 | Perenquén | Tarentola delalandii | Lanzarote, Fuerteventura, Gran Canaria, Tenerife, La Palma, La Gomera, El Hierro | false | Isectívoro | imagen perenquén |
-- | 16 | Cangrejo Ciego | Munidopsis polymorpha Koelbel | Lanzarote | false | No Consta | imagen cangrejo ciego |
-- | 17 | Lisa Dorada | Chalcides viridanus | Tenerife, La Palma, La Gomera, El Hierro | false | Omnívoro | imagen lisa dorada |
-- | 18 | Paloma Rabiche | Columba junoniae Hartert | Tenerife, La Palma, La Gomera, El Hierro | false | Frugívora | imagen paloma rabiche |
-- | 19 | Murciélago de bosque canario | Barbastella barbastellus guanchae | Tenerife, Gran Canaria | false | Insectívoros | imagen murciélago de bosque canario |
-- | 20 | Tarabilla Canaria | Saxicola dacotiae | Lanzarote, Fuerteventura | false | Insectívoros | imagen tarabilla canaria |

INSERT INTO animales_autoctonos 