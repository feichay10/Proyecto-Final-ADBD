-- -- Inclusion de datos en la tabla de islas
INSERT INTO isla (nombre) VALUES ('Lanzarote');

-- -- Inclusion de datos en la tabla de distribucion poblacional
INSERT INTO distribucion_poblacional (isla_id, provincia, capital, municipio, poblacion)
VALUES (3, 'Las Palmas', 'Arrecife', 'San Bartolome', 156112);

-- -- Inclusion de datos en la tabla de seres vivos
INSERT INTO seres_vivos(nombre, nombre_cientifico, tipo)
VALUES ('Lagarto Gigante de El Hierro', 'Gallotia simonyi', 'Animal');

-- -- Inclusion de datos en la tabla de animales autoctonos
INSERT INTO animales_autoctonos(ser_vivo_id, isla_id, invasoras, dieta)
VALUES (1, 7, false, 'Insectivoro');

-- -- Inclusion de datos en la tabla de plantas autoctonas
INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id, invasoras) VALUES (21, 2, false);

-- -- Inclusion de datos en la tabla de sitios de interes
INSERT INTO sitios_interes(isla_id, nombre, municipio, latitud, longitud) 
VALUES (3, 'Parque Nacional de Timanfaya', 'Yaiza', 29.016667, -13.75);

-- -- Inclusion de datos en la tabla de nombres canarios
INSERT INTO nombres_canarios(id_isla, nombre, genero) VALUES (1, 'Yaiza', 'Mujer');

-- -- Inclusion de datos en la tabla de platos
INSERT INTO platos(nombre, tipo) VALUES ('Papas arrugadas', 'Principal');

-- -- Inclusion de datos en la tabla de ingredientes
INSERT INTO ingredientes(nombre) VALUES ('Carne de cabra');

-- -- Inclusion de datos en la tabla de platos_ingredientes
INSERT INTO plato_ingredientes(plato_id, ingrediente_id) VALUES (1, 1);

-- -- Inclusion de datos en la tabla de comestibles
INSERT INTO comestibles(nombre, compania, tipo) VALUES ('Clipper', 'Ahembo', 'Bebida');

-- -- Inclusion de datos en la tabla de compania
INSERT INTO compania(nombre, tipo, sede, fundacion) 
VALUES ('Binter Canarias', 'Aerolinea', 'Gran Canaria', 1989);

-- -- Inclusion de datos en la tabla de artesania
INSERT INTO artesania(isla_id, nombre, creador, tipo) 
VALUES (1, 'Cuchillo Canario', 'Desconocido', 'Herramienta');

-- -- Inclusion de datos en la tabla de folclore
INSERT INTO folclore(id_artesania, nombre, autor, lanzamiento)
VALUES (5, 'Cabra Loca', 'Los Gofiones', 2012);

-- -- Inclusion de datos en la tabla de isla_ecosistema
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

-- -- Inclusion de datos de la tabla tejido_cultural
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

-- -- Inclusion de datos de la tabla productos
ALTER TABLE productos
ALTER COLUMN comestibles_id DROP NOT NULL,
ALTER COLUMN artesania_id DROP NOT NULL;

INSERT INTO productos(comestibles_id, artesania_id)
SELECT id_comestibles, NULL
FROM comestibles;

INSERT INTO productos(comestibles_id, artesania_id)
SELECT NULL, id_artesania
FROM artesania;

-- -- Inclusion de datos de la tabla produccion_compania
INSERT INTO produccion_compania(comestibles_id, compania_id)
SELECT id_comestibles, id_compania
FROM comestibles INNER JOIN compania ON comestibles.compania = compania.nombre;

-- -- Inclusion de datos de la tabla distribucion gastronomica
INSERT INTO distribucion_gastronomica(isla_id, platos_id)
SELECT isla.id_isla, platos.id_platos
FROM isla, platos;