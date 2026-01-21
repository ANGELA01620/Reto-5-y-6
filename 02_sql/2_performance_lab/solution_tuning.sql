
SET STATISTICS IO ON;  -- Muestra lecturas de disco
SET STATISTICS TIME ON; -- Muestra tiempo de CPU

PRINT '>>> INICIO DEL BENCHMARK <<<';

-- =======================================================
-- ESCENARIO 1: LA CONSULTA TÓXICA (CROSS JOIN)
-- =======================================================
PRINT '--- EJECUTANDO CROSS JOIN (Producto Cartesiano) ---';

-- Esta consulta genera un producto cartesiano combinando todas las filas de Cliente con todas las de Producto.
-- Esto simula el error del desarrollador junior.
SELECT
    c.Nombre AS Cliente,
    p.Nombre AS Producto
FROM Cliente c
CROSS JOIN Producto p;



-- =======================================================
-- ESCENARIO 2: LA CONSULTA EFICIENTE (INNER JOIN)
-- =======================================================
PRINT '--- EJECUTANDO INNER JOIN (Ventas Reales) ---';

-- Esta consulta recupera SOLO las ventas que realmente ocurrieron, usando las llaves foráneas.
SELECT
    c.Nombre AS Cliente,
    p.Nombre AS Producto,
    v.Fecha,
    v.Cantidad
FROM Venta v
INNER JOIN Cliente c ON v.ClienteID = c.ClienteID
INNER JOIN Producto p ON v.ProductoID = p.ProductoID;






-- COMPARACIÓN:
-- Los Logical Reads serán mínimos porque SQL Server usa los índices (PKs) para buscar directamente las filas relacionadas.
-- El número de filas devuelto es exacto a la realidad del negocio, no inflado artificialmente.

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
