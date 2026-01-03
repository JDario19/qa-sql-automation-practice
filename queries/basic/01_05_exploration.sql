/*
========================================================
BASIC 1–5: Data Exploration Queries
========================================================

Purpose:
These queries are used for initial data exploration and
basic validation of the database.

They help verify:
- Seed data correctness
- Basic business states
- Obvious inconsistencies

Tables involved:
- users
- products
- orders

========================================================
*/

--------------------------------------------------------
-- BASIC 1
-- List all users ordered by creation date (newest first)
-- Validates:
-- - User creation tracking
-- - created_at consistency
-- QUERY 1
select id, email, full_name, status, created_at 
from users
order by created_at desc

--------------------------------------------------------
-- BASIC 2
-- Count users by status
-- Validates:
-- - Distribution of user states
-- - Presence of blocked/inactive users
-- QUERY 2
select status, count(*) as total
from users
group by status
order by total desc

--------------------------------------------------------
-- BASIC 3
-- List active products
-- Validates:
-- - Active catalog availability
-- QUERY 3
select id, sku, name, price, is_active, created_at
from products
where is_active = true

--------------------------------------------------------
-- BASIC 4
-- List inactive products
-- Validates:
-- - Deprecated or disabled catalog items
-- QUERY 4
select id, sku, name, price, is_active, created_at
from products
where is_active = false

--------------------------------------------------------
-- BASIC 5
-- List orders by status
-- Validates:
-- - Order lifecycle states
-- QUERY 5
select id, user_id, status, total_amount, created_at
from orders
order by status