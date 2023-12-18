-- Si se elimina una tupla dentro de la tabla de sitios_interes, se eliminara la tupla correspondiente en la tabla de tejido_cultural
CREATE OR REPLACE FUNCTION eliminar_sitio_interes() RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM tejido_cultural
    WHERE sitios_interes_id = OLD.id_sitios_interes;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER eliminar_sitio_interes
BEFORE DELETE ON sitios_interes
FOR EACH ROW
EXECUTE PROCEDURE eliminar_sitio_interes();