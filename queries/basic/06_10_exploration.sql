/*
========================================================
BASIC 6–10: Simple WHERE Filters
========================================================

Purpose:
These queries focus on applying simple WHERE filters
to validate business rules and detect obvious data issues.

They help identify:
- Financial inconsistencies
- Invalid process states
- Security and login anomalies

Tables involved:
- orders
- payments
- shipments
- login_events

========================================================
*/

--------------------------------------------------------
-- BASIC 6
-- Orders with total_amount = 0
-- Validates:
-- - Orders that should not exist or are incomplete
-- - Pricing or calculation issues
--------------------------------------------------------

-- QUERY 6
select id, user_id, status, total_amount, created_at
from orders
where total_amount = 0
order by user_id

--------------------------------------------------------
-- BASIC 7
-- Approved payments
-- Validates:
-- - Successful payment transactions
--------------------------------------------------------

-- QUERY 7
select id, order_id, amount, method, status, paid_at, created_at
from payments
where status = 'approved'
order by id


--------------------------------------------------------
-- BASIC 8
-- Payments with amount = 0
-- Validates:
-- - Invalid or suspicious payment records
--------------------------------------------------------

-- QUERY 8
select id, order_id, amount, method, status, paid_at, created_at
from payments
where amount = 0
order by id

--------------------------------------------------------
-- BASIC 9
-- Delivered shipments
-- Validates:
-- - Completed delivery records
--------------------------------------------------------

-- QUERY 9
select id, order_id, carrier, tracking_number, status, shipped_at, delivered_at, created_at
from shipments
where status = 'delivered'
order by id

--------------------------------------------------------
-- BASIC 10
-- Successful login events
-- Validates:
-- - Authentication flow correctness
--------------------------------------------------------

-- QUERY 10
select id, user_id, event_type, ip_address, user_agent, created_at
from login_events
where event_type in ('success', 'login_success')
order by user_id, created_at desc