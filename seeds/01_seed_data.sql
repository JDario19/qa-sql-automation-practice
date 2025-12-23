-- seeds/01_seed_data.sql
-- Seed data for QA SQL practice (includes intentional inconsistencies)

-- Clean (optional). Run only if you want to reset data:
-- TRUNCATE TABLE login_events, shipments, payments, order_items, orders, products, users RESTART IDENTITY CASCADE;

-- 1) USERS
INSERT INTO users (email, full_name, status)
VALUES
  ('ana@example.com',  'Ana Gomez',  'active'),
  ('luis@example.com', 'Luis Perez', 'active'),
  ('maria@example.com','Maria Diaz', 'blocked'),
  ('noorders@example.com','No Orders User','active');

-- 2) PRODUCTS
INSERT INTO products (sku, name, price, is_active)
VALUES
  ('SKU-001','Wireless Mouse', 399.00, TRUE),
  ('SKU-002','Mechanical Keyboard', 1299.00, TRUE),
  ('SKU-003','USB-C Cable', 149.00, TRUE),
  ('SKU-004','Old Headset (inactive)', 899.00, FALSE);

-- 3) ORDERS
-- Order 1 (Ana) -> will be "paid", but total may not match items (intentional)
INSERT INTO orders (user_id, status, total_amount)
VALUES (1, 'paid', 1200.00);

-- Order 2 (Luis) -> created, no items yet (intentional issue: order without items)
INSERT INTO orders (user_id, status, total_amount)
VALUES (2, 'created', 0.00);

-- Order 3 (Maria blocked) -> created (intentional issue: blocked user has an order)
INSERT INTO orders (user_id, status, total_amount)
VALUES (3, 'created', 548.00);

-- Order 4 (Ana) -> shipped but will have NO shipment (intentional issue)
INSERT INTO orders (user_id, status, total_amount)
VALUES (1, 'shipped', 548.00);

-- 4) ORDER ITEMS
-- Order 1 items (Ana): should sum to 399 + 149 = 548 but order total is 1200 (intentional mismatch)
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES
  (1, 1, 1, 399.00),
  (1, 3, 1, 149.00);

-- Order 3 items (Maria): sum = 399 + 149 = 548 (matches order total 548)
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES
  (3, 1, 1, 399.00),
  (3, 3, 1, 149.00);

-- Order 4 items (Ana): sum = 399 + 149 = 548 (matches order total 548)
INSERT INTO order_items (order_id, product_id, qty, unit_price)
VALUES
  (4, 1, 1, 399.00),
  (4, 3, 1, 149.00);

-- 5) PAYMENTS
-- Order 1: two approved payments (intentional duplicate payment scenario)
INSERT INTO payments (order_id, amount, method, status, paid_at)
VALUES
  (1, 1200.00, 'card', 'approved', NOW()),
  (1, 1200.00, 'card', 'approved', NOW()); -- duplicate

-- Order 3: approved payment even though user is blocked (intentional business rule issue)
INSERT INTO payments (order_id, amount, method, status, paid_at)
VALUES
  (3, 548.00, 'paypal', 'approved', NOW());

-- Order 2: order exists but has a payment pending (also weird because order has no items)
INSERT INTO payments (order_id, amount, method, status, paid_at)
VALUES
  (2, 0.00, 'cash', 'pending', NULL);

-- 6) SHIPMENTS
-- Create shipment for Order 1 (even though it is only "paid" - may be ok, but we'll keep it)
INSERT INTO shipments (order_id, carrier, tracking_number, status, shipped_at)
VALUES
  (1, 'DHL', 'TRACK-AAA-111', 'shipped', NOW());

-- Order 4 is "shipped" but intentionally has NO shipment record (data integrity issue)

-- 7) LOGIN EVENTS
INSERT INTO login_events (user_id, event_type, ip_address, user_agent)
VALUES
  (1, 'login_success', '187.1.1.10', 'Chrome'),
  (1, 'logout',        '187.1.1.10', 'Chrome'),
  (2, 'login_failed',  '187.1.1.20', 'Firefox'),
  (2, 'login_success', '187.1.1.20', 'Firefox'),
  (3, 'login_success', '187.1.1.30', 'Safari'); -- blocked user logging in (intentional)
