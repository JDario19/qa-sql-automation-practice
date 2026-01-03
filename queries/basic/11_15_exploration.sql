/*
========================================================
BASIC 11–15: Basic Health Checks (Data Integrity)
========================================================

Purpose:
These queries are basic integrity checks to detect
common issues found in e-commerce systems.

They help identify:
- Orphan records / missing relationships
- Invalid business states
- Security inconsistencies

Tables involved:
- users
- orders
- order_items
- products
- shipments
- login_events
- payments

========================================================
*/

--------------------------------------------------------
-- BASIC 11.1 (JOIN / INNER JOIN)
-- Orders WITH items (baseline reference)
-- Purpose:
-- - Confirm which orders are properly linked to order_items
-- - Understand the relationship orders (1) -> order_items (many)
-- Validates:
-- - Orders that have at least one item
-- Notes:
-- - INNER JOIN will exclude orders that have no matching items
-- - DISTINCT is used to avoid duplicated orders (1-to-many relationship)
-- QUERY 11.1
select distinct
    orders.id,
    orders.user_id,
    orders.status,
    orders.total_amount,
    orders.created_at
from orders
inner join order_items
    on orders.id = order_items.order_id
order by orders.id;


--------------------------------------------------------
-- BASIC 11.1A (JOIN PRACTICE)
-- Users + Orders (join practice with your schema)
-- Purpose:
-- - Practice joining parent (users) with child (orders)
-- Validates:
-- - Orders are linked to an existing user
-- QUERY 11.1A
select
    users.id,
    users.email,
    users.full_name,
    users.status,
    users.created_at,
    orders.status
from users
inner join orders
    on users.id = orders.user_id
order by users.id asc;


--------------------------------------------------------
-- BASIC 11.1B (JOIN PRACTICE)
-- Orders + Payments (join practice with your schema)
-- Purpose:
-- - Practice joining orders with related payments
-- Validates:
-- - Payments are linked to an existing order
-- QUERY 11.1B
select 
    orders.id,
    orders.user_id,
    orders.status,
    orders.total_amount,
    payments.amount
from orders
inner join payments
    on orders.id = payments.order_id
order by orders.id asc;


--------------------------------------------------------
-- BASIC 11.2 (LEFT JOIN)
-- Orders WITHOUT items (health check)
-- Purpose:
-- - Detect orphan orders (created but with no order_items)
-- Validates:
-- - Potential checkout/cart issues
-- - Data integrity problems (orders that should not exist as empty)
-- Notes:
-- - LEFT JOIN keeps all orders and marks missing matches as NULL
-- - Filter for NULL to get orders without items
-- QUERY 11.2
select distinct
    orders.id,
    orders.user_id,
    orders.status,
    orders.total_amount,
    orders.created_at
from orders
left join order_items
    on orders.id = order_items.order_id
where order_items.order_id is null
order by orders.id;


--------------------------------------------------------
-- BASIC 12
-- Users without orders
-- Validates:
-- - Users that never purchased (possible funnel issues)
-- - Seed coverage for user/order relationships
-- QUERY 12
select
	users.id,
	users.email,
	users.full_name,
	users.status,
	users.created_at
from users
left join orders
	on users.id = orders.user_id
where orders.user_id is null

--------------------------------------------------------
-- BASIC 13
-- Inactive products used in orders
-- Validates:
-- - Catalog integrity (inactive products should not be purchased)
-- - Missing validations in backend business rules
-- QUERY 13
select distinct
	products.id,
	products.sku,
	products.name,
	products.price,
	products.is_active,
	products.created_at
from products
inner join order_items
	on products.id = order_items.product_id
where is_active = false

--------------------------------------------------------
-- BASIC 14
-- Orders shipped/delivered without a shipment record
-- Validates:
-- - Logistics integrity (order status vs shipments table)
-- - Invalid state transitions in order processing
-- QUERY 14
select
	orders.id,
	orders.user_id,
	orders.status,
	orders.total_amount,
	orders.created_at,
	shipments.order_id
from orders
left join shipments
	on orders.id = shipments.order_id
where shipments.order_id is null 
	and orders.status in('shipped','delivered')
order by orders.id 

--------------------------------------------------------
-- BASIC 15
-- Blocked users with successful login events
-- Validates:
-- - Security consistency (blocked users should not successfully log in)
-- - Missing enforcement in authentication/authorization layer
-- QUERY 15
select
	users.id,
	users.email,
	users.full_name,
	users.status,
	users.created_at,
	login_events.user_id,
	login_events.event_type
from users
inner join login_events
	on users.id = login_events.user_id
where users.status = 'blocked'
and login_events.event_type in ('success','login_success')
order by users.id