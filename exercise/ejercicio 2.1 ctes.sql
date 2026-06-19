select fv.id_cliente, fv.costo from fact_ventas fv;
select dc.id_cliente, dc.nombre from dim_clientes dc;

-- CTE de los 3 clientes con mayor gasto
with top_3_gastos as (
	select 
		fv.id_cliente, 
		sum(fv.costo) as costo_total
	from fact_ventas fv 
	group by fv.id_cliente
	limit 3)

select 
	dc.id_cliente,
	dc.nombre,
	dc.ciudad,
	tp.costo_total
from top_3_gastos tp
join dim_clientes dc on tp.id_cliente = dc.id_cliente 
order by tp.costo_total desc;

--  Corrección
WITH gasto_por_cliente AS (
    SELECT
        id_cliente,
        SUM(ventas) AS gasto_total
    FROM fact_ventas
    GROUP BY id_cliente
),
top_3 AS (
    SELECT
        id_cliente,
        gasto_total,
        RANK() OVER (ORDER BY gasto_total DESC) AS ranking
    FROM gasto_por_cliente
)
SELECT
    dc.nombre,
    dc.ciudad,
    t.gasto_total,
    t.ranking
FROM top_3 t
JOIN dim_clientes dc ON t.id_cliente = dc.id_cliente
WHERE t.ranking <= 3
ORDER BY t.ranking;