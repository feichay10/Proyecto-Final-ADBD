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
    id_isla SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE seres_vivos (
    id_seres_vivos SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nombre_cientifico VARCHAR(100) NOT NULL
);

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

CREATE TABLE sitios_interes (
    id_sitios_interes SERIAL PRIMARY KEY,
    isla_id INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    municipio VARCHAR(50) NOT NULL,
    latitud DECIMAL(9,6) NOT NULL,
    longitud DECIMAL(9,6) NOT NULL,
    foto VARCHAR(100) NOT NULL,
    CONSTRAINT sitios_interes_isla_fkey
        FOREIGN KEY (isla_id)
        REFERENCES isla  (id_isla) ON DELETE CASCADE
);

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

CREATE TABLE nombres_canarios (
    id_nombres_canarios SERIAL PRIMARY KEY,
    id_isla INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT nombres_canarios_isla_fkey
        FOREIGN KEY (id_isla)
        REFERENCES isla (id_isla) ON DELETE CASCADE
);

CREATE TABLE platos (
    id_platos SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE ingredientes (
    id_ingredientes SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE comestibles (
    id_comestibles SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    compania VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE compania (
    id_compania SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    sede VARCHAR(50) NOT NULL,
    fundacion INTEGER NOT NULL
);

CREATE TABLE artesania (
    id_artesania SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    creador VARCHAR,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE folclore (
    id_folclore SERIAL PRIMARY KEY,
    id_artesania INT REFERENCES artesania(id_artesania),
    nombre VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE isla_ecosistema (
    isla_id INT REFERENCES isla(id_isla),
    seres_vivos_id INT REFERENCES seres_vivos(id_seres_vivos),
    animales_autoctonos_id INT REFERENCES animales_autoctonos(id_animales_autoctonos),
    plantas_autoctonas_id INT REFERENCES plantas_autoctonas(id_plantas_autoctonas),
    PRIMARY KEY (isla_id, seres_vivos_id, animales_autoctonos_id, plantas_autoctonas_id)
);

CREATE TABLE tejido_cultural (
    isla_id INT REFERENCES isla(id_isla),
    artesania_id INT REFERENCES artesania(id_artesania),
    sitios_interes_id INT REFERENCES sitios_interes(id_sitios_interes),
    PRIMARY KEY (isla_id, artesania_id, sitios_interes_id)
);

CREATE TABLE plato_ingredientes (
    id_plato_ingredientes SERIAL PRIMARY KEY,
    plato_id INT REFERENCES platos(id_platos),
    ingrediente_id INT REFERENCES ingredientes(id_ingredientes)
);

CREATE TABLE productos (
    id_productos SERIAL PRIMARY KEY,
    comestibles_id INT REFERENCES comestibles(id_comestibles),
    artesania_id INT REFERENCES artesania(id_artesania)
);

CREATE TABLE produccion_compañia (
    productos_id INT REFERENCES productos(id_productos),
    comestibles_id INT REFERENCES comestibles(id_comestibles),
    compania_id INT REFERENCES compania(id_compania),
    PRIMARY KEY (productos_id, comestibles_id, compania_id)
);

CREATE TABLE distribucion_gastronomica (
  isla_id INT REFERENCES isla(id_isla),
  plato_ingrediente_id INT REFERENCES plato_ingredientes(id_plato_ingredientes),
  PRIMARY KEY (isla_id, plato_ingrediente_id)
);

ALTER TABLE platos
ADD CONSTRAINT chk_tipo_plato
CHECK (tipo IN ('Entrante', 'Principal', 'Postre'));

-- -- Inclusión de datos en las distintas tablas

-- -- Inclusión de datos en la tabla de islas
INSERT INTO isla (nombre) VALUES ('Tenerife');
INSERT INTO isla (nombre) VALUES ('Gran Canaria');
INSERT INTO isla (nombre) VALUES ('Lanzarote');
INSERT INTO isla (nombre) VALUES ('Fuerteventura');
INSERT INTO isla (nombre) VALUES ('La Palma');
INSERT INTO isla (nombre) VALUES ('La Gomera');
INSERT INTO isla (nombre) VALUES ('El Hierro');
INSERT INTO isla (nombre) VALUES ('La Graciosa');


-- -- Inclusión de datos en la tabla de distribución poblacional
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Adeje', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Arafo', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Arico', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Arona', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Buenavista del Norte', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Candelaria', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'El Rosario', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'El Sauzal', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'El Tanque', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Fasnia', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Garachico', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Granadilla de Abona', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Guia de Isora', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Güimar', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Icod de los Vinos', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'La Guancha', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'La Matanza de Acentejo', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'La Orotava', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'La Victoria de Acentejo', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Los Realejos', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Los Silos', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Puerto de la Cruz', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'San Cristobal de La Laguna', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'San Juan de la Rambla', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'San Miguel de Abona', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Santa Ursula', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Santiago del Teide', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Tacoronte', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Tegueste', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (1, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 'Vilaflor', 954303);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Agaete', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Agüimes', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Artenara', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Arucas', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Firgas', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Galdar', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Ingenio', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'La Aldea de San Nicolas', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Las Palmas de Gran Canaria', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Mogan', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Moya', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'San Bartolome de Tirajana', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Santa Brigida', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Santa Lucia de Tirajana', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Santa Maria de Guia de Gran Canaria', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Tejeda', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Telde', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Teror', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Valleseco', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Valsequillo de Gran Canaria', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Vega de San Mateo', 8767192);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Arrecife', 156112);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Haria', 156112);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'San Bartolome', 156112);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Teguise', 156112);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Tias', 156112);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Tinajo', 156112);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (3, 'Las Palmas', 'Arrecife', 'Yaiza', 156112);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'Antigua', 113275);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'Betancuria', 113275);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'La Oliva', 113275);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'Pajara', 113275);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'Puerto del Rosario', 113275);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (4, 'Las Palmas', 'Puerto del Rosario', 'Tuineje', 113275);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Barlovento', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Breña Baja', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'El Paso', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Fuencaliente de la Palma', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Garafia', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Los Llanos de Aridane', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Puntagorda', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Puntallana', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'San Andres y Sauces', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Santa Cruz de la Palma', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Tazacorte', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Tijarafe', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (5, 'Santa Cruz de Tenerife', 'Santa Cruz de La Palma', 'Villa de Mazo', 83439);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'Agulo', 21798);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'Alajero', 21798);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'Hermigua', 21798);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'San Sebastian de la Gomera', 21798);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'Valle Gran Rey', 21798);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (6, 'Santa Cruz de Tenerife', 'San Sebastian de la Gomera', 'Vallehermoso', 21798);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (7, 'Santa Cruz de Tenerife', 'Valverde', 'El Pinar de El Hierro', 11423);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (7, 'Santa Cruz de Tenerife', 'Valverde', 'Frontera', 11423);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (7, 'Santa Cruz de Tenerife', 'Valverde', 'Valverde', 11423);


-- -- Inclusión de datos en la tabla de seres vivos
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Lagarto Gigante de El Hierro', 'Gallotia simonyi');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Lagarto Canario Moteado', 'Gallotia intermedia');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Lagarto Gigante de La Gomera', 'Gallotia bravoana');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Lagarto Gigante de La Palma', 'Gallotia auaritae');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Lagarto Gigante de Gran Canaria', 'Gallotia stehlini');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Cuervo Canario', 'Corvus corax canariensis Hartert & Kleinschmidt');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Guirre', 'Neophron percnopterus majorensis');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Cernícalo Canario', 'Falco tinnunculus dacotiae');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Pinzón Azul', 'Fringilla teydea Webb');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Hubara Canaria', 'Chlamydotis undulata fuertaventurae');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Cabra Majorera', 'Capra aegagrus hircus');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Perro Majorero', 'Canis lupus familiaris Linnaeus');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Presa Canario', 'Canis lupus familiaris Linnaeus');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Cocino Negro', 'Sus scrofa domestica');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Perenquén', 'Tarentola delalandii ');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Cangrejo Ciego', 'Munidopsis polymorpha Koelbel');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Lisa Dorada', 'Chalcides viridanus');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Paloma Rabiche', 'Columba junoniae Hartert');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Murciélago de bosque canario', 'Barbastella barbastellus guanchae');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Tarabilla Canaria', 'Saxicola dacotiae');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Granadillo canario', 'Hypericum canariense');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Retama del Teide', 'Spartocytisus sup ranubius');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Flor de mayo', 'Pericallis hadrosoma');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Tajinaste rojo', 'Echium wildpretii');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Cresta de gallo de Moya', 'Isoplexis chalcantha');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Turmero de Inagua', 'Helianthemum inaguae');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Oro de risco', 'Anagyris latifolia');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Madroño canario', 'Arbutus canariensis');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Piñamar', 'Atractylis preauxiana');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Digital de Canarias', 'Digitalis canariensis');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Pino canario', 'Pinus canariensis');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Cardon canario', 'Euphorbia canariensis');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Drago', 'Dracaena draco' );
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Sabina canaria', 'Juniperus turbinata Guss. subsp. canariensis');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Tabaiba blanca',' Euphorbia balsamifera Aiton subsp. balsamifer');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Verode', 'Kleinia neriifolia');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Palmera canaria', 'Phoenix canariensis');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Cedro canario', 'Juniperus cedrus Webb & Berthel. subsp. cedrus');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Bejeque', 'Aeonium canariense (L.) Webb & Berthel');
INSERT INTO seres_vivos(nombre, nombre_cientifico) VALUES ('Follao', 'Viburnum rigidum Vent');

