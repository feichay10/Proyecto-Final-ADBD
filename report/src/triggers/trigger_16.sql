
-- Si se elimina una tupla dentro de la tabla de platos, se eliminara la tupla correspondiente en la tabla de distribucion_gastronomica
CREATE OR REPLACE FUNCTION eliminar_plato_distribucion() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM distribucion_gastronomica
    WHERE platos_id = OLD.id_platos;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_plato_distribucion
BEFORE DELETE ON platos
FOR EACH ROW
EXECUTE PROCEDURE eliminar_plato_distribucion();