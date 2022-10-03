-- Top 10 las peliculas mas rentadas

SELECT peliculas.pelicula_id AS id, 
	peliculas.titulo,
	COUNT(*) AS numero_rentas,
	-- Window function del top, si se repite el top tienen el mismo lugar
	DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS top 
FROM rentas
	JOIN inventarios 
		ON inventarios.inventario_id = rentas.inventario_id
	JOIN peliculas 
		ON peliculas.pelicula_id = inventarios.pelicula_id
GROUP BY peliculas.pelicula_id
HAVING COUNT(*) > 24 -- Filtrando los 10 mas rentados
ORDER BY numero_rentas DESC
;