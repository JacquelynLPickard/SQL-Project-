# Retail Sales SQL Analysis

**Author:** Jacquelyn L Pickard
**Part of:** Google Data Analytics Learning Journey
**Status:** ✅ Complete 

---

## Project Overview

This project demonstrates foundational SQL data analysis skills using a simulated **retail sales database**. The dataset includes customers, employees, products, orders, and order line items typical of a real world business data environment. 

---

## Skills Demonstrated

| Skill | Where Applied |
|---|---|
| ✅ Writing SQL queries | All sections |
| ✅ Filtering & sorting (`WHERE`, `ORDER BY`, `BETWEEN`) | Section 1 |
| ✅ JOIN statements (`INNER JOIN`, `LEFT JOIN`, self-join) | Section 2 |
| ✅ Aggregations (`GROUP BY`, `SUM`, `AVG`, `COUNT`, `ROUND`) | Section 3 |
| ✅ Actionable business insights | Section 4 |

---

## Project Structure

```
SQL-Project-/
│
├── data/
│   ├── schema.sql          — Table definitions (CREATE TABLE)
│   └── seed_data.sql       — Sample data (INSERT statements)
│
├── queries/
│   └── analysis_queries.sql — All 20 SQL queries, organized by skill
│
├── run_queries.py          — Python runner: executes all queries & prints results
└── README.md
```

---

## Database Schema

The retail database contains **5 related tables**:

```
employees ──────────────────────────────────────────┐
    employee_id (PK)                                 │
    first_name, last_name, department                │
    hire_date, salary, manager_id (FK → self)        │
                                                     │
customers ────────────────────┐                      │
    customer_id (PK)          │                      │
    first_name, last_name     │                      │
    email, city, state        │                      │
    joined_date               │                      │
                              ▼                      ▼
                         orders ──────────────────────
                             order_id (PK)
                             customer_id (FK)
                             employee_id (FK)
                             order_date, status
                                  │
                                  ▼
                         order_items
                             item_id (PK)
                             order_id (FK)
                             product_id (FK)  ←──── products
                             quantity, unit_price       product_id (PK)
                                                        product_name, category
                                                        unit_price, stock_qty
```

---

## Query Sections

### Section 1: Filtering & Sorting
| # | Query | Technique |
|---|---|---|
| 1.1 | Customers by state | `WHERE`, `ORDER BY` |
| 1.2 | Products above $100 | `WHERE`, `ORDER BY DESC` |
| 1.3 | Completed orders in Q1 2023 | `WHERE`, `BETWEEN` |
| 1.4 | Low-stock products | `WHERE`, `ORDER BY` |

### Section 2: JOIN Statements
| # | Query | Technique |
|---|---|---|
| 2.1 | Orders with customer & employee names | `INNER JOIN` (3 tables) |
| 2.2 | Order items with product details | `INNER JOIN` |
| 2.3 | All customers, including those with no orders | `LEFT JOIN` |
| 2.4 | Employees with their manager's name | Self-`JOIN` |
| 2.5 | Full order summary (5-table join) | Multi-table `INNER JOIN` |

### Section 3: Aggregations
| # | Query | Technique |
|---|---|---|
| 3.1 | Revenue by product category | `GROUP BY`, `SUM`, `COUNT` |
| 3.2 | Monthly revenue trend | `GROUP BY`, `strftime` |
| 3.3 | Top 5 products by revenue | `GROUP BY`, `LIMIT` |
| 3.4 | Sales rep performance | `GROUP BY`, `CASE WHEN` |
| 3.5 | Customer lifetime value & AOV | Subquery, `AVG` |
| 3.6 | Cancellation rate per rep | `HAVING`, percentage calc |

### Section 4: Actionable Insights
| # | Query | Business Insight |
|---|---|---|
| 4.1 | Customers with no orders | Re-engagement campaign targets |
| 4.2 | Customers with only cancellations | Recovery outreach list |
| 4.3 | Revenue by state | Geographic expansion analysis |
| 4.4 | Product cross-sell pairs | Bundle/recommendation strategy |
| 4.5 | Revenue-to-salary ratio per rep | Sales ROI analysis |

---

## How to Run

**Prerequisites:** Python 3.8+ (no external packages required uses built in `sqlite3`)

```bash
# Clone the repo
git clone https://github.com/JacquelynLPickard/SQL-Project-.git
cd SQL-Project-

# Run all queries
python run_queries.py
```

The script loads the schema and seed data into an in memory SQLite database and prints every query with its results in a formatted table.

---

## Key Findings (Sample Insights)

- **Electronics** is the highest-revenue category, driven largely by the *Laptop Pro 15* ($1,299.99 unit price).
- **David Chen** leads the sales team in revenue generated.
- **Atlanta, GA** customers have the highest repeat purchase rate.
- The *Laptop Pro 15 + Wireless Mouse* pair is the most common product combination a strong bundling opportunity.
- Several customers joined in 2021–2022 but have **zero completed orders** prime re-engagement targets.

---

## Tools

- **SQL** (SQLite-compatible syntax, also runs in BigQuery with minor `date` function adjustments)
- **Python 3** for local execution via `sqlite3` module
- **VS Code** development environment
- **Git / GitHub** version control

---

*This project reflects my growth as a data analyst and my commitment to building practical, portfolio-ready SQL skills.*
