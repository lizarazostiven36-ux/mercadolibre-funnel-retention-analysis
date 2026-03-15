# Resumen Ejecutivo – Análisis de Embudo y Retención MercadoLibre

**Analista:** Stiven Lizarazo  
**Período analizado:** 1 de enero de 2025 – 31 de agosto de 2025  
**Rol simulado:** Analista de Producto – Equipo de Crecimiento y Retención

---

## 1. Contexto

El Director de Producto planteó el siguiente reto:

> *"Necesitamos entender en qué etapa del proceso perdemos usuarios y cómo podemos mejorar su retención a lo largo del tiempo."*

Este análisis usa SQL para mapear el embudo de conversión completo, identificar los principales puntos de fuga y evaluar la retención de usuarios por cohorte.

---

## 2. Análisis del Embudo de Conversión

### Metodología
- Cada etapa del embudo fue construida como un CTE independiente con usuarios únicos (`DISTINCT user_id`).
- Todas las etapas fueron unidas a `first_visit` mediante LEFT JOINs encadenados.
- Las tasas de conversión se calcularon como `usuarios_etapa * 100.0 / usuarios_first_visit`.

### Tasas de Conversión Generales (Ene–Ago 2025)

| Etapa | Conversión desde Primera Visita (%) |
|---|---|
| Selección de Producto / Promoción | 76.90% |
| Agregar al Carrito | 11.01% |
| Inicio de Checkout | 4.00% |
| Información de Envío | 2.42% |
| Información de Pago | 2.09% |
| **Compra** | **1.25%** |

> ⚠️ **La mayor caída ocurre entre Selección de Producto y Agregar al Carrito.**  
> El 76.9% de los usuarios hace clic en un producto, pero solo el 11% lo agrega al carrito — una pérdida de ~65 puntos porcentuales.  
> Este es el punto de fricción más crítico de todo el embudo.

### Conversión por País

| País | Select Item | Add to Cart | Begin Checkout | Shipping | Payment | **Compra** |
|---|---|---|---|---|---|---|
| Uruguay | 81.82% | 22.73% | 4.55% | 4.55% | 4.55% | **4.55%** |
| Bolivia | 80.65% | 9.68% | 3.23% | 3.23% | 3.23% | **3.23%** |
| México | 79.75% | 13.22% | 4.13% | 3.31% | 2.89% | **2.48%** |
| Perú | 84.55% | 10.00% | 2.73% | 2.73% | 1.82% | **1.82%** |
| Argentina | 75.00% | 8.75% | 4.38% | 1.88% | 1.88% | **1.25%** |
| Chile | 78.35% | 17.53% | 8.25% | 3.09% | 2.06% | **1.03%** |
| Brasil | 72.60% | 8.90% | 2.40% | 1.37% | 1.37% | **0.68%** |
| Ecuador | 74.58% | 10.17% | 5.08% | 1.69% | 1.69% | **0.00%** |
| Colombia | 76.36% | 9.70% | 4.85% | 3.03% | 2.42% | **0.00%** |
| Paraguay | 71.43% | 9.52% | 0.00% | 0.00% | 0.00% | **0.00%** |

> 🏆 **Uruguay y Bolivia lideran en conversión final.**  
> Ecuador, Colombia y Paraguay muestran 0% de conversión en compras — estos mercados requieren una investigación inmediata.  
> Algunos países podrían estar perdiendo usuarios por brechas en la experiencia local (idioma, UX, métodos de pago o adaptación al mercado).

---

## 3. Análisis de Retención

### Metodología
- La retención se midió en D7, D14, D21 y D28 usando conteos acumulados de usuarios activos.
- Un usuario se cuenta como retenido si `active = 1` Y `day_after_signup >= N`.
- Las cohortes se definieron por el mes de primer registro del usuario (formato `AAAA-MM` con `DATE_TRUNC`).

### Retención por País (%)

| País | D7 | D14 | D21 | D28 |
|---|---|---|---|---|
| Argentina | 85.1% | 52.3% | 22.5% | 1.8% |
| Bolivia | 80.8% | 46.8% | 19.2% | 2.5% |
| Brasil | 87.2% | 54.4% | 24.4% | 2.5% |
| Chile | 83.7% | 51.8% | 22.1% | 1.7% |
| Colombia | 84.5% | 52.0% | 21.8% | 1.6% |
| Ecuador | 79.1% | 50.0% | 20.6% | 2.5% |
| México | 86.1% | 55.8% | 25.5% | 3.1% |
| Paraguay | 80.9% | 46.1% | 22.1% | 2.1% |
| Perú | 84.3% | 51.1% | 22.9% | 3.2% |
| Uruguay | 86.1% | 48.8% | 23.0% | 2.5% |

