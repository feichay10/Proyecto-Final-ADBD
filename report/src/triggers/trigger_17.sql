-- -- Trigger para la tabla de seres_vivos
-- Si se anade una nueva tupla dentro de la tabla de seres_vivos, se anadira una nueva tupla en la tabla de animales_autoctonos
CREATE OR REPLACE FUNCTION insertar_seres_vivos() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.tipo = 'Animal' THEN
        INSERT INTO animales_autoctonos(ser_vivo_id, isla_id)
        VALUES (NEW.id_seres_vivos, 1);
    ELSE
        INSERT INTO plantas_autoctonas(ser_vivo_id, isla_id)
        VALUES (NEW.id_seres_vivos, 1);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_seres_vivos
AFTER INSERT ON seres_vivos
FOR EACH ROW
EXECUTE PROCEDURE insertar_seres_vivos();