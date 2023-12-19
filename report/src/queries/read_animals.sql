SELECT sv.nombre, sv.nombre_cientifico, aa.invasoras, aa.dieta
FROM animales_autoctonos aa 
JOIN seres_vivos sv ON aa.ser_vivo_id = sv.id_seres_vivos;