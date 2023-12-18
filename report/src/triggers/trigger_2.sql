-- Si se anade una nueva tupla dentro de la tabla de plantas_autoctonas, se anadira una nueva tupla en la tabla de isla_ecosistema
CREATE OR REPLACE FUNCTION insertar_planta_autoctona() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO isla_ecosistema(isla_id, seres_vivos_id, animales_autoctonos_id, plantas_autoctonas_id)
    VALUES (NEW.isla_id, NEW.ser_vivo_id, NULL, NEW.id_plantas_autoctonas);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_planta_autoctona
AFTER INSERT ON plantas_autoctonas
FOR EACH ROW
EXECUTE PROCEDURE insertar_planta_autoctona();