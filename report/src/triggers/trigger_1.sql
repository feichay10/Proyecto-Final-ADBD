-- -- Trigger para la tabla de isla_ecosistema
-- Si se anade una nueva tupla dentro de la tabla de animales_autoctonos, se anadira una nueva tupla en la tabla de isla_ecosistema
CREATE OR REPLACE FUNCTION insertar_animal_autoctono() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO isla_ecosistema(isla_id, seres_vivos_id, animales_autoctonos_id, plantas_autoctonas_id)
    VALUES (NEW.isla_id, NEW.ser_vivo_id, NEW.id_animales_autoctonos, NULL);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_animal_autoctono
AFTER INSERT ON animales_autoctonos
FOR EACH ROW
EXECUTE PROCEDURE insertar_animal_autoctono();