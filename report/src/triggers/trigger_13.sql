-- -- Trigger para la tabla de produccion_compania
-- Si se anade una nueva tupla dentro de la tabla de comestibles, se anadira una nueva tupla en la tabla de produccion_compania
CREATE OR REPLACE FUNCTION insertar_comestible_produccion() RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM produccion_compania WHERE comestibles_id = NEW.id_comestibles AND compania_id = (SELECT id_compania FROM compania WHERE nombre = NEW.compania)) THEN
        INSERT INTO produccion_compania(comestibles_id, compania_id)
        VALUES (NEW.id_comestibles, (SELECT id_compania FROM compania WHERE nombre = NEW.compania));
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_comestible_produccion
AFTER INSERT ON comestibles
FOR EACH ROW
EXECUTE PROCEDURE insertar_comestible_produccion();