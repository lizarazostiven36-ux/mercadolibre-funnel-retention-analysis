-- ============================================================
-- FILE: 01_exploration.sql
-- PROJECT: MercadoLibre Funnel & Retention Analysis
-- DESCRIPTION: Initial data exploration to understand schema
--              and confirm event sequence for funnel analysis.
-- ============================================================


-- ----------------------------------------
-- 1. Preview the funnel dataset (first 5 rows)
-- ----------------------------------------
SELECT *
FROM mercadolibre_funnel
LIMIT 5;


-- ----------------------------------------
-- 2. Preview the retention dataset (first 5 rows)
-- ----------------------------------------
SELECT *
FROM mercadolibre_retention
LIMIT 5;


-- ----------------------------------------
-- 3. List all unique event types in the funnel
--    to confirm the full purchase journey sequence
-- ----------------------------------------
SELECT DISTINCT event_name
FROM mercadolibre_funnel
ORDER BY event_name;
