-- =========================================================
-- seeds/05_payments.sql
-- Payments seed data for QA SQL practice
--
-- This file inserts realistic payment data and also
-- introduces intentional data bugs for interview practice.
-- =========================================================


-- ---------------------------------------------------------
-- 1️⃣ NORMAL CASE
-- Create approved payments for orders that are:
-- paid / shipped / delivered
--
-- Business logic:
-- These orders are supposed to have a successful payment.
--
-- QA relevance:
-- This represents the "happy path" scenario.
-- ---------------------------------------------------------
INSERT INTO payments (order_id, amount, method, status, paid_at, created_at)
SELECT
  o.id AS order_id,
  o.total_amount AS amount,              -- Payment matches order total
  CASE
    WHEN random() < 0.45 THEN 'card'      -- Random payment methods
    WHEN random() < 0.75 THEN 'paypal'
    ELSE 'transfer'
  END AS method,
  'approved' AS status,                  -- Successful payment
  NOW() - INTERVAL '1 day' * (1 + (random() * 20)::int) AS paid_at,
  NOW() - INTERVAL '1 day' * (1 + (random() * 20)::int) AS created_at
FROM orders o
WHERE o.status IN ('paid','shipped','delivered');


-- ---------------------------------------------------------
-- 2️⃣ BUG #1 — DUPLICATE APPROVED PAYMENTS
--
-- Bug description:
-- Some orders will end up with MORE THAN ONE approved payment.
--
-- Why this is critical:
-- - Double charge to customer
-- - Financial bug (P0 severity)
--
-- QA interview value:
-- Classic "find duplicate payments" question.
-- ---------------------------------------------------------
INSERT INTO payments (order_id, amount, method, status, paid_at, created_at)
SELECT
  p.order_id,
  p.amount,
  p.method,
  'approved',        -- Duplicate approved payment
  NOW(),
  NOW()
FROM payments p
ORDER BY random()
LIMIT 2;             -- Only 2 orders affected (controlled bug)


-- ---------------------------------------------------------
-- 3️⃣ BUG #2 — APPROVED PAYMENT WITH ZERO AMOUNT
--
-- Bug description:
-- An approved payment with amount = 0.00
--
-- Why this is wrong:
-- - Approved payments should NEVER be zero
-- - Indicates billing or backend calculation error
--
-- QA interview value:
-- Very common data validation question.
-- ---------------------------------------------------------
INSERT INTO payments (order_id, amount, method, status, paid_at, created_at)
SELECT
  o.id,
  0.00,              -- ❌ Invalid amount
  'card',
  'approved',
  NOW(),
  NOW()
FROM orders o
ORDER BY random()
LIMIT 1;             -- Single edge-case bug
