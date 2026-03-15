# Análisis de Embudo y Retención – MercadoLibre

## Descripción del Proyecto

Este proyecto analiza el recorrido del usuario y los patrones de retención en MercadoLibre usando SQL.

El objetivo es identificar en qué etapa del embudo de compra se pierden los usuarios y qué tan bien la plataforma retiene a sus usuarios a lo largo del tiempo.

Este análisis fue desarrollado como parte de un caso de estudio de Product Analytics, simulando el rol de **Analista de Crecimiento y Retención** en MercadoLibre.

---

## Preguntas de Negocio

1. ¿En qué etapa del embudo perdemos más usuarios?
2. ¿Cuáles son las tasas de conversión entre cada etapa del embudo?
3. ¿Cómo varía el rendimiento del embudo entre países?
4. ¿Qué tan bien retenemos usuarios en D7, D14, D21 y D28?
5. ¿Cómo se comporta la retención por cohorte y por país?

---

## Dataset

Se utilizaron dos tablas:

### `mercadolibre_funnel`
Registra eventos del usuario durante el proceso de compra.

| Columna | Tipo | Descripción |
|---|---|---|
| user_id | STRING | Identificador único del usuario |
| session_id | STRING | Identificador único de la sesión |
| event_name | STRING | Evento realizado (ej. add_to_cart, purchase) |
| event_times | FLOAT | Marca temporal en formato Unix (milisegundos) |
| country | STRING | País donde se generó el evento |
| device_category | STRING | Tipo de dispositivo (mobile, desktop, tablet) |
| platform | STRING | Plataforma (android, iOS, web) |
| product_cat | STRING | Categoría del producto |
| price | FLOAT | Precio del producto en el momento del evento |
| currency | STRING | Moneda (USD, ARS, etc.) |
| referral_source | STRING | Fuente de tráfico (organic, paid_search, social) |
| event_date | DATETIME | Fecha y hora legible del evento |

### `mercadolibre_retention`
Mide la actividad recurrente de los usuarios después del registro.

| Columna | Tipo | Descripción |
|---|---|---|
| user_id | STRING | Identificador único del usuario |
| signup_date | DATE | Fecha de registro del usuario |
| country | STRING | País del usuario |
| device_category | STRING | Tipo de dispositivo |
| platform | STRING | Plataforma |
| day_after_signup | INTEGER | Días transcurridos desde el registro |
| activity_date | DATE | Fecha de actividad del usuario |
| active | INTEGER | 1 = activo, 0 = inactivo |
| prob_active | FLOAT | Probabilidad estimada de actividad |

---

## Etapas del Embudo Analizadas

| Etapa | Evento | Descripción |
|---|---|---|
| 🟢 Descubrimiento | `first_visit` | El usuario entra a la plataforma por primera vez |
| 🟡 Interés | `select_item` / `select_promotion` | El usuario hace clic en un producto o promoción |
| 🟠 Intención de Compra | `add_to_cart` | El usuario agrega un producto al carrito |
| 🔵 Inicio de Compra | `begin_checkout` | El usuario inicia el proceso de pago |
| 🟣 Información de Envío | `add_shipping_info` | El usuario ingresa su dirección de envío |
| 🟤 Información de Pago | `add_payment_info` | El usuario agrega su método de pago |
| 🔴 Compra | `purchase` | El usuario completa la compra |

---

## Estructura del Proyecto

```
mercadolibre-funnel-retention-analysis/
│
├── README.md
├── sql/
│   ├── 01_exploracion.sql
│   ├── 02_embudo_conversion.sql
│   ├── 03_embudo_por_pais.sql
│   ├── 04_retencion_por_pais.sql
│   └── 05_retencion_por_cohorte.sql
│
└── insights/
    └── resumen_ejecutivo.md
```

---

## Técnicas de SQL Utilizadas

- CTEs (Common Table Expressions)
- Análisis de embudo con LEFT JOINs encadenados
- Cálculo de tasas de conversión
- Definición de cohortes con `DATE_TRUNC` y `TO_CHAR`
- Métricas de retención con `CASE WHEN` + `COUNT DISTINCT`
- `NULLIF` para evitar división por cero

---

## Principales Hallazgos

- La mayor caída del embudo ocurre entre **Select Item → Add to Cart** (~65 puntos porcentuales).
- Uruguay y Bolivia lideran en conversión final; Ecuador, Colombia y Paraguay muestran 0% de compras.
- La retención cae drásticamente después de la primera semana: ~85% en D7 vs ~2% en D28.
- La cohorte de agosto 2025 muestra un rendimiento significativamente inferior al resto.

---

## Herramientas

- SQL (sintaxis PostgreSQL)

---

## Autor

**Stiven Lizarazo**  
Analista de Datos Junior  
Proyecto desarrollado como parte del programa de Análisis de Datos de TripleTen.
