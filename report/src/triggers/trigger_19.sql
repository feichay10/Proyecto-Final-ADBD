-- -- Trigger para la tabla de seres_vivos
-- -- Comprobacion de que el nombre del ser vivo no se repita
CREATE OR REPLACE FUNCTION comprobar_nombre_seres_vivos() RETURNS TRIGGER AS $$
DECLARE
    nombre_seres_vivos RECORD;
BEGIN
    FOR nombre_seres_vivos IN SELECT * FROM seres_vivos
    LOOP
        IF nombre_seres_vivos.nombre = NEW.nombre THEN
            RAISE EXCEPTION 'El nombre del ser vivo ya existe';
        END IF;
    END LOOP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER comprobar_nombre_seres_vivos
BEFORE INSERT OR UPDATE ON seres_vivos
FOR EACH ROW
EXECUTE PROCEDURE comprobar_nombre_seres_vivos();