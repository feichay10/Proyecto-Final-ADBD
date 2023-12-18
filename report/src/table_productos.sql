CREATE TABLE productos (
    id_productos SERIAL PRIMARY KEY,
    comestibles_id INT REFERENCES comestibles(id_comestibles),
    artesania_id INT REFERENCES artesania(id_artesania)
);