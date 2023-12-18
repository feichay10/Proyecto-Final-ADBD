-- Si se anade una nueva tupla dentro de la tabla de sitios_interes, se anadira una nueva tupla en la tabla de tejido_cultural
CREATE OR REPLACE FUNCTION insertar_sitio_interes() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO tejido_cultural(isla_id, artesania_id, sitios_interes_id)
    VALUES (NEW.isla_id, NULL, NEW.id_sitios_interes);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insertar_sitio_interes
AFTER INSERT ON sitios_interes
FOR EACH ROW
EXECUTE PROCEDURE insertar_sitio_interes();