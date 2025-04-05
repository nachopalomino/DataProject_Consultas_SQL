-- 1. Muestra los nombres de todas las películas con clasificación 'R'
select 
	title as pelicula,
	rating as clasificacion--> Comprobación clasificación "R"
from film 
where rating = 'R';

-- 2. Encuentra los nombres de los actores con un actor_id entre 30 y 40
select 
	first_name as nombre, 
	last_name as apellido, 
	actor_id --> Comprobación ID entre 30 y 40
from actor 
where actor_id BETWEEN 30 AND 40;

-- 3. Obtén las películas cuyo idioma coincide con el idioma original
select 
	title as pelicula, 
	language_id, 
	original_language_id --> Comprobación mismo idioma
from film 
where language_id = original_language_id;

--> No existen coincidencias debido a que los valores de la columna "original_language_id" son NULL.

-- 4. Ordena las películas por duración de forma ascendente
select 
	title as pelicula, 
	length as duracion 
from film 
order by length asc;

-- 5. Encuentra el nombre y apellido de los actores que tengan "Allen" en su apellido
select 
	first_name as nombre, 
	last_name as apellido
from actor
where last_name in('ALLEN');

-- 6. Encuentra la cantidad total de películas en cada clasificación
select 
	rating as clasificacion, 
	count(*) as total_peliculas 
from film 
group by rating;

-- 7. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film
select 
	title as pelicula, 
	rating as clasificacion, 
	length as duracion
from film
where rating = 'PG-13' or length > 180;

-- 8. Encuentra la variabilidad de lo que costaría reemplazar las películas
select variance(replacement_cost) 
from film;

-- 9. Encuentra la mayor y menor duración de una película de nuestra BBDD
select
	max(length) as max_duracion, 
	min(length) as min_duracion
from film;

-- 10. Encuentra lo que costó el antepenúltimo alquiler ordenado por día
select 
	amount as coste, 
	payment_date as fecha_antepenultimo_alquiler
from payment
order by payment_date desc 
	offset 2 
	limit 1;

-- 11. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación
select 
	title as pelicula, 
	rating as clasificacion
from film
where rating not in ('NC-17', 'G');

/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film 
y muestra la clasificación junto con el promedio de duración */
select 
	rating as clasificacion, 
	round(avg(length)) as promedio_duracion
from film
group by rating;

-- 13. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos
select 
	title as pelicula, 
	length as duracion
from film
where length > 180;

-- 14. ¿Cuánto dinero ha generado en total la empresa?
select sum(amount) as total_ingresos
from payment;

-- 15. Muestra los 10 clientes con mayor valor de id
select *
from customer
order by customer_id desc
limit 10;

-- 16. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’
select 
	a.first_name as nombre_actor, 
	a.last_name as apellido_actor,
	f.title as pelicula --> Comprobación película correcta
from actor a
	inner join film_actor fa on a.actor_id = fa.actor_id
	inner join film f on fa.film_id = f.film_id 
where f.title = 'EGG IGBY';

-- 17. Selecciona todos los nombres de las películas únicas
select distinct title as pelicula
from film;

/* 18. Encuentra el título de las películas que son comedias y 
tienen una duración mayor a 180 minutos en la tabla “film”*/
select 
	f.title as titulo_pelicula,
	c.name as categoria --> Comprobación categoría comedia
from film f
	inner join film_category fc on f.film_id = fc.film_id
	inner join category c on fc.category_id = c.category_id 
where c.name = 'Comedy' and f.length > 180;

/* 19. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos 
y muestra el nombre de la categoría junto con el promedio de duración */
select 
	c.name as categoria,
	round(avg(f.length)) as promedio_duracion
from film f
	inner join film_category fc on f.film_id = fc.film_id
	inner join category c on fc.category_id = c.category_id
group by c.name
having avg(f.length) > 110;

-- 20. ¿Cuál es la media de duración del alquiler de las películas?
select avg(return_date - rental_date)
from rental;

--> No se especifica expresar el resultado en una medida concreta.

-- 21. Crea una columna con el nombre y apellidos de todos los actores y actrices
select concat(first_name, ' ', last_Name) as Actores
from actor
order by Actores asc;

-- 22. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente
select 
    date(rental_date) as fecha,  
    count(rental_id) as cantidad_alquileres  
from rental
group by date(rental_date)  
order by cantidad_alquileres desc;

-- 23. Encuentra las películas con una duración superior al promedio
select 
	title as titulo_pelicula, 
	length as promedio_duracion --> Comprobación duracion > promedio
from film
where length > (select avg(length)
	from film);

