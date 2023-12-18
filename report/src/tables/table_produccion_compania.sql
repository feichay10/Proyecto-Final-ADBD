CREATE TABLE produccion_compania (
    productos_id INT REFERENCES productos(id_productos),
    comestibles_id INT REFERENCES comestibles(id_comestibles),
    compania_id INT REFERENCES compania(id_compania),
    PRIMARY KEY (productos_id, comestibles_id, compania_id)
);