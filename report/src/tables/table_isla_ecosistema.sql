CREATE TABLE isla_ecosistema (
    isla_id INT REFERENCES isla(id_isla),
    seres_vivos_id INT REFERENCES seres_vivos(id_seres_vivos),
    animales_autoctonos_id INT REFERENCES animales_autoctonos(id_animales_autoctonos),
    plantas_autoctonas_id INT REFERENCES plantas_autoctonas(id_plantas_autoctonas),
    PRIMARY KEY (isla_id, seres_vivos_id, animales_autoctonos_id, plantas_autoctonas_id)
);