-- 24. Averigua el número de alquileres registrados por mes
select 
    to_char(rental_date, 'YYYY-MM') as mes,
    count(rental_id) as numero_alquileres
from rental
group by to_char(rental_date, 'YYYY-MM') --> Año incluido debido a a existencia de diferentes años.
order by mes;

-- 25. Encuentra el promedio, la desviación estándar y varianza del total pagado
select 
	round(avg(amount)) as promedio_total_pagado, --> Resultados redondeados para una mejor comprensión
	round(stddev(amount)) as desviacion_estandar,
	round(variance(amount)) as varianza
from payment;

-- 26. ¿Qué películas se alquilan por encima del precio medio?
select distinct
	f.title as titulo_pelicula, 
	p.amount as precio_alquiler --> Comprobacion precio > precio medio
from film f
	inner join inventory i on f.film_id = i.film_id 
	inner join rental r on i.inventory_id = r.inventory_id 
	inner join payment p on r.rental_id = p.rental_id 
where p.amount > (select avg(amount) from payment)
order by p.amount desc;

-- 27. Muestra el id de los actores que hayan participado en más de 40 películas
select 
	actor_id,
	count(fa.film_id) as cantidad_peliculas --> Comprobación participación > 40 películas.
from film_actor fa 
group by fa.actor_id
having count(fa.film_id) > 40
order by cantidad_peliculas desc;

-- 28. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible
select 
	f.title as titulo_pelicula,
	count(i.inventory_id) as inventario
from film f 
left join inventory i on f.film_id = i.film_id 
group by f.title
order by inventario desc;

-- 29. Obtener los actores y el número de películas en las que ha actuado
select
	concat(a.first_name, ' ', a.last_name) as actor,
	count(fa.film_id) as numero_peliculas
from film f
	inner join film_actor fa on f.film_id = fa.film_id 
	inner join actor a on fa.actor_id = a.actor_id 
group by actor
order by numero_peliculas desc;

/* 30. Obtener todas las películas y mostrar los actores que han actuado en ellas, 
incluso si algunas películas no tienen actores asociados*/
--> OPCIÓN 1: Repetición de películas y actores (1 valor por celda)
select 
	f.title as titulo,
	concat(a.first_name,' ', a.last_name) as actor
from film f
	inner join film_actor fa on f.film_id = fa.film_id 
	inner join actor a on fa.actor_id = a.actor_id 
order by actor;

--> OPCIÓN 2: Mostrar todos los actores por película en la misma celda.
select 
    f.title as titulo_pelicula,
    STRING_AGG(a.first_name || ' ' || a.last_name, ', ') as actores
from 
    film f
left join 
    film_actor fa on f.film_id = fa.film_id
left join 
    actor a on fa.actor_id = a.actor_id
group by 
    f.title
order by
    f.title;

/* 31. Obtener todos los actores y mostrar las películas en las que han actuado, 
incluso si algunos actores no han actuado en ninguna película*/
select
	concat(a.first_name,' ', a.last_name) as actor,
	 STRING_AGG(f.title, ', ') AS peliculas
from film f
left join 
    film_actor fa on f.film_id = fa.film_id
left join 
    actor a on fa.actor_id = a.actor_id
group by 
    actor
order by
	actor;

-- 32. Obtener todas las películas que tenemos y todos los registros de alquiler
select 
	f.title as peliculas,
	r.*
from 
	film f
inner join inventory i on f.film_id = i.film_id 
inner join rental r on i.inventory_id = r.inventory_id
order by peliculas asc;

-- 33. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros
select 
	customer_id,
	sum(amount) as total_gastado
from payment p
group by customer_id
order by total_gastado desc
limit 5;

-- 34. Selecciona todos los actores cuyo primer nombre es 'Johnny'
select concat(first_name, ' ', last_name) as actor
from actor
where first_name = 'JOHNNY';

-- 35. Renombra la columna “first_name” como Nombre y “last_name” como Apellido
select
	first_name as Nombre,
	last_name as Apellido
from actor;

-- 36. Encuentra el ID del actor más bajo y más alto en la tabla actor
select 
	min(actor_id),
	max(actor_id)
from actor;

-- 37. Cuenta cuántos actores hay en la tabla “actor”
select count(actor_id)
from actor;

-- 38. Selecciona todos los actores y ordénalos por apellido en orden ascendente
select 
	first_name as nombre,
	last_name as apellido
from actor 
order by last_name asc;

-- 39. Selecciona las primeras 5 películas de la tabla “film”
select *
from film f
limit 5;

