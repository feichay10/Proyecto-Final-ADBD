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
    ser_vivo_id INT REFERENCES seres_vivos(id_seres_vivos) ON DELETE CASCADE,
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
    ser_vivo_id INT REFERENCES seres_vivos(id_seres_vivos) ON DELETE CASCADE,
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
    genero VARCHAR(50) NOT NULL,
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
    isla_id INT REFERENCES isla(id_isla) ON DELETE CASCADE,
    nombre VARCHAR(50) NOT NULL,
    creador VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE folclore (
    id_folclore SERIAL PRIMARY KEY,
    id_artesania INT REFERENCES artesania(id_artesania) ON DELETE CASCADE,
    nombre VARCHAR(50) NOT NULL,
    autor VARCHAR(50) NOT NULL,
    lanzamiento INTEGER NOT NULL
);

CREATE TABLE isla_ecosistema (
    id_isla_ecosistema SERIAL,
    isla_id INT REFERENCES isla(id_isla) ON DELETE CASCADE,
    seres_vivos_id INT REFERENCES seres_vivos(id_seres_vivos) ON DELETE CASCADE,
    animales_autoctonos_id INT REFERENCES animales_autoctonos(id_animales_autoctonos) ON DELETE CASCADE,
    plantas_autoctonas_id INT REFERENCES plantas_autoctonas(id_plantas_autoctonas) ON DELETE CASCADE,
    PRIMARY KEY (id_isla_ecosistema, isla_id)
);

CREATE TABLE tejido_cultural (
    id_tejido_cultural SERIAL,
    isla_id INT REFERENCES isla(id_isla) ON DELETE CASCADE,
    artesania_id INT REFERENCES artesania(id_artesania) ON DELETE CASCADE,
    sitios_interes_id INT REFERENCES sitios_interes(id_sitios_interes) ON DELETE CASCADE,
    PRIMARY KEY (id_tejido_cultural, isla_id)
);

CREATE TABLE plato_ingredientes (
    id_plato_ingredientes SERIAL PRIMARY KEY,
    plato_id INT REFERENCES platos(id_platos) ON DELETE CASCADE,
    ingrediente_id INT REFERENCES ingredientes(id_ingredientes) ON DELETE CASCADE
);

CREATE TABLE productos (
    id_productos SERIAL PRIMARY KEY,
    comestibles_id INT REFERENCES comestibles(id_comestibles) ON DELETE CASCADE,
    artesania_id INT REFERENCES artesania(id_artesania) ON DELETE CASCADE
);

CREATE TABLE produccion_compañia (
    comestibles_id INT REFERENCES comestibles(id_comestibles) ON DELETE CASCADE,
    compania_id INT REFERENCES compania(id_compania) ON DELETE CASCADE,
    PRIMARY KEY (comestibles_id, compania_id)
);

CREATE TABLE distribucion_gastronomica (
  isla_id INT REFERENCES isla(id_isla) ON DELETE CASCADE,
  platos_id INT REFERENCES platos(id_platos) ON DELETE CASCADE,
  PRIMARY KEY (isla_id, platos_id)
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
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Agaete', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Agüimes', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Artenara', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Arucas', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Firgas', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Galdar', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Ingenio', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'La Aldea de San Nicolas', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Las Palmas de Gran Canaria', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Mogan', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Moya', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'San Bartolome de Tirajana', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Santa Brigida', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Santa Lucia de Tirajana', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Santa Maria de Guia de Gran Canaria', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Tejeda', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Telde', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Teror', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Valleseco', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Valsequillo de Gran Canaria', 853262);
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion) VALUES (2, 'Las Palmas', 'Las Palmas de Gran Canaria', 'Vega de San Mateo', 853262);
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

