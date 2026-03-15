-- ============================================================
-- ARCHIVO: 04_retencion_por_pais.sql
-- PROYECTO: Análisis de Embudo y Retención – MercadoLibre
-- DESCRIPCIÓN: Mide la retención de usuarios al día 7, 14, 21
--              y 28 desde su registro, segmentada por país.
-- RANGO DE FECHAS: 2025-01-01 al 2025-08-31
-- ============================================================


-- ----------------------------------------
-- PARTE A: Conteo de usuarios activos por país (D7, D14, D21, D28)
-- ----------------------------------------
SELECT
    country,
    COUNT(DISTINCT CASE WHEN day_after_signup >= 7  AND active = 1 THEN user_id END) AS usuarios_d7,
    COUNT(DISTINCT CASE WHEN day_after_signup >= 14 AND active = 1 THEN user_id END) AS usuarios_d14,
    COUNT(DISTINCT CASE WHEN day_after_signup >= 21 AND active = 1 THEN user_id END) AS usuarios_d21,
    COUNT(DISTINCT CASE WHEN day_after_signup >= 28 AND active = 1 THEN user_id END) AS usuarios_d28
FROM mercadolibre_retention
WHERE activity_date BETWEEN '2025-01-01' AND '2025-08-31'
GROUP BY country
ORDER BY country;


-- ----------------------------------------
-- PARTE B: Tasa de retención (%) por país (D7, D14, D21, D28)
-- ----------------------------------------
SELECT
    country,
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
FROM mercadolibre_retention
WHERE activity_date BETWEEN '2025-01-01' AND '2025-08-31'
GROUP BY country
ORDER BY country;
