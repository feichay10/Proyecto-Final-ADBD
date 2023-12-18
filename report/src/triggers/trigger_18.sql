-- Si se elimina una tupla dentro de la tabla de seres_vivos, se eliminara la tupla correspondiente en la tabla de animales_autoctonos y platas_autoctonas
CREATE OR REPLACE FUNCTION eliminar_seres_vivos() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM animales_autoctonos
    WHERE ser_vivo_id = OLD.id_seres_vivos;
    DELETE FROM plantas_autoctonas
    WHERE ser_vivo_id = OLD.id_seres_vivos;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_seres_vivos
BEFORE DELETE ON seres_vivos
FOR EACH ROW
EXECUTE PROCEDURE eliminar_seres_vivos();