-- -- Inclusión de datos en la tabla de plantas autóctonas
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (21, 2, false, 'imagen granadillo');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (22, 1, false, 'imagen retama teide');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (23, 6, false, 'imagen flor mayo');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (24, 1, false, 'imagen tajinaste rojo');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (25, 2, false, 'imagen cresta gallo');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (26, 2, false, 'imagen turmero');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (27, 5, false, 'imagen oro risco');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (28, 7, false, 'imagen madroño');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (29, 2, false, 'imagen piñamar');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (30, 1, false, 'imagen digital');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (31, 1, false, 'imagen pino');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (32, 4, false, 'imagen cardon');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (33, 1, false, 'imagen drago');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (34, 7, false, 'imagen sabina');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (35, 3, false, 'imagen tabaiba blanca');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (36, 1, false, 'imagen verode');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (37, 2, false, 'imagen palmera');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (38, 6, false, 'imagen cedro');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (39, 1, false, 'imagen bejeque');
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras, foto) VALUES (40, 5, false, 'imagen follao');

-- -- Inclusión de datos en la tabla de sitios de interes
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (1, 'Parque Nacional del Teide', 'La Orotava', 28.272778, -16.6425, 'imagen teide');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (6, 'Parque Nacional de Garajonay', 'San Sebastian de la Gomera', 28.12913369218417, -17.23615149033513, 'imagen garajonay');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (3, 'Parque Nacional de Timanfaya', 'Yaiza', 29.016667, -13.75, 'imagen timanfaya');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (5, 'Parque Nacional de la Caldera de Taburiente', 'El Paso', 28.666667, -17.916667, 'imagen caldera');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (3, 'Jameos del Agua', 'Haria', 29.156940, -13.432052, 'imagen jameos');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (3, 'Cueva de los Verdes', 'Haria', 29.15666604, -13.43666492, 'imagen cueva');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (4, 'Islote de Lobos', 'La Oliva', 28.751309, -13.823795, 'imagen lobos');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (4, 'Faro de Morro Jable', 'Pajara', 28.046100, -14.333000, 'imagen faro');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (2, 'Roque Nublo', 'Tejeda', 27.96843641, -15.610901987, 'imagen roque nublo');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (2, 'Dunas de Maspalomas', 'San Bartolome de Tirajana', 27.7411868, -15.5752363, 'imagen dunas');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (1, 'Basilica de Nuestra Señora de la Candelaria', 'Candelaria', 28.351280, -16.369782, 'imagen basilica');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (1, 'Siam Park', 'Adeje', 28.0722780, -16.72556476, 'imagen siam park');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (6, 'Roque de Agando', 'San Sebastian de la Gomera', 28.105278, -17.213611, 'imagen roque agando');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (6, 'Mirador de Abrante', 'Agulo', 28.18642222, -17.20138288, 'imagen mirador');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (5, 'Roque de los Muchachos', 'El Paso y Garafia', 28.754167, -17.884722, 'imagen roque muchachos');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (5, 'Cascada de los Tilos', 'San Andrés y Sauces', 28.7896888723, -17.803475562, 'imagen los tilos');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (7, 'El Sabinar', 'Frontera', 27.74907188, -18.126686897, 'imagen sabinar');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (7, 'Piscina Natural de La Maceta', 'Frontera', 27.7867001, -18.00821632, 'imagen piscina');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (3, 'Playa de las Conchas', 'Teguise', 29.275086, -13.515858, 'imagen conchas');
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud, foto) VALUES (3, 'Montaña Amarilla', 'Teguise', 29.22265552, -13.540063179, 'imagen amarilla');

-- -- Inclusión de datos en la tabla de nombres canarios
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (1, 'Aday', 'Hombre');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (1, 'Adexe', 'Hombre');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (3, 'Echedey', 'Hombre');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (2, 'Nauzet', 'Hombre');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (1, 'Cathaysa', 'Mujer');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (1, 'Guacimara', 'Mujer');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (3, 'Famara', 'Mujer');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (2, 'Guayarmina', 'Mujer');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (5, 'Briseida', 'Mujer');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (1, 'Isora', 'Mujer');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (6, 'Moneiba', 'Mujer');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (3, 'Timanfaya', 'Mujer');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (6, 'Garoe', 'Hombre');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (3, 'Yaiza', 'Mujer');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (4, 'Aday', 'Hombre');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (4, 'Dara', 'Mujer');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (5, 'Tanausú', 'Hombre');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (1, 'Bencomo', 'Hombre');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (2, 'Doramas', 'Hombre');
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (3, 'Zonzamas', 'Hombre');

