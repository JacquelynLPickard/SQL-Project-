-- ============================================================
-- SQL Data Analysis Project: Retail Sales Queries
-- Author: Jacquelyn L. Pickard
-- Skills Demonstrated:
--   ✅ Writing SQL queries
--   ✅ Filtering and sorting data (WHERE, ORDER BY)
--   ✅ JOIN statements (INNER, LEFT, self-join)
--   ✅ Aggregations (GROUP BY, COUNT, SUM, AVG, MAX)
--   ✅ Extracting actionable insights
-- ============================================================


-- ============================================================
-- SECTION 1: BASIC QUERIES — Filtering & Sorting
-- ============================================================

-- Query 1.1: All customers from Georgia, sorted by last name
-- Business Use: Identify regional customers for a targeted GA campaign.
SELECT
    customer_id,
    first_name,
    last_name,
    email,
    city,
    joined_date
FROM customers
WHERE state = 'GA'
ORDER BY last_name ASC;


-- Query 1.2: Products priced above $100, sorted by price descending
-- Business Use: Identify premium products for upsell marketing.
SELECT
    product_id,
    product_name,
    category,
    unit_price,
    stock_qty
FROM products
WHERE unit_price > 100
ORDER BY unit_price DESC;


-- Query 1.3: All completed orders placed in Q1 2023 (Jan–Mar)
-- Business Use: Evaluate Q1 sales activity.
SELECT
    order_id,
    customer_id,
    employee_id,
    order_date,
    status
FROM orders
WHERE status = 'Completed'
  AND order_date BETWEEN '2023-01-01' AND '2023-03-31'
ORDER BY order_date ASC;


-- Query 1.4: Products with low stock (fewer than 50 units), sorted by stock
-- Business Use: Flag products that need restocking soon.
SELECT
    product_id,
    product_name,
    category,
    stock_qty
FROM products
WHERE stock_qty < 50
ORDER BY stock_qty ASC;


-- ============================================================
-- SECTION 2: JOIN STATEMENTS
-- ============================================================

-- Query 2.1: INNER JOIN — Orders with full customer and employee details
-- Business Use: Unified view of who bought what and who processed it.
SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.first_name || ' ' || c.last_name  AS customer_name,
    c.city,
    c.state,
    e.first_name || ' ' || e.last_name  AS sales_rep
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN employees e ON o.employee_id = e.employee_id
ORDER BY o.order_date ASC;


-- Query 2.2: INNER JOIN — Order items with product names and line totals
-- Business Use: Detailed receipt-level view of every purchase.
SELECT
    oi.order_id,
    p.product_name,
    p.category,
    oi.quantity,
    oi.unit_price,
    ROUND(oi.quantity * oi.unit_price, 2) AS line_total
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_id, line_total DESC;


-- Query 2.3: LEFT JOIN — All customers, including those with no orders
-- Business Use: Identify inactive customers who have never ordered.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    c.joined_date,
    o.order_id,
    o.order_date,
    o.status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id;


-- Query 2.4: Self-JOIN — Employees with their manager's name
-- Business Use: Display org chart relationships in a flat table.
SELECT
    e.employee_id,
    e.first_name || ' ' || e.last_name   AS employee_name,
    e.department,
    e.salary,
    m.first_name || ' ' || m.last_name   AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY e.department, e.employee_id;


-- Query 2.5: Multi-table JOIN — Full order summary (orders + customers + items + products)
-- Business Use: End-to-end view of every transaction for reporting.
SELECT
    o.order_id,
    o.order_date,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.state,
    p.product_name,
    p.category,
    oi.quantity,
    ROUND(oi.quantity * oi.unit_price, 2) AS line_total
FROM orders o
INNER JOIN customers   c  ON o.customer_id  = c.customer_id
INNER JOIN order_items oi ON o.order_id     = oi.order_id
INNER JOIN products    p  ON oi.product_id  = p.product_id
WHERE o.status = 'Completed'
ORDER BY o.order_date, o.order_id;


-- ============================================================
-- SECTION 3: AGGREGATIONS
-- ============================================================

-- Query 3.1: Total revenue per product category (completed orders only)
-- Insight: Electronics dominate revenue — focus inventory investment there.
SELECT
    p.category,
    COUNT(DISTINCT o.order_id)              AS total_orders,
    SUM(oi.quantity)                        AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
INNER JOIN orders   o ON oi.order_id   = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.category
ORDER BY total_revenue DESC;


-- Query 3.2: Monthly revenue trend for 2023 (completed orders)
-- Insight: Spot peak and slow months to plan promotions accordingly.
SELECT
    strftime('%Y-%m', o.order_date)            AS month,
    COUNT(DISTINCT o.order_id)                 AS completed_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_revenue
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
  AND o.order_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY month
ORDER BY month;


-- Query 3.3: Top 5 best-selling products by revenue
-- Insight: Laptop Pro 15 drives the most revenue — protect stock levels.
SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity)                           AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
INNER JOIN orders   o ON oi.order_id   = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC
LIMIT 5;


