-- Si se elimina una tupla dentro de la tabla de comestibles, se eliminara la tupla correspondiente en la tabla de productos
CREATE OR REPLACE FUNCTION eliminar_comestible() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM productos
    WHERE comestibles_id = OLD.id_comestibles;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_comestible
BEFORE DELETE ON comestibles
FOR EACH ROW
EXECUTE PROCEDURE eliminar_comestible();