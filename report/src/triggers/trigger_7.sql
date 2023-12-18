-- Si se elimina una tupla dentro de la tabla de artesania, se eliminara la tupla correspondiente en la tabla de tejido_cultural
CREATE OR REPLACE FUNCTION eliminar_artesania() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM tejido_cultural
    WHERE artesania_id = OLD.id_artesania;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_artesania
BEFORE DELETE ON artesania
FOR EACH ROW
EXECUTE PROCEDURE eliminar_artesania();