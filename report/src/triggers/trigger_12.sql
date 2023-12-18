-- Si se elimina una tupla dentro de la tabla de artesania, se eliminara la tupla correspondiente en la tabla de productos
CREATE OR REPLACE FUNCTION eliminar_artesania_productos() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM productos
    WHERE artesania_id = OLD.id_artesania;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_artesania_productos
BEFORE DELETE ON artesania
FOR EACH ROW
EXECUTE PROCEDURE eliminar_artesania_productos();