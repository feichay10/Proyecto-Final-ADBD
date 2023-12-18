-- -- Trigger para la tabla de distribucion_gastronomica
-- Si se anade una nueva tupla dentro de la tabla de platos, se anadira una nueva tupla en la tabla de distribucion_gastronomica
CREATE OR REPLACE FUNCTION insertar_plato_distribucion() RETURNS TRIGGER AS $$
DECLARE
    isla RECORD;
BEGIN
    FOR isla IN SELECT * FROM isla
    LOOP
        INSERT INTO distribucion_gastronomica(isla_id, platos_id)
        VALUES (isla.id_isla, NEW.id_platos);
    END LOOP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_plato_distribucion
AFTER INSERT ON platos
FOR EACH ROW
EXECUTE PROCEDURE insertar_plato_distribucion();