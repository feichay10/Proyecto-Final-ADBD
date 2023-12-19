UPDATE animales_autoctonos 
SET isla_id = (SELECT id_isla FROM isla WHERE nombre = 'Lanzarote'), invasoras = true, dieta = 'example'
WHERE ser_vivo_id = (SELECT id_seres_vivos FROM seres_vivos WHERE nombre = 'example')