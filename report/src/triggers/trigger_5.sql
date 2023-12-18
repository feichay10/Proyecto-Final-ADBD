-- -- Trigger para la tabla de tejido_cultural
-- Si se anade una nueva tupla dentro de la tabla de artesania, se anadira una nueva tupla en la tabla de tejido_cultural
CREATE OR REPLACE FUNCTION insertar_artesania() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO tejido_cultural(isla_id, artesania_id, sitios_interes_id)
    VALUES (NEW.isla_id, NEW.id_artesania, NULL);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_artesania
AFTER INSERT ON artesania
FOR EACH ROW
EXECUTE PROCEDURE insertar_artesania();