/* 40. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. 
¿Cuál es el nombre más repetido? --> Kenneth, Penelope y Julia */
select 
	first_name as nombre,
	count(actor_id) as numero_actores
from actor a 
group by nombre
order by numero_actores desc;

-- 41. Encuentra todos los alquileres y los nombres de los clientes que los realizaron
select 
	c.first_name as nombre_cliente,
	p.amount as importe_alquiler,
	r.*
from customer c
inner join rental r on c.customer_id = r.customer_id 
inner join payment p on r.customer_id = p.customer_id ;
	
-- 42. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres
select 
    c.customer_id,
	c.first_name as nombre_cliente,
    p.amount as importe_alquiler,
    r.*
from customer c
left join rental r ON c.customer_id = r.customer_id
left join payment p ON r.rental_id = p.rental_id;

/* 43. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? 
Deja después de la consulta la contestación */
select f.*,c.*
from film f
cross join category c;

/* RESPUESTA: No, hacer un CROSS JOIN entre film y category no aporta valor en un contexto donde queremos analizar las categorias 
reales de cada pelicula. Un CROSS JOIN entre film y category genera el producto cartesiano, lo que significa que cada 
película se combina con todas las categorías, sin importar si realmente están relacionadas en la tabla film_category.
Esto genera información incorrecta o engañosa, porque estaríamos asignando categorías a películas que en realidad 
no tienen esa clasificación.*/

-- 44. Encuentra los actores que han participado en películas de la categoría 'Action'
select distinct
	concat(first_name, ' ', last_name) as actor,
	f.title as titulo,
	c.name as categoria --> Comprobación categoría "Action".
from actor a
	inner join film_actor fa on a.actor_id = fa.actor_id
	inner join film f on fa.film_id = f.film_id
	inner join film_category fc on f.film_id = fc.film_id
	inner join category c on fc.category_id = c.category_id 
where c.name in ('Action');
	 
-- 45. Encuentra todos los actores que no han participado en películas --> No existen.
select 
	a.actor_id, 
	concat(first_name, ' ', last_name) as actor, 
	fa.film_id
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
where fa.film_id is null;

-- 46. Selecciona el nombre de los actores y la cantidad de películas en las que han participado
select 
	a.first_name as nombre_actores,
	count(fa.film_id) as cantidad_peliculas
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
group by nombre_actores
order by cantidad_peliculas desc;

/* 47. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y 
el número de películas en las que han participado*/
create or replace view actor_num_peliculas as 
select 
	a.first_name as nombre_actores,
	count(fa.film_id) as cantidad_peliculas
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
group by nombre_actores
order by cantidad_peliculas desc;

--> Abrir vista
select * from actor_num_peliculas;

-- 48. Calcula el número total de alquileres realizados por cada cliente
select 
	customer_id as cliente,
	count(rental_id) as numero_alquileres
from rental 
group by cliente
order by numero_alquileres desc;

-- 49. Calcula la duración total de las películas en la categoría 'Action'
select 
	c.name as categoria, --> Comprobación categoría "Action".
	sum(f.length) as duracion_total
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
where c.name = 'Action'
group by categoria;

-- 50. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente
--> Crear Tabla temporal
create temporary table cliente_rentas_temporal as
select 
    c.customer_id, 
    concat(first_name, ' ', last_name) as nombre_cliente,
    count(r.rental_id) as total_alquileres
from customer c
left join rental r on c.customer_id = r.customer_id
group by c.customer_id, nombre_cliente
order by total_alquileres desc;

--> Visualizar Tabla temporal
select * from cliente_rentas_temporal;

--> ELiminar Tabla temporal
DROP TABLE IF EXISTS cliente_rentas_temporal;

/* 51. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido 
alquiladas al menos 10 veces*/
--> Crear Tabla temporal
create temporary table peliculas_alquiladas as
select
	f.title as pelicula,
	count(r.rental_id) as numero_alquileres
from film f
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
group by f.title
having count(r.rental_id) >= 10
order by numero_alquileres desc;

--> Visualizar Tabla temporal
select * from peliculas_alquiladas;

--> ELiminar Tabla temporal
DROP TABLE IF exists peliculas_alquiladas;

/* 52. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ 
y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película*/
select 
	f.title as pelicula,
	concat(c.first_name, ' ', c.last_name) as cliente,
	r.return_date --> Comprobación que el registro es NULL
from film f
inner join inventory i on f.film_id = i.film_id 
inner join rental r on i.inventory_id = r.inventory_id 
inner join customer c on r.customer_id = c.customer_id
where 
	r.return_date is null
	and c.first_name = 'TAMMY'
	and c.last_name = 'SANDERS'
order by pelicula asc;

/* 53. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría
 ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido */
select
	CONCAT(a.first_name, ' ', a.last_name) AS actores,
    COUNT(f.film_id) AS numero_peliculas,
	c.name as categoria
from category c
inner join film_category fc on c.category_id = fc.category_id 
inner join film f on fc.film_id = f.film_id 
inner join film_actor fa on f.film_id = fa.film_id 
inner join actor a on fa.actor_id = a.actor_id
where c.name = 'Sci-Fi'
group by a.actor_id, actores, categoria
having count(f.film_id) >= 1
order by a.last_name asc;

/* 54. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que 
la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido */
select 
    concat(a.first_name, ' ', a.last_name) as actores
from actor a
inner join film_actor fa on a.actor_id = fa.actor_id
inner join film f on fa.film_id = f.film_id
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
where r.rental_date > (
    select MIN(rental_date) 
    from rental r
    inner join inventory i on r.inventory_id = i.inventory_id
    inner join film f on i.film_id = f.film_id
    where f.title = 'SPARTACUS CHEAPER'
)
group by a.first_name, a.last_name
order by a.last_name asc, a.first_name asc;

-- 55. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
select 
    concat(a.first_name, ' ', a.last_name) as actores,
    c.name as categoria --> Comprobación categoría distinta de "Music".
from actor a
left join film_actor fa on a.actor_id = fa.actor_id
left join film f on fa.film_id = f.film_id
left join film_category fc on f.film_id = fc.film_id
left join category c on fc.category_id = c.category_id
where a.actor_id not in (
	select distinct fa.actor_id 
	from film_actor fa
	inner join film_category fc on fa.film_id = fc.film_id
	inner join category c on fc.category_id = c.category_id 
	where c.name = 'Music'
)
order by a.last_name, a.first_name;

-- 56. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días
select distinct
	f.title as pelicula,
	extract(day from (r.return_date - r.rental_date)) as dias_de_alquiler
from film f
inner join inventory i on f.film_id = i.film_id
inner join rental r on i.inventory_id = r.inventory_id
where (r.return_date - r.rental_date) > interval '8 days';

-- 57. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’
select 
	f.title as pelicula,
	c.name as categoria --> Comprobacion categoria "Animation".
from film f
inner join film_category fc on f.film_id = fc.film_id 
inner join category c on fc.category_id = c.category_id 
where c.name = 'Animation';

/* 58. Encuentra los nombres de las películas que tienen la misma duración que la película con 
el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película */
select 
	f.title as pelicula,
	f.length as duracion --> Comprobacion duración = "Dancing Fever".
from film f
where f.length = (
	select f2.length
	from film f2
	where f2.title = 'DANCING FEVER'
	)
order by title asc;

/* 59. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
Ordena los resultados alfabéticamente por apellido */
select
	concat(c.first_name, ' ', c.last_name) as nombre_clientes,
	count(distinct i.film_id) as peliculas_alquiladas
from customer c
inner join rental r on c.customer_id = r.customer_id 
inner join inventory i on r.inventory_id = i.inventory_id 
group by c.first_name, c.last_name
having count(distinct i.film_id) >= 7
order by c.last_name asc, c.first_name asc;

/* 60. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría 
junto con el recuento de alquileres */
select
	c.name as categoria,
	count(p.rental_id) as peliculas_alquiladas
from payment p
inner join rental r on p.rental_id = r.rental_id
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
group by c.name
order by peliculas_alquiladas desc;

-- 61. Encuentra el número de películas por categoría estrenadas en 2006.
select
	c.name as categoria,
	count(fc.film_id) as numero_peliculas,
	f.release_year as fecha_estreno --> Comprobación fecha = 2006.
from category c
inner join film_category fc on c.category_id = fc.category_id
inner join film f on fc.film_id = f.film_id
where f.release_year = 2006
group by c.name, f.release_year
order by fecha_estreno desc;

-- 62. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos
select 
	s.staff_id as trabajadores,
	st.store_id as tiendas
from staff s
cross join store st 
order by trabajadores asc;

/* 63. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, 
su nombre y apellido junto con la cantidad de películas alquiladas */
select 
	c.customer_id as ID_cliente,
	c.first_name as nombre_cliente,
	c.last_name as apellido_cliente,
	count(r.rental_id) as peliculas_alquiladas
from customer c
inner join rental r on c.customer_id = r.customer_id 
group by c.customer_id, c.first_name, c.last_name
order by peliculas_alquiladas desc;
