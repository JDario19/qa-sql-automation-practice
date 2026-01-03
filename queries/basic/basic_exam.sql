/*
========================================================
BASIC SQL EXAM — QA Automation Practice
========================================================

Purpose:
This file contains a condensed SQL exam covering
BASIC queries (1–15) for QA Automation interviews.

The goal is to validate:
- Data exploration
- JOIN vs LEFT JOIN usage
- Detection of orphan records
- Business rule violations
- Security inconsistencies

Tables involved:
- users
- orders
- order_items
- products
- login_events

========================================================
*/


--------------------------------------------------------
-- 🧪 EXERCISE 1
-- Orders with total_amount = 0
-- Validates:
-- - Orders created without items
-- - Calculation or checkout bugs
--------------------------------------------------------

select
    orders.id,
    orders.user_id,
    orders.status,
    orders.total_amount,
    orders.created_at
from orders
where orders.total_amount = 0
order by orders.id;


--------------------------------------------------------
-- 🧪 EXERCISE 2
-- Orders that DO have items
-- Validates:
-- - Correct relationship between orders and order_items
-- - Orders properly created with at least one item
-- Notes:
-- - INNER JOIN ensures the order has items
-- - DISTINCT avoids duplicates (1 order -> many items)
--------------------------------------------------------

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
-- 🧪 EXERCISE 3
-- Users WITHOUT orders
-- Validates:
-- - Users that never completed a purchase
-- - Funnel or data seeding issues
-- Notes:
-- - LEFT JOIN keeps all users
-- - NULL filter detects missing relationships
--------------------------------------------------------

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
order by users.id;


--------------------------------------------------------
-- 🧪 EXERCISE 4
-- Inactive products used in orders
-- Validates:
-- - Business rule violations
-- - Missing validations in the purchase flow
-- Notes:
-- - INNER JOIN confirms the product was used
-- - DISTINCT avoids duplicates across multiple orders
--------------------------------------------------------

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
where products.is_active = false
order by products.id;


--------------------------------------------------------
-- 🧪 EXERCISE 5
-- Blocked users with successful login events
-- Validates:
-- - Security enforcement issues
-- - Authentication / authorization inconsistencies
-- Notes:
-- - INNER JOIN ensures the login event exists
-- - Event type defines successful login
--------------------------------------------------------

select distinct
    users.id,
    users.email,
    users.full_name,
    users.status,
    users.created_at
from users
inner join login_events
    on users.id = login_events.user_id
where users.status = 'blocked'
  and login_events.event_type in ('success', 'login_success')
order by users.id;


--------------------------------------------------------
-- END OF BASIC SQL EXAM
--------------------------------------------------------