-- -- Inclusión de datos en la tabla de platos
INSERT INTO platos(nombre, tipo) VALUES ('Papas arrugadas', 'Principal');
INSERT INTO platos(nombre, tipo) VALUES ('Cocido canario', 'Principal');
INSERT INTO platos(nombre, tipo) VALUES ('Conejo en salmorejo', 'Principal');
INSERT INTO platos(nombre, tipo) VALUES ('Ropa vieja', 'Principal');
INSERT INTO platos(nombre, tipo) VALUES ('Potaje de Berros', 'Entrante');
INSERT INTO platos(nombre, tipo) VALUES ('Puchero canario', 'Entrante');
INSERT INTO platos(nombre, tipo) VALUES ('Queso asado con mojo', 'Entrante');
INSERT INTO platos(nombre, tipo) VALUES ('Escaldón de gofio', 'Entrante');
INSERT INTO platos(nombre, tipo) VALUES ('Carne fiesta', 'Principal');
INSERT INTO platos(nombre, tipo) VALUES ('Carne cabra compuesta', 'Principal'); 
INSERT INTO platos(nombre, tipo) VALUES ('Bienmesabe', 'Postre');
INSERT INTO platos(nombre, tipo) VALUES ('Costillas con piña', 'Principal');
INSERT INTO platos(nombre, tipo) VALUES ('Lapas con mojo', 'Principal');
INSERT INTO platos(nombre, tipo) VALUES ('Rancho canario', 'Entrante');
INSERT INTO platos(nombre, tipo) VALUES ('Vieja sancochada', 'Principal');

-- -- Inclusión de datos en la tabla de ingredientes
INSERT INTO ingredientes(nombre) VALUES ('Papas');
INSERT INTO ingredientes(nombre) VALUES ('Sal');
INSERT INTO ingredientes(nombre) VALUES ('Garbanzos');
INSERT INTO ingredientes(nombre) VALUES ('Carne');
INSERT INTO ingredientes(nombre) VALUES ('Verduras');
INSERT INTO ingredientes(nombre) VALUES ('Conejo');
INSERT INTO ingredientes(nombre) VALUES ('Ajo');
INSERT INTO ingredientes(nombre) VALUES ('Pimentón');
INSERT INTO ingredientes(nombre) VALUES ('Berros');
INSERT INTO ingredientes(nombre) VALUES ('Carne de cerdo salada'); 
INSERT INTO ingredientes(nombre) VALUES ('Judías');
INSERT INTO ingredientes(nombre) VALUES ('Piña de millo');
INSERT INTO ingredientes(nombre) VALUES ('Gofio');
INSERT INTO ingredientes(nombre) VALUES ('Caldo de carne o pescado');
INSERT INTO ingredientes(nombre) VALUES ('Pimientos');
INSERT INTO ingredientes(nombre) VALUES ('Cebolla');
INSERT INTO ingredientes(nombre) VALUES ('Vino blanco');
INSERT INTO ingredientes(nombre) VALUES ('Almendras');
INSERT INTO ingredientes(nombre) VALUES ('Azúcar');
INSERT INTO ingredientes(nombre) VALUES ('Yemas de huevo'); 
INSERT INTO ingredientes(nombre) VALUES ('Limón');
INSERT INTO ingredientes(nombre) VALUES ('Canela');
INSERT INTO ingredientes(nombre) VALUES ('Costillas de cerdo');
INSERT INTO ingredientes(nombre) VALUES ('Lapas');
INSERT INTO ingredientes(nombre) VALUES ('Vieja');
INSERT INTO ingredientes(nombre) VALUES ('Mojo');
INSERT INTO ingredientes(nombre) VALUES ('Queso');
INSERT INTO ingredientes(nombre) VALUES ('Escaldón');
INSERT INTO ingredientes(nombre) VALUES ('Tomillo');
INSERT INTO ingredientes(nombre) VALUES ('Tomate');
INSERT INTO ingredientes(nombre) VALUES ('Laurel');
INSERT INTO ingredientes(nombre) VALUES ('Carne de cabra');

