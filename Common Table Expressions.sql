WITH peliculas_rentadas AS (
	SELECT pelicula_id, COUNT(fecha_renta) AS rentas_acumuladas
	FROM inventarios
	JOIN rentas
		ON inventarios.inventario_id = rentas.inventario_id
	GROUP BY inventarios.pelicula_id
	ORDER BY rentas_acumuladas DESC
),

-- Tabla 2
peliculas_categoria_horror AS (
	SELECT pelicula_id, nombre
	FROM peliculas_categorias
	JOIN categorias 
		ON categorias.categoria_id = peliculas_categorias.categoria_id
	WHERE categorias.nombre = 'Horror'
)

SELECT 
	peliculas.titulo,
	peliculas.clasificacion,
	peliculas_categoria_horror.nombre AS genero,
	peliculas_rentadas.rentas_acumuladas AS rentas_acumuladas,
	precio_renta * (peliculas_rentadas.rentas_acumuladas) AS monto_rentas_acumulado

FROM peliculas
	JOIN peliculas_categoria_horror
		ON peliculas.pelicula_id = peliculas_categoria_horror.pelicula_id
	JOIN peliculas_rentadas
		ON peliculas.pelicula_id = peliculas_rentadas.pelicula_id
		

WHERE peliculas.duracion > 100 and peliculas.precio_renta > 1;