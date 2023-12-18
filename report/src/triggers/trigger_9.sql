-- -- Trigger para la tabla de productos
-- Si se anade una nueva tupla dentro de la tabla de comestibles, se anadira una nueva tupla en la tabla de productos
CREATE OR REPLACE FUNCTION insertar_comestible() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO productos(comestibles_id, artesania_id)
    VALUES (NEW.id_comestibles, NULL);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_comestible
AFTER INSERT ON comestibles
FOR EACH ROW
EXECUTE PROCEDURE insertar_comestible();