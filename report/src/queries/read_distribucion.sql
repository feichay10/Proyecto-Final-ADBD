SELECT i.nombre AS isla, dp.capital, array_agg(dp.municipio) AS municipios, MIN(dp.poblacion) AS poblacion 
FROM distribucion_poblacional dp 
JOIN isla i ON dp.isla_id = i.id_isla 
GROUP BY i.nombre, dp.capital;