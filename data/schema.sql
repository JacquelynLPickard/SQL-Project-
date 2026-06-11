-- ============================================================
-- SQL Data Analysis Project: Retail Sales Database
-- Author: Jacquelyn L. Pickard
-- Description: Schema for a retail company with customers,
--              products, orders, and employees.
-- ============================================================

-- Employees table
CREATE TABLE IF NOT EXISTS employees (
    employee_id   INTEGER PRIMARY KEY,
    first_name    TEXT NOT NULL,
    last_name     TEXT NOT NULL,
    department    TEXT NOT NULL,
    hire_date     DATE NOT NULL,
    salary        REAL NOT NULL,
    manager_id    INTEGER REFERENCES employees(employee_id)
);

-- Customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id   INTEGER PRIMARY KEY,
    first_name    TEXT NOT NULL,
    last_name     TEXT NOT NULL,
    email         TEXT UNIQUE NOT NULL,
    city          TEXT NOT NULL,
    state         TEXT NOT NULL,
    joined_date   DATE NOT NULL
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
    product_id    INTEGER PRIMARY KEY,
    product_name  TEXT NOT NULL,
    category      TEXT NOT NULL,
    unit_price    REAL NOT NULL,
    stock_qty     INTEGER NOT NULL
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
    order_id      INTEGER PRIMARY KEY,
    customer_id   INTEGER NOT NULL REFERENCES customers(customer_id),
    employee_id   INTEGER NOT NULL REFERENCES employees(employee_id),
    order_date    DATE NOT NULL,
    status        TEXT NOT NULL CHECK(status IN ('Completed','Pending','Cancelled'))
);

-- Order Items table (line items per order)
CREATE TABLE IF NOT EXISTS order_items (
    item_id       INTEGER PRIMARY KEY,
    order_id      INTEGER NOT NULL REFERENCES orders(order_id),
    product_id    INTEGER NOT NULL REFERENCES products(product_id),
    quantity      INTEGER NOT NULL,
    unit_price    REAL NOT NULL   -- price at time of purchase
);