-- -- Inclusión de datos en la tabla de animales autoctonos
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (1, 7, false, 'Insectívoro', 'imagen lagarto');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (2, 1, false, 'Insectívoro', 'imagen lagarto');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (3, 6, false, 'Insectívoro', 'imagen lagarto');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (4, 5, false, 'Insectívoro', 'imagen lagarto');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (5, 2, false, 'Insectívoro', 'imagen lagarto');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (6, 1, false, 'Omnívoro', 'imagen cuervo');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (7, 1, false, 'Carnívoro', 'imagen guirre');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (8, 1, false, 'Carnívoro', 'imagen cernicalo');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (9, 2, false, 'Insectívoro', 'imagen pinzón azul');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (10, 2, false, 'Omnívoro', 'imagen hubara canaria');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (11, 4, false, 'Hervíboro', 'imagen cabra majorera');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (12, 4, false, 'Omnívoro', 'imagen perro majorero');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (13, 1, false, 'Omnívoro', 'imagen presa canario');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (14, 2, false, 'Hervíboro', 'imagen cochino negro');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto) VALUES (15, 7, false, 'Isectívoro', 'imagen perenquén');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto)  VALUES (16, 3, false, 'No Consta', 'imagen cangrejo ciego');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto)  VALUES (17, 1, false, 'Omnívoro', 'imagen lisa dorada');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto)  VALUES (18, 2, false, 'Frugívora', 'imagen paloma rabiche');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto)  VALUES (19, 1, false, 'Insectívoros', 'imagen murciélago de bosque canario');
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta, foto)  VALUES (20, 3, false, 'Insectívoros', 'imagen tarabilla canaria');

-- --  Inclusión de datos en la tabla de plantas autoctonas


