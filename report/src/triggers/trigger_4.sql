-- Si se elimina una tupla dentro de la tabla de plantas_autoctonas, se eliminara la tupla correspondiente en la tabla de isla_ecosistema
CREATE OR REPLACE FUNCTION eliminar_planta_autoctona() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM isla_ecosistema
    WHERE plantas_autoctonas_id = OLD.id_plantas_autoctonas;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_planta_autoctona
BEFORE DELETE ON plantas_autoctonas
FOR EACH ROW
EXECUTE PROCEDURE eliminar_planta_autoctona();