-- -- Inclusión de datos en la tabla de platos_ingredientes
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (1, 1);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (1, 2);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (2, 3);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (2, 4);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (2, 5);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (3, 6);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (3, 7);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (3, 8);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (4, 3);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (4, 4);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (4, 5);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (5, 9);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (5, 10);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (5, 11);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (5, 12);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (5, 13);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (6, 3);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (6, 4);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (6, 5);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (7, 14);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (7, 15);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (8, 13);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (8, 16);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (9, 4);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (9, 1);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (9, 15);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (9, 17);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (9, 18);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (9, 19);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (9, 20);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (10, 32);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (10, 16);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (10, 7);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (11, 18);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (11, 21);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (11, 22);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (12, 23);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (13, 24);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (13, 26);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (14, 3);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (14, 4);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (14, 5);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (15, 25);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (15, 1);
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (15, 26);

-- -- Inclusión de datos en la tabla de comestibles
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Clipper', 'Ahembo', 'Bebida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Dorada', 'Compañía Cervecera de Canarias', 'Bebida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Tropical', 'Compañía Cervecera de Canarias', 'Bebida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Ron Arehucas', 'Destilerías Arehucas', 'Bebida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Ron Guajiro', 'Destilería Aldea', 'Bebida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Munchitos', 'Matutano', 'Comida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Chorizo de Teror', 'Chorizo Terorero', 'Comida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Nestea mango piña', 'Nestea', 'Bebida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Ambrosias Tirma', 'Tirma', 'Comida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Queso cabra tierno', 'Queseria El Faro', 'Comida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Queso del Hierro', 'Cooperativa de Ganaderos de El Hierro', 'Comida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Quesadillas de El Hierro', 'Fábrica de Quesadillas Adrián Gutierrez e Hijas', 'Comida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Gofio La Piña', 'Gofio La Piña', 'Comida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Cubanitos', 'Bandama', 'Comida');
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Batatitos', 'Batatitos Snacks', 'Comida'); 

-- -- Inclusión de datos en la tabla de compania
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Binter Canarias', 'Aerolínea', 'Gran Canaria', 1989);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Fred Olsen Express', 'Naviera', 'Gran Canaria', 1974);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Naviera Armas', 'Naviera', 'Gran Canaria', 1941);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Islas Airways', 'Aerolínea', 'Tenerife', 2002);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Canarias Airlines', 'Aerolínea', 'Tenerife', 2011);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Canaryfly', 'Aerolínea', 'Gran Canaria', 2008);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Compañía Cervecera de Canarias', 'Cervecería', 'Tenerife', 1939);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Compañía Insular Tabacalera Canaria', 'Tabacalera', 'Gran Canaria', 1936);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Tirma', 'Chocolate', 'Gran Canaria', 1941);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Destilerías Arehucas', 'Licores', 'Gran Canaria', 1884); 
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Destilería Aldea', 'Licores', 'Gran Canaria', 1936);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Ahembo', 'Refrescos', 'Gran Canaria', 1956);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Hiperdino Supermercados', 'Servicios', 'Gran Canaria', 1978);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Supermercados Tu Alteza', 'Supermercados', 'Tenerife', 2005);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Fundación La Caja Canarias', 'Obra Social', 'Gran Canaria', 1939);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Fundación CajaCanarias', 'Obra Social', 'Tenerife', 1939);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Disa', 'Hidrocarburo', 'Tenerife', 1933);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Libby´s', 'Comida', 'Tenerife', 1971);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Bandama', 'Comida', 'Gran Canaria', 1958);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Montesano', 'Comida', 'Tenerife', 1965);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Kalise', 'Lácteos', 'Gran Canaria', 1960);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Gofio La Piña', 'Comida', 'Gran Canaria', 1940);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Batatitos Snacks', 'Comida', 'Lanzarote', 1980);
INSERT INTO compania(nombre, tipo, sede, fundacion) VALUES ('Queseria El Faro', 'Comida', 'Lanzarote', 1990);


-- -- Inclusión de datos en la tabla de artesania
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (1, 'Cuchillo Canario', 'Desconocido', 'Herramienta');
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (3, 'Los novios del Mojón', 'Desconocido', 'Alfarería');
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (2, 'Ídolo de Tara', 'Desconocido', 'Escultura');
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (7, 'Tambor del Hierro', 'Desconocido', 'Música');
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (3, 'Timple', 'Desconocido', 'Música');
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (2, 'Zurrón', 'Desconocido', 'Herramienta');
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (7, 'Chácaras', 'Desconocido', 'Música');
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (2, 'Lebrillo', 'Desconocido', 'Herramienta');
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (7, 'Pito herreño', 'Desconocido', 'Música');
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (4, 'Tabajoste', 'Desconocido', 'Herramienta');
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (6, 'Tambor gomero', 'Desconocido', 'Música');
INSERT INTO artesania(isla_id, nombre, creador, tipo) VALUES (5, 'Bola Canaria', 'Desconocido', 'Alfarería');

