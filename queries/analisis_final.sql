

--first CTE para obtener el top 3 de productos mas vendidos (consulta macro)
with ventas_mes as (
	select
		df.mes,
		dp.id_producto,
		dp.nombre as nombre_producto,
		sum(fv.ventas) as ventas_total,
		sum(fv.ventas - fv.costo ) as margen_de_ganancia
	from fact_ventas fv
	join dim_fecha df on fv.id_fecha = df.id_fecha 
	join dim_productos dp on fv.id_producto = dp.id_producto 
	group by df.mes , dp.id_producto, dp.nombre  
),
top_3_mes as(
	select
		mes,
		id_producto,
		nombre_producto,
		ventas_total,
		margen_de_ganancia ,
		rank() over(partition by mes order by ventas_total desc) as ranking
		from ventas_mes
),
mes_anterior as(
	select
		mes,
		id_producto,
		nombre_producto,
		ventas_total,
		margen_de_ganancia,
		ranking,
		lag(ventas_total) over (partition by nombre_producto order by mes) as venta_mes_anterior
	from top_3_mes
)
select
	mes,
	nombre_producto,
	ventas_total,
	margen_de_ganancia,
	venta_mes_anterior,
	(ventas_total - venta_mes_anterior ) as variacion_versus,
	ranking
from mes_anterior  
where ranking <= 3
order by ranking 



select
	fv.id_producto,
	df.mes,
	sum(fv.ventas) total_ventas
from fact_ventas fv
join dim_fecha df on fv.id_fecha = df.id_fecha 
group by fv.id_producto, df.mes
order by total_ventas desc
	


