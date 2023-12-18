CREATE TABLE plato_ingredientes (
    id_plato_ingredientes SERIAL PRIMARY KEY,
    plato_id INT REFERENCES platos(id_platos),
    ingrediente_id INT REFERENCES ingredientes(id_ingredientes)
);