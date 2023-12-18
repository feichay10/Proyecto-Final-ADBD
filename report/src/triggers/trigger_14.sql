-- Si se elimina una tupla dentro de la tabla de comestibles, se eliminara la tupla correspondiente en la tabla de produccion_compania
CREATE OR REPLACE FUNCTION eliminar_comestible_produccion() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM produccion_compania
    WHERE comestibles_id = OLD.id_comestibles;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_comestible_produccion
BEFORE DELETE ON comestibles
FOR EACH ROW
EXECUTE PROCEDURE eliminar_comestible_produccion();