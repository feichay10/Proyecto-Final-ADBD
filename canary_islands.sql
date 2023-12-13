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
    foto BYTEA NOT NULL,
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
    foto BYTEA NOT NULL,
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
    foto BYTEA NOT NULL,
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

-- | ID | Nombre | Isla | Municipio | Coordenadas | Foto |
-- |----|--------|------|-----------|-------------|------|
-- | 1  | Parque Nacional del Teide | Tenerife | La Orotava | 28.272778, -16.6425 | imagen teide |
-- | 2  | Parque Nacional de Garajonay | La Gomera | San Sebastian de la Gomera | 28.12913369218417, -17.23615149033513 | imagen garajonay |
-- | 3  | Parque Nacional de Timanfaya | Lanzarote | Yaiza | 29.016667, -13.75 | imagen timanfaya |
-- | 4  | Parque Nacional de la Caldera de Taburiente | La Palma | El Paso | 28.666667, -17.916667 | imagen caldera |
-- | 5  | Jameos del Agua | Lanzarote | Haria | 29.156940, -13.432052 | imagen jameos |
-- | 6  | Cueva de los Verdes | Lanzarote | Haria | 29.15666604 -13.43666492 | imagen cueva |
-- | 7  | Islote de Lobos | Fuerteventura | La Oliva | 28.751309, -13.823795 | imagen lobos |
-- | 8  | Faro de Morro Jable | Fuerteventura | Pajara | 28.046100, -14.333000 | imagen faro |
-- | 9  | Roque Nublo | Gran Canaria | Tejeda | 27.96843641, -15.610901987 | imagen roque nublo |
-- | 10 | Dunas de Maspalomas | Gran Canaria | San Bartolome de Tirajana | 27.7411868, -15.5752363 | imagen dunas |
-- | 11 | Basilica de Nuestra Señora de la Candelaria | Tenerife | Candelaria | 28.351280, -16.369782 | imagen basilica |
-- | 12 | Siam Park | Tenerife | Adeje | 28.0722780, -16.72556476 | imagen siam park |
-- | 13 | Roque de Agando | La Gomera | San Sebastian de la Gomera | 28.105278, -17.213611 | imagen roque agando |
-- | 14 | Mirador de Abrante | La Gomera | Agulo | 28.18642222, -17.20138288 | imagen mirador |
-- | 15 | Roque de los Muchachos | La Palma | El Paso y Garafia | 28.754167, -17.884722 | imagen roque muchachos |
-- | 16 | Cascada de los Tilos | La Palma | San Andrés y Sauces | 28.7896888723, -17.803475562 | imagen los tilos |
-- | 17 | El Sabinar | El Hierro | Frontera | 27.74907188, -18.126686897 | imagen sabinar |
-- | 18 | Piscina Natural de La Maceta | El Hierro | Frontera | 27.7867001, -18.00821632 | imagen piscina |
-- | 19 | Playa de las Conchas | La Graciosa | Teguise | 29.275086, -13.515858 | imagen conchas |
-- | 20 | Montaña Amarilla | La Graciosa | Teguise | 29.22265552, -13.540063179 | imagen amarilla |

INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Parque Nacional del Teide', 1, 'La Orotava', 28.272778, -16.6425,  pg_read_binary_file('img/sitios-interes/teide.jpg')::bytea);
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Parque Nacional de Garajonay', 6, 'San Sebastian de la Gomera', 28.12913369218417, -17.23615149033513, 'imagen garajonay');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Parque Nacional de Timanfaya', 3, 'Yaiza', 29.016667, -13.75, 'imagen timanfaya');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Parque Nacional de la Caldera de Taburiente', 5, 'El Paso', 28.666667, -17.916667, 'imagen caldera');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Jameos del Agua', 3, 'Haria', 29.156940, -13.432052, 'imagen jameos');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Cueva de los Verdes', 3, 'Haria', 29.15666604, -13.43666492, 'imagen cueva');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Islote de Lobos', 4, 'La Oliva', 28.751309, -13.823795, 'imagen lobos');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Faro de Morro Jable', 4, 'Pajara', 28.046100, -14.333000, 'imagen faro');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Roque Nublo', 2, 'Tejeda', 27.96843641, -15.610901987, 'imagen roque nublo');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Dunas de Maspalomas', 2, 'San Bartolome de Tirajana', 27.7411868, -15.5752363, 'imagen dunas');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Basilica de Nuestra Señora de la Candelaria', 1, 'Candelaria', 28.351280, -16.369782, 'imagen basilica');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Siam Park', 1, 'Adeje', 28.0722780, -16.72556476, 'imagen siam park');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Roque de Agando', 6, 'San Sebastian de la Gomera', 28.105278, -17.213611, 'imagen roque agando');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Mirador de Abrante', 6, 'Agulo', 28.18642222, -17.20138288, 'imagen mirador');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Roque de los Muchachos', 5, 'El Paso y Garafia', 28.754167, -17.884722, 'imagen roque muchachos');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Cascada de los Tilos', 5, 'San Andrés y Sauces', 28.7896888723, -17.803475562, 'imagen los tilos');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('El Sabinar', 7, 'Frontera', 27.74907188, -18.126686897, 'imagen sabinar');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Piscina Natural de La Maceta', 7, 'Frontera', 27.7867001, -18.00821632, 'imagen piscina');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Playa de las Conchas', 8, 'Teguise', 29.275086, -13.515858, 'imagen conchas');
-- INSERT INTO sitios_interes (nombre, isla, municipio, latitud, longitud, foto) VALUES ('Montaña Amarilla', 8, 'Teguise', 29.22265552, -13.540063179, 'imagen amarilla');


-- -- Inclusión de datos en la tabla de animales autóctonos