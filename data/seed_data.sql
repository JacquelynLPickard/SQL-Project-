-- ============================================================
-- Seed Data for Retail Sales Database
-- ============================================================

-- Employees
INSERT INTO employees (employee_id, first_name, last_name, department, hire_date, salary, manager_id) VALUES
(1,  'Sarah',   'Mitchell',  'Management',  '2018-03-01', 95000, NULL),
(2,  'David',   'Chen',      'Sales',       '2019-06-15', 62000, 1),
(3,  'Priya',   'Okafor',    'Sales',       '2020-01-10', 58000, 1),
(4,  'Marcus',  'Williams',  'Sales',       '2021-04-22', 55000, 1),
(5,  'Elena',   'Torres',    'Support',     '2020-09-05', 52000, 1),
(6,  'James',   'Patterson', 'Sales',       '2022-02-14', 54000, 1),
(7,  'Nia',     'Jackson',   'Support',     '2023-07-01', 50000, 1);

-- Customers
INSERT INTO customers (customer_id, first_name, last_name, email, city, state, joined_date) VALUES
(1,  'Alice',   'Brown',    'alice.brown@email.com',    'Atlanta',      'GA', '2021-01-15'),
(2,  'Bob',     'Smith',    'bob.smith@email.com',      'Dallas',       'TX', '2021-03-22'),
(3,  'Carol',   'Davis',    'carol.davis@email.com',    'Chicago',      'IL', '2021-05-10'),
(4,  'Derek',   'Lee',      'derek.lee@email.com',      'Seattle',      'WA', '2021-07-04'),
(5,  'Eva',     'Martin',   'eva.martin@email.com',     'Miami',        'FL', '2021-09-18'),
(6,  'Frank',   'Garcia',   'frank.garcia@email.com',   'Phoenix',      'AZ', '2022-01-30'),
(7,  'Grace',   'Wilson',   'grace.wilson@email.com',   'New York',     'NY', '2022-03-14'),
(8,  'Henry',   'Anderson', 'henry.a@email.com',        'Los Angeles',  'CA', '2022-06-01'),
(9,  'Iris',    'Thomas',   'iris.thomas@email.com',    'Atlanta',      'GA', '2022-08-22'),
(10, 'Jason',   'White',    'jason.white@email.com',    'Houston',      'TX', '2022-11-05'),
(11, 'Karen',   'Harris',   'karen.harris@email.com',   'Chicago',      'IL', '2023-01-17'),
(12, 'Leo',     'Clark',    'leo.clark@email.com',      'Denver',       'CO', '2023-04-09');

-- Products
INSERT INTO products (product_id, product_name, category, unit_price, stock_qty) VALUES
(1,  'Laptop Pro 15',        'Electronics',  1299.99, 45),
(2,  'Wireless Mouse',       'Electronics',    29.99, 200),
(3,  'USB-C Hub',            'Electronics',    49.99, 150),
(4,  'Office Chair',         'Furniture',     349.99,  30),
(5,  'Standing Desk',        'Furniture',     599.99,  20),
(6,  'Notebook Set (5pk)',   'Stationery',     12.99, 500),
(7,  'Mechanical Keyboard',  'Electronics',    89.99,  80),
(8,  'Monitor 27"',          'Electronics',   399.99,  60),
(9,  'Desk Lamp',            'Furniture',      34.99, 120),
(10, 'Whiteboard 36x48',     'Stationery',     79.99,  40);

-- Orders
INSERT INTO orders (order_id, customer_id, employee_id, order_date, status) VALUES
(1,   1,  2, '2023-01-05', 'Completed'),
(2,   2,  3, '2023-01-12', 'Completed'),
(3,   3,  4, '2023-01-20', 'Cancelled'),
(4,   4,  2, '2023-02-02', 'Completed'),
(5,   5,  3, '2023-02-14', 'Completed'),
(6,   6,  6, '2023-02-28', 'Pending'),
(7,   7,  2, '2023-03-05', 'Completed'),
(8,   8,  4, '2023-03-15', 'Completed'),
(9,   9,  3, '2023-03-22', 'Completed'),
(10,  10, 6, '2023-04-01', 'Completed'),
(11,  11, 2, '2023-04-10', 'Completed'),
(12,  12, 3, '2023-04-18', 'Pending'),
(13,   1, 4, '2023-05-02', 'Completed'),
(14,   2, 6, '2023-05-20', 'Completed'),
(15,   5, 2, '2023-06-01', 'Completed'),
(16,   7, 3, '2023-06-15', 'Completed'),
(17,   9, 4, '2023-07-04', 'Completed'),
(18,   1, 6, '2023-07-22', 'Cancelled'),
(19,   3, 2, '2023-08-08', 'Completed'),
(20,  10, 3, '2023-08-30', 'Completed');

-- Order Items
INSERT INTO order_items (item_id, order_id, product_id, quantity, unit_price) VALUES
(1,   1,  1, 1, 1299.99),
(2,   1,  2, 2,   29.99),
(3,   2,  7, 1,   89.99),
(4,   2,  3, 1,   49.99),
(5,   3,  4, 1,  349.99),
(6,   4,  8, 1,  399.99),
(7,   4,  2, 1,   29.99),
(8,   5,  5, 1,  599.99),
(9,   5,  9, 2,   34.99),
(10,  6,  1, 2, 1299.99),
(11,  7,  3, 3,   49.99),
(12,  7,  6, 5,   12.99),
(13,  8,  8, 2,  399.99),
(14,  9,  7, 1,   89.99),
(15,  9,  2, 3,   29.99),
(16, 10, 10, 2,   79.99),
(17, 11,  1, 1, 1299.99),
(18, 11,  3, 1,   49.99),
(19, 12,  5, 1,  599.99),
(20, 12,  9, 1,   34.99),
(21, 13,  2, 4,   29.99),
(22, 13,  6, 10,  12.99),
(23, 14,  8, 1,  399.99),
(24, 14,  7, 1,   89.99),
(25, 15,  4, 1,  349.99),
(26, 16,  1, 1, 1299.99),
(27, 16,  2, 1,   29.99),
(28, 17,  3, 2,   49.99),
(29, 17, 10, 1,   79.99),
(30, 18,  8, 1,  399.99),
(31, 19,  7, 2,   89.99),
(32, 19,  6, 5,   12.99),
(33, 20,  1, 1, 1299.99),
(34, 20,  9, 2,   34.99);