-- -- Inclusión de datos en la tabla de folclore
INSERT INTO folclore(id_artesania, nombre, autor, lanzamiento) VALUES (5, 'Cabra Loca', 'Los Gofiones', 2012);
INSERT INTO folclore(id_artesania, nombre, autor, lanzamiento) VALUES (5, 'Vivo en un archipielago', 'Pololo', 2008);
INSERT INTO folclore(id_artesania, nombre, autor, lanzamiento) VALUES (5, 'Folias de la Libertad', 'Los Sabandeños', 2012);
INSERT INTO folclore(id_artesania, nombre, autor, lanzamiento) VALUES (5, 'Amo la Vida', 'El Vega Life', 2020);
INSERT INTO folclore(id_artesania, nombre, autor, lanzamiento) VALUES (5, 'Mi Paraiso', 'El Vega Life', 2020);
INSERT INTO folclore(id_artesania, nombre, autor, lanzamiento) VALUES (5, 'Vamos cantemos somos 7 sobre el mismo mar', 'Benito Cabrera', 2001);
INSERT INTO folclore(id_artesania, nombre, autor, lanzamiento) VALUES (5, 'La Gomera', 'Benito Cabrera', 2001);

-- -- Inclusión de datos en la tabla de isla_ecosistema
ALTER TABLE isla_ecosistema
ALTER COLUMN plantas_autoctonas_id DROP NOT NULL,
ALTER COLUMN animales_autoctonos_id DROP NOT NULL;

TRUNCATE TABLE isla_ecosistema;

INSERT INTO isla_ecosistema(isla_id, seres_vivos_id, animales_autoctonos_id, plantas_autoctonas_id)
SELECT isla_id, ser_vivo_id, id_animales_autoctonos, NULL
FROM animales_autoctonos;

INSERT INTO isla_ecosistema(isla_id, seres_vivos_id, animales_autoctonos_id, plantas_autoctonas_id)
SELECT isla_id, ser_vivo_id, NULL, id_plantas_autoctonas
FROM plantas_autoctonas;


-- -- Inclusión de datos de la tabla tejido_cultural
ALTER TABLE tejido_cultural
ALTER COLUMN artesania_id DROP NOT NULL,
ALTER COLUMN sitios_interes_id DROP NOT NULL;

TRUNCATE TABLE tejido_cultural;

INSERT INTO tejido_cultural(isla_id, artesania_id, sitios_interes_id)
SELECT isla_id, id_artesania, NULL
FROM artesania;

INSERT INTO tejido_cultural(isla_id, artesania_id, sitios_interes_id)
SELECT isla_id, NULL, id_sitios_interes
FROM sitios_interes;

-- -- Inclusión de datos de la tabla productos
ALTER TABLE productos
ALTER COLUMN comestibles_id DROP NOT NULL,
ALTER COLUMN artesania_id DROP NOT NULL;

INSERT INTO productos(comestibles_id, artesania_id)
SELECT id_comestibles, NULL
FROM comestibles;

INSERT INTO productos(comestibles_id, artesania_id)
SELECT NULL, id_artesania
FROM artesania;

-- -- Inclusión de datos de la tabla produccion_compañia
INSERT INTO produccion_compañia(comestibles_id, compania_id)
SELECT id_comestibles, id_compania
FROM comestibles INNER JOIN compania ON comestibles.compania = compania.nombre;

-- -- Inclusión de datos de la tabla distribución gastronómica
INSERT INTO distribucion_gastronomica(isla_id, platos_id)
SELECT isla.id_isla, platos.id_platos
FROM isla, platos;