-- Query 3.4: Sales rep performance — revenue and order count per employee
-- Insight: Compare reps to identify coaching opportunities or top performers.
SELECT
    e.first_name || ' ' || e.last_name         AS sales_rep,
    COUNT(DISTINCT o.order_id)                 AS total_orders,
    COUNT(DISTINCT CASE WHEN o.status = 'Completed' THEN o.order_id END) AS completed_orders,
    ROUND(SUM(CASE WHEN o.status = 'Completed'
                   THEN oi.quantity * oi.unit_price ELSE 0 END), 2)      AS revenue_generated
FROM employees e
INNER JOIN orders      o  ON e.employee_id = o.employee_id
INNER JOIN order_items oi ON o.order_id    = oi.order_id
WHERE e.department = 'Sales'
GROUP BY e.employee_id, sales_rep
ORDER BY revenue_generated DESC;


-- Query 3.5: Average order value per customer (completed orders)
-- Insight: High-AOV customers deserve loyalty perks to retain spend.
SELECT
    c.first_name || ' ' || c.last_name     AS customer_name,
    c.city,
    c.state,
    COUNT(DISTINCT o.order_id)             AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS lifetime_value,
    ROUND(AVG(order_totals.order_total), 2)    AS avg_order_value
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN (
    SELECT order_id,
           SUM(quantity * unit_price) AS order_total
    FROM order_items
    GROUP BY order_id
) order_totals ON o.order_id = order_totals.order_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, customer_name, c.city, c.state
ORDER BY lifetime_value DESC;


-- Query 3.6: Cancellation rate by employee
-- Insight: High cancellation rates may flag communication or process issues.
SELECT
    e.first_name || ' ' || e.last_name             AS sales_rep,
    COUNT(o.order_id)                               AS total_orders,
    SUM(CASE WHEN o.status = 'Cancelled' THEN 1 ELSE 0 END)  AS cancelled_orders,
    ROUND(
        100.0 * SUM(CASE WHEN o.status = 'Cancelled' THEN 1 ELSE 0 END)
              / COUNT(o.order_id), 1
    )                                               AS cancellation_rate_pct
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
WHERE e.department = 'Sales'
GROUP BY e.employee_id, sales_rep
HAVING COUNT(o.order_id) > 1
ORDER BY cancellation_rate_pct DESC;


-- ============================================================
-- SECTION 4: ACTIONABLE INSIGHTS (Advanced Queries)
-- ============================================================

-- Query 4.1: Customers who have NOT placed any orders (churned / never converted)
-- Action: Trigger a re-engagement email campaign for these customers.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    c.city,
    c.state,
    c.joined_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
ORDER BY c.joined_date;


-- Query 4.2: Customers with only cancelled orders (zero successful purchases)
-- Action: Outreach to understand purchase barriers; offer discount incentive.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    c.email,
    COUNT(o.order_id)                  AS total_orders,
    SUM(CASE WHEN o.status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_count
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name, c.email
HAVING COUNT(o.order_id) = SUM(CASE WHEN o.status = 'Cancelled' THEN 1 ELSE 0 END);


-- Query 4.3: Revenue by state — geographic opportunity analysis
-- Action: States with high revenue but few customers = expansion opportunity.
SELECT
    c.state,
    COUNT(DISTINCT c.customer_id)              AS unique_customers,
    COUNT(DISTINCT o.order_id)                 AS total_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue,
    ROUND(SUM(oi.quantity * oi.unit_price)
          / COUNT(DISTINCT c.customer_id), 2)  AS revenue_per_customer
FROM customers c
INNER JOIN orders      o  ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id    = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.state
ORDER BY total_revenue DESC;


-- Query 4.4: Product cross-sell pairs — products frequently ordered together
-- Action: Bundle or recommend these pairs to increase average basket size.
SELECT
    p1.product_name AS product_a,
    p2.product_name AS product_b,
    COUNT(*)        AS times_ordered_together
FROM order_items oi1
INNER JOIN order_items oi2 ON oi1.order_id = oi2.order_id
                           AND oi1.product_id < oi2.product_id
INNER JOIN products p1 ON oi1.product_id = p1.product_id
INNER JOIN products p2 ON oi2.product_id = p2.product_id
GROUP BY p1.product_name, p2.product_name
HAVING COUNT(*) > 1
ORDER BY times_ordered_together DESC;


-- Query 4.5: Employee salary vs. revenue generated — ROI by sales rep
-- Action: Identify reps generating revenue well above their salary cost.
SELECT
    e.first_name || ' ' || e.last_name         AS sales_rep,
    e.salary                                   AS annual_salary,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue_generated,
    ROUND(SUM(oi.quantity * oi.unit_price) / e.salary, 2) AS revenue_to_salary_ratio
FROM employees e
INNER JOIN orders      o  ON e.employee_id = o.employee_id
INNER JOIN order_items oi ON o.order_id    = oi.order_id
WHERE e.department = 'Sales'
  AND o.status = 'Completed'
GROUP BY e.employee_id, sales_rep, e.salary
ORDER BY revenue_to_salary_ratio DESC;