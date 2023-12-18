CREATE TABLE tejido_cultural (
    isla_id INT REFERENCES isla(id_isla),
    artesania_id INT REFERENCES artesania(id_artesania),
    sitios_interes_id INT REFERENCES sitios_interes(id_sitios_interes),
    PRIMARY KEY (isla_id, artesania_id, sitios_interes_id)
);