-- -- IMPLEMENTACIÓN DE LOS DISTINTOS TRIGGERS PARA LA BASE DE DATOS
-- -- Trigger para la tabla de isla_ecosistema
-- Si se añade una nueva tupla dentro de la tabla de animales_autoctonos, se añadirá una nueva tupla en la tabla de isla_ecosistema
CREATE OR REPLACE FUNCTION insertar_animal_autoctono() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO isla_ecosistema(isla_id, seres_vivos_id, animales_autoctonos_id, plantas_autoctonas_id)
    VALUES (NEW.isla_id, NEW.ser_vivo_id, NEW.id_animales_autoctonos, NULL);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_animal_autoctono
AFTER INSERT ON animales_autoctonos
FOR EACH ROW
EXECUTE PROCEDURE insertar_animal_autoctono();

-- Si se añade una nueva tupla dentro de la tabla de plantas_autoctonas, se añadirá una nueva tupla en la tabla de isla_ecosistema
CREATE OR REPLACE FUNCTION insertar_planta_autoctona() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO isla_ecosistema(isla_id, seres_vivos_id, animales_autoctonos_id, plantas_autoctonas_id)
    VALUES (NEW.isla_id, NEW.ser_vivo_id, NULL, NEW.id_plantas_autoctonas);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_planta_autoctona
AFTER INSERT ON plantas_autoctonas
FOR EACH ROW
EXECUTE PROCEDURE insertar_planta_autoctona();

-- Si se elimina una tupla dentro de la tabla de animales_autoctonos, se eliminará la tupla correspondiente en la tabla de isla_ecosistema
CREATE OR REPLACE FUNCTION eliminar_animal_autoctono() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM isla_ecosistema
    WHERE animales_autoctonos_id = OLD.id_animales_autoctonos;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_animal_autoctono
BEFORE DELETE ON animales_autoctonos
FOR EACH ROW
EXECUTE PROCEDURE eliminar_animal_autoctono();

-- Si se elimina una tupla dentro de la tabla de plantas_autoctonas, se eliminará la tupla correspondiente en la tabla de isla_ecosistema
CREATE OR REPLACE FUNCTION eliminar_planta_autoctona() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM isla_ecosistema
    WHERE plantas_autoctonas_id = OLD.id_plantas_autoctonas;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_planta_autoctona
BEFORE DELETE ON plantas_autoctonas
FOR EACH ROW
EXECUTE PROCEDURE eliminar_planta_autoctona();

-- -- Trigger para la tabla de tejido_cultural
-- Si se añade una nueva tupla dentro de la tabla de artesania, se añadirá una nueva tupla en la tabla de tejido_cultural
CREATE OR REPLACE FUNCTION insertar_artesania() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO tejido_cultural(isla_id, artesania_id, sitios_interes_id)
    VALUES (NEW.isla_id, NEW.id_artesania, NULL);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_artesania
AFTER INSERT ON artesania
FOR EACH ROW
EXECUTE PROCEDURE insertar_artesania();

-- Si se añade una nueva tupla dentro de la tabla de sitios_interes, se añadirá una nueva tupla en la tabla de tejido_cultural
CREATE OR REPLACE FUNCTION insertar_sitio_interes() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO tejido_cultural(isla_id, artesania_id, sitios_interes_id)
    VALUES (NEW.isla_id, NULL, NEW.id_sitios_interes);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_sitio_interes
AFTER INSERT ON sitios_interes
FOR EACH ROW
EXECUTE PROCEDURE insertar_sitio_interes();

-- Si se elimina una tupla dentro de la tabla de artesania, se eliminará la tupla correspondiente en la tabla de tejido_cultural
CREATE OR REPLACE FUNCTION eliminar_artesania() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM tejido_cultural
    WHERE artesania_id = OLD.id_artesania;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_artesania
BEFORE DELETE ON artesania
FOR EACH ROW
EXECUTE PROCEDURE eliminar_artesania();

-- Si se elimina una tupla dentro de la tabla de sitios_interes, se eliminará la tupla correspondiente en la tabla de tejido_cultural
CREATE OR REPLACE FUNCTION eliminar_sitio_interes() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM tejido_cultural
    WHERE sitios_interes_id = OLD.id_sitios_interes;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_sitio_interes
BEFORE DELETE ON sitios_interes
FOR EACH ROW
EXECUTE PROCEDURE eliminar_sitio_interes();

