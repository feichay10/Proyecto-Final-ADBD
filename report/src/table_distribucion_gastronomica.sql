CREATE TABLE distribucion_gastronomica (
  isla_id INT REFERENCES isla(id_isla),
  plato_ingrediente_id INT REFERENCES plato_ingredientes(id_plato_ingredientes),
  PRIMARY KEY (isla_id, plato_ingrediente_id)
);