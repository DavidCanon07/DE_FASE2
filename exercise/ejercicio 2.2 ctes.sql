-- conoce el total_ventas
select
	dp.precio_unitario,
	fv.cantidad,
	fv.ventas,
	(fv.cantidad * dp.precio_unitario ) as total_venta
from dim_productos dp 
join fact_ventas fv on fv.id_producto = dp.id_producto 


-- CTE para conocer el margen promedio de ganancia
with margen_venta as (
	select 
		fv.id_producto,
		(fv.ventas - fv.costo) as margen_por_venta
	from fact_ventas fv 
)

select
	dp.categoria,
	round(AVG(mv.margen_por_venta)) as margen_promedio,
	SUM(fv.cantidad * dp.precio_unitario ) as total_ventas
from 
	margen_venta mv
join dim_productos dp on mv.id_producto = dp.id_producto 
join fact_ventas fv on fv.id_producto = dp.id_producto
group by dp.categoria;


-- Corrección — incluye todo lo necesario en la CTE
WITH margen_venta AS (
    SELECT
        fv.id_producto,
        fv.ventas,
        (fv.ventas - fv.costo) AS margen_por_venta
    FROM fact_ventas fv
)
SELECT
    dp.categoria,
    ROUND(AVG(mv.margen_por_venta)) AS margen_promedio,
    SUM(mv.ventas)                  AS total_ventas
FROM margen_venta mv
JOIN dim_productos dp ON mv.id_producto = dp.id_producto
GROUP BY dp.categoria
ORDER BY margen_promedio DESC;


