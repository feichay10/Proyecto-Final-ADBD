-- Si se anade una nueva tupla dentro de la tabla de artesania, se anadira una nueva tupla en la tabla de productos
CREATE OR REPLACE FUNCTION insertar_artesania_productos() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO productos(comestibles_id, artesania_id)
    VALUES (NULL, NEW.id_artesania);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_artesania_productos
AFTER INSERT ON artesania
FOR EACH ROW
EXECUTE PROCEDURE insertar_artesania_productos();