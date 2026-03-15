-- ============================================================
-- ARCHIVO: 05_retencion_por_cohorte.sql
-- PROYECTO: Análisis de Embudo y Retención – MercadoLibre
-- DESCRIPCIÓN: Análisis de retención por cohorte mensual.
--              Agrupa a los usuarios por su mes de registro
--              y mide qué porcentaje sigue activo al D7,
--              D14, D21 y D28.
-- RANGO DE FECHAS: 2025-01-01 al 2025-08-31
-- ============================================================


-- ----------------------------------------
-- PARTE A: Asignar a cada usuario su cohorte mensual (AAAA-MM)
--          Muestra las primeras 5 filas para validar
-- ----------------------------------------
SELECT
    user_id,
    MIN(signup_date) AS fecha_registro,
    TO_CHAR(DATE_TRUNC('month', MIN(signup_date)), 'YYYY-MM') AS cohorte
FROM mercadolibre_retention
GROUP BY user_id
LIMIT 5;


-- ----------------------------------------
-- PARTE B: Tasa de retención (%) por cohorte mensual
-- ----------------------------------------
WITH cohorte AS (
    -- Asignar cohorte mensual a cada usuario según su primera fecha de registro
    SELECT
        user_id,
        TO_CHAR(DATE_TRUNC('month', MIN(signup_date)), 'YYYY-MM') AS cohorte
    FROM mercadolibre_retention
    GROUP BY user_id
),
actividad AS (
    -- Unir los datos de retención con las etiquetas de cohorte
    -- Filtrar al rango de fechas del análisis
    SELECT
        r.user_id,
        c.cohorte,
        r.day_after_signup,
        r.active
    FROM mercadolibre_retention r
    LEFT JOIN cohorte c ON r.user_id = c.user_id
    WHERE r.activity_date BETWEEN '2025-01-01' AND '2025-08-31'
)

-- Calcular la tasa de retención por cohorte en cada hito
SELECT
    cohorte,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 7  AND active = 1 THEN user_id END)
        / NULLIF(COUNT(DISTINCT user_id), 0), 1
    ) AS retention_d7_pct,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 14 AND active = 1 THEN user_id END)
        / NULLIF(COUNT(DISTINCT user_id), 0), 1
    ) AS retention_d14_pct,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 21 AND active = 1 THEN user_id END)
        / NULLIF(COUNT(DISTINCT user_id), 0), 1
    ) AS retention_d21_pct,
    ROUND(
        100.0 * COUNT(DISTINCT CASE WHEN day_after_signup >= 28 AND active = 1 THEN user_id END)
        / NULLIF(COUNT(DISTINCT user_id), 0), 1
    ) AS retention_d28_pct
FROM actividad
GROUP BY cohorte
ORDER BY cohorte;
