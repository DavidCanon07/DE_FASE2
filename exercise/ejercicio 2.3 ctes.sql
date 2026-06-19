SELECT id_cliente, nombre, ciudad, segmento
FROM public.dim_clientes;


-- con una subconsulta
SELECT 
    dp.id_producto,
    dp.nombre AS nombre_producto,
    dp.categoria
FROM dim_productos dp
WHERE NOT EXISTS (
    SELECT 1 
    FROM fact_ventas fv
    JOIN dim_clientes dc ON fv.id_cliente = dc.id_cliente
    WHERE fv.id_producto = dp.id_producto
    AND dc.segmento = 'frecuente'  -- ← Clave: clientes frecuentes
)
ORDER BY dp.nombre;

-- Con CTE 
WITH compras_frecuentes AS (
    SELECT DISTINCT fv.id_producto
    FROM fact_ventas fv
    JOIN dim_clientes dc ON fv.id_cliente = dc.id_cliente
    WHERE dc.segmento = 'frecuente'
)

SELECT
    dp.id_producto,
    dp.nombre,
    dp.categoria
FROM dim_productos dp
WHERE dp.id_producto NOT IN (SELECT id_producto FROM compras_frecuentes)
ORDER BY dp.nombre