/*
========================================================
INTERMEDIATE 1–5: Business JOINs (Core Relationships)
========================================================

Purpose:
These queries focus on business-level JOINs across
core e-commerce entities.

The goal is to:
- Combine related data across tables
- Validate real business flows
- Provide meaningful information for debugging,
  reporting, and analysis

This level goes beyond basic integrity checks and
demonstrates understanding of how the system works
as a whole.

Tables involved:
- users
- orders
- order_items
- payments
- shipments
- login_events

========================================================
*/

--------------------------------------------------------
-- INTERMEDIATE 1
-- Orders with user email
-- Purpose:
-- - Show who created each order
-- - Enable audit and debugging by user
-- Validates:
-- - Orders are correctly linked to users
-- - User information is available for each order
-- Notes:
-- - INNER JOIN is used because an order must have a user
-- QUERY 1
select distinct
	orders.id,
	orders.user_id,
	orders.status,
	orders.total_amount,
	orders.created_at,
	users.email
from orders
inner join users
	on users.id = orders.user_id
order by orders.created_at desc


--------------------------------------------------------
-- INTERMEDIATE 2
-- Orders with number of items
-- Purpose:
-- - Show how many items each order contains
-- - Identify large or suspicious orders
-- Validates:
-- - Orders are properly linked to order_items
-- - Item counts make sense for each order
-- Notes:
-- - GROUP BY is required
-- - COUNT(order_items.id) is expected
-- QUERY 2
select
	orders.id,
	orders.user_id,
	orders.status,
	orders.total_amount,
	orders.created_at,
	count(order_items.id) as items_count
from orders
	inner join order_items
	on orders.id = order_items.id
group by 
	orders.id,
	orders.user_id,
	orders.status,
	orders.total_amount,
	orders.created_at
order by items_count desc


--------------------------------------------------------
-- INTERMEDIATE 3
-- Payments with order status
-- Purpose:
-- - Correlate payment state with order lifecycle
-- - Detect inconsistencies between payments and orders
-- Validates:
-- - Payments are linked to existing orders
-- - Order status matches payment status expectations
-- Notes:
-- - INNER JOIN between payments and orders
-- QUERY 3
select
	payments.id,
	payments.order_id,
	payments.amount,
	payments.method,
	payments.status,
	payments.paid_at,
	payments.created_at,
	orders.status
from payments
	inner join orders
	on orders.id = payments.order_id
order by payments.created_at desc



--------------------------------------------------------
-- INTERMEDIATE 4
-- Shipments with user information
-- Purpose:
-- - Track shipments back to the user
-- - Support customer support and logistics analysis
-- Validates:
-- - Shipments are linked to orders
-- - Orders are linked to users
-- Notes:
-- - Multiple JOINs required (shipments → orders → users)
-- QUERY 4
select
	shipments.id,
	shipments.order_id,
	shipments.carrier,
	shipments.tracking_number,
	shipments.status,
	shipments.shipped_at,
	shipments.delivered_at,
	shipments.created_at,
	orders.id,
	users.id,
	users.email,
	users.full_name
from shipments
	inner join orders on shipments.order_id = orders.id
	inner join users on orders.user_id = users.id
order by shipments.created_at desc


--------------------------------------------------------
-- INTERMEDIATE 5
-- Login events with user status
-- Purpose:
-- - Correlate authentication activity with user state
-- - Detect suspicious or invalid behavior
-- Validates:
-- - Login events are linked to users
-- - User status is correctly enforced
-- Notes:
-- - INNER JOIN between login_events and users
-- QUERY 5
select
	login_events.id,
	login_events.user_id,
	login_events.event_type,
	login_events.ip_address,
	login_events.user_agent,
	login_events.created_at,
	users.status,
	users.email,
	users.full_name
from login_events
	inner join users
	on login_events.user_id = users.id
order by login_events.created_at desc


--------------------------------------------------------
-- END OF INTERMEDIATE — BLOCK 1 (JOINs)
--------------------------------------------------------
