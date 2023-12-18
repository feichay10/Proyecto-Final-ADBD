-- Si se elimina una tupla dentro de la tabla de animales_autoctonos, se eliminara la tupla correspondiente en la tabla de isla_ecosistema
CREATE OR REPLACE FUNCTION eliminar_animal_autoctono() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM isla_ecosistema
    WHERE animales_autoctonos_id = OLD.id_animales_autoctonos;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_animal_autoctono
BEFORE DELETE ON animales_autoctonos
FOR EACH ROW
EXECUTE PROCEDURE eliminar_animal_autoctono();