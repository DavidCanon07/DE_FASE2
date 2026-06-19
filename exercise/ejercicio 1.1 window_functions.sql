-- primera consulta base hecha (X)
select
    p.nombre,
    p.categoria,
    v.ventas,
    rank() over (partition by p.categoria order by  v.ventas desc) as ranking_en_categoria
from dim_productos p
join fact_ventas v on v.id_producto = p.id_producto;


-- Ejercicio 1 listar productos con su ranking por categoria

with ventas_por_producto as(
	select
		dp.nombre,
		dp.categoria,
		sum(fv.ventas) as total_ventas
	from dim_productos dp 
	join fact_ventas fv on fv.id_producto  = dp.id_producto 
	group by dp.nombre, dp.categoria
)

select 
	vp.nombre,
	vp.categoria,
	vp.total_ventas,
	rank() over (partition by vp.categoria order by vp.total_ventas desc) as ranking_en_categoria
from ventas_por_producto vp;

