# MercadoLibre Funnel & Retention Analysis

## Project Overview

This project analyzes the user journey and retention patterns in MercadoLibre using SQL.

The goal is to identify where users drop off in the purchase funnel and how well the platform retains users over time.

This analysis was built as part of a Product Analytics case study, simulating the role of a **Growth & Retention Analyst** at MercadoLibre.

---

## Business Questions

1. Where do we lose the most users in the conversion funnel?
2. What are the conversion rates between funnel stages?
3. How does the funnel performance vary across countries?
4. How well do we retain users at D7, D14, D21, and D28?
5. How does retention behave by cohort and country?

---

## Dataset

Two datasets were used:

### `mercadolibre_funnel`
Registers user events during the purchase journey.

| Column | Type | Description |
|---|---|---|
| user_id | STRING | Unique user identifier |
| session_id | STRING | Unique session identifier |
| event_name | STRING | Event performed (e.g. add_to_cart, purchase) |
| event_times | FLOAT | Unix timestamp in milliseconds |
| country | STRING | Country where the event was generated |
| device_category | STRING | Device type (mobile, desktop, tablet) |
| platform | STRING | Platform (android, iOS, web) |
| product_cat | STRING | Product category |
| price | FLOAT | Product price at the time of event |
| currency | STRING | Currency (USD, ARS, etc.) |
| referral_source | STRING | Traffic source (organic, paid_search, social) |
| event_date | DATETIME | Human-readable event date |

### `mercadolibre_retention`
Tracks recurring user activity after signup.

| Column | Type | Description |
|---|---|---|
| user_id | STRING | Unique user identifier |
| signup_date | DATE | User registration date |
| country | STRING | User's country |
| device_category | STRING | Device type |
| platform | STRING | Platform |
| day_after_signup | INTEGER | Days since registration |
| activity_date | DATE | Date of user activity |
| active | INTEGER | 1 = active, 0 = inactive |
| prob_active | FLOAT | Predicted probability of activity |

---

## Funnel Stages Analyzed

| Stage | Event | Description |
|---|---|---|
| 🟢 Discovery | `first_visit` | User enters the platform for the first time |
| 🟡 Interest | `select_item` / `select_promotion` | User clicks on a product or promotion |
| 🟠 Purchase Intent | `add_to_cart` | User adds product to cart |
| 🔵 Checkout Start | `begin_checkout` | User starts payment process |
| 🟣 Shipping Info | `add_shipping_info` | User enters shipping details |
| 🟤 Payment Info | `add_payment_info` | User adds payment method |
| 🔴 Purchase | `purchase` | User completes the purchase |

---

## Project Structure

```
mercadolibre-funnel-retention-analysis/
│
├── README.md
├── sql/
│   ├── 01_exploration.sql
│   ├── 02_funnel_analysis.sql
│   ├── 03_country_funnel.sql
│   ├── 04_retention_analysis.sql
│   └── 05_cohort_retention.sql
│
└── insights/
    └── executive_summary.md
```

---

## SQL Techniques Used

- Common Table Expressions (CTEs)
- Funnel Analysis with multi-stage LEFT JOINs
- Conversion Rate Calculations
- Cohort Definition with `DATE_TRUNC` and `TO_CHAR`
- Retention Metrics using `CASE WHEN` + `COUNT DISTINCT`
- `NULLIF` for safe division

---

## Key Insights

- The largest user drop occurs between **first visit → product selection** (~50% drop).
- Some countries show significantly higher purchase conversion rates.
- User retention decreases sharply after the first week across all cohorts.
- D28 retention is consistently lower than D7 across all countries.

---

## Tools

- SQL (PostgreSQL syntax)

---

## Author

**Stiven Lizarazo**  
Junior Data Analyst  
Project developed as part of TripleTen's Data Analytics program.