> ⚠️ **La retención cae dramáticamente después del D21.**  
> La mayoría de los países pasan de ~85% en D7 a menos del 3% en D28 — una caída de más de 80 puntos porcentuales.  
> Las primeras dos semanas son críticas: los usuarios que no encuentran valor rápidamente se pierden de forma permanente.

### Retención por Cohorte Mensual (%)

| Cohorte | D7 | D14 | D21 | D28 |
|---|---|---|---|---|
| 2025-01 | 86.2% | 56.2% | 24.1% | — |
| 2025-02 | 86.8% | 56.0% | 24.6% | 2.7% |
| 2025-03 | 87.7% | 56.8% | 26.6% | 3.0% |
| 2025-04 | 87.2% | 53.9% | 23.0% | 2.0% |
| 2025-05 | 86.0% | 54.5% | 26.2% | 3.0% |
| 2025-06 | 85.9% | 55.1% | 25.2% | 2.1% |
| 2025-07 | 86.4% | 56.4% | 25.9% | 2.7% |
| 2025-08 | 70.8% | 29.7% | 7.5% | 0.2% |

> ⚠️ **La cohorte de agosto 2025 presenta una caída pronunciada en todos los hitos.**  
> Una retención D7 de 70.8% frente al ~87% de las cohortes anteriores es una señal de alerta.  
> Puede indicar un cambio en la calidad de adquisición de usuarios o un problema en la experiencia de onboarding de los meses más recientes.

---

## 4. Conclusiones Principales

1. **La mayor pérdida del embudo ocurre entre Selección de Producto → Agregar al Carrito:** Solo el 11% de los usuarios que hacen clic en un producto lo agregan al carrito. Mejorar las páginas de producto, la transparencia de precios y las recomendaciones tendría el mayor impacto.

2. **Varios países no convierten a compra:** Ecuador, Colombia y Paraguay muestran 0% de conversión final. Esto puede estar relacionado con la infraestructura de pagos, la confianza del usuario o problemas en el flujo de checkout.

3. **La retención sigue un patrón de caída en picada:** ~85% de los usuarios están activos en D7, pero solo ~2–3% permanece en D28. La plataforma capta el interés inicial pero no logra construir un hábito de uso.

4. **La cohorte de agosto 2025 tiene un rendimiento muy por debajo del promedio:** D7 bajó de ~87% a 70.8%. Esto es una alerta que puede indicar un cambio en la adquisición o una regresión en el producto.

---

## 5. Recomendaciones

### Mejoras en el Embudo
1. **Reducir la fricción entre ver un producto y agregarlo al carrito** — Probar con CTAs más claros, mejores fotos de producto y botón de "agregar al carrito" con un solo clic en móvil.
2. **Investigar los países con cero conversión** — Realizar auditorías del embudo para Ecuador, Colombia y Paraguay, enfocándose en barreras de checkout y disponibilidad de métodos de pago.
3. **Simplificar el checkout para las etapas con mayor abandono** — Pre-rellenar la información de envío y pago para usuarios recurrentes.

### Mejoras en Retención
1. **Construir una secuencia de onboarding D1–D7** — Emails de bienvenida y notificaciones push destacando los beneficios clave (envío gratis, promociones, devoluciones fáciles) en la primera semana.
2. **Campaña de reactivación en D14** — Segmentar a usuarios que no han vuelto después de 2 semanas con recomendaciones personalizadas basadas en su historial.
3. **Investigar la cohorte de agosto 2025** — Analizar qué cambió en la adquisición o la experiencia de producto para esta cohorte, ya que su retención inicial es significativamente inferior a todos los meses anteriores.
4. **Incentivo de fidelización en D28** — Ofrecer un descuento o cashback a usuarios próximos al día 28 para evitar la pérdida definitiva.

---

## 6. Técnicas de SQL Utilizadas

| Técnica | Archivo |
|---|---|
| CTEs (Common Table Expressions) | Todas las consultas de embudo y cohortes |
| LEFT JOIN multi-etapa para embudo | `02_embudo_conversion.sql`, `03_embudo_por_pais.sql` |
| Deduplicación con DISTINCT | Todas las consultas |
| CASE WHEN + COUNT DISTINCT | `04_retencion_por_pais.sql`, `05_retencion_por_cohorte.sql` |
| DATE_TRUNC + TO_CHAR | `05_retencion_por_cohorte.sql` |
| NULLIF para división segura | Todos los cálculos de conversión y retención |
| ROUND para legibilidad | Todos los porcentajes de salida |

---

*Este resumen fue elaborado como parte del programa de Análisis de Datos de TripleTen.*
