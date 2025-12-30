# QA SQL Automation Practice

This repository is a **complete, self-contained QA-oriented SQL project** designed to simulate a **real production e-commerce database**, including **intentional data bugs** to practice **real-world SQL validations** for **QA Automation / SDET roles**.

The project runs **locally using PostgreSQL + Docker**, is fully versioned in GitHub, and is structured to be **portfolio-ready**.

---

## 🧠 Database Model Explanation (QA-Oriented)

This database models a **realistic e-commerce system** built specifically for **QA / SDET SQL practice**.

The dataset intentionally contains **both valid and invalid records**, allowing you to practice detecting **business, financial, and security issues** using SQL — exactly the type of problems QA engineers face in production systems.

---

## 🗺️ High-Level System Overview

Relational structure:

USERS  
└── ORDERS  
&nbsp;&nbsp;&nbsp;&nbsp;└── ORDER_ITEMS  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── PRODUCTS  
&nbsp;&nbsp;&nbsp;&nbsp;└── PAYMENTS  
&nbsp;&nbsp;&nbsp;&nbsp;└── SHIPMENTS  

USERS  
└── LOGIN_EVENTS  

Each table represents a real business concept and is connected using **primary keys, foreign keys, and constraints**.

---

## 📦 Tables Overview

### 1️⃣ `users`
Represents system users (customers).

Key fields:
- `id` – primary identifier
- `email` – unique
- `status` – `active`, `inactive`, `blocked`

Seeded data:
- ~57 users
- Mix of active, inactive, and blocked users

QA relevance:
- Blocked users should NOT place orders or log in
- Violations represent **business rule or security bugs**

---

### 2️⃣ `products`
Represents the product catalog.

Key fields:
- `sku` – unique product identifier
- `price` – product price
- `is_active` – availability flag

Seeded data:
- 60 products total
- 55 active
- 5 inactive
- Includes very high and very low price edge cases

QA relevance:
- Inactive products being sold
- Price validation
- SKU uniqueness enforced via constraint

---

### 3️⃣ `orders`
Represents a purchase made by a user.

Key fields:
- `user_id`
- `status` – `created`, `paid`, `shipped`, `delivered`, `cancelled`
- `total_amount`

Seeded data:
- ~80 orders
- Orders created by multiple users
- Includes intentional edge cases:
  - Orders with `total_amount = 0`
  - Orders created by blocked users

QA relevance:
- Orders without items
- Incorrect totals
- Invalid user behavior

---

### 4️⃣ `order_items`
Represents line items inside an order.

Key fields:
- `order_id`
- `product_id`
- `qty`
- `unit_price`

Seeded data:
- Automatically generated
- Multiple items per order
- Uses active products

QA relevance:
- Allows recalculating real order totals
- Detects financial inconsistencies
- Identifies empty orders

---

### 5️⃣ `payments`
Represents payment transactions.

Key fields:
- `order_id`
- `amount`
- `method`
- `status` – `approved`
- `paid_at`

Seeded data includes **intentional bugs**:
- Duplicate approved payments for the same order (double charge)
- Approved payment with `amount = 0`

QA relevance:
- Financial P0 issues
- Billing validation
- Payment/order mismatches

---

### 6️⃣ `shipments`
Represents order shipments.

Key fields:
- `order_id`
- `carrier`
- `tracking_number`
- `status` – `shipped`, `delivered`
- `shipped_at`, `delivered_at`

Seeded data includes **intentional bugs**:
- Orders marked as shipped without a shipment
- Shipments marked as delivered with `delivered_at = NULL`

QA relevance:
- Logistics inconsistencies
- Backend/fulfillment desync

---

### 7️⃣ `login_events`
Represents authentication events (audit & security).

Key fields:
- `user_id`
- `event_type` – `login_success`, `login_failed`
- `ip_address`
- `user_agent`
- `created_at`

Seeded data:
- ~220 login events
- Includes **blocked users with login_success** (security bug)

QA relevance:
- Security validation
- Audit trail checks
- Compliance scenarios

---

## 🧪 Seed Data Philosophy

The seed data intentionally includes **real production-like bugs**, such as:
- Orders without items
- Orders with incorrect totals
- Duplicate approved payments
- Approved payments with zero amount
- Shipped orders without shipments
- Delivered shipments without delivery timestamp
- Blocked users logging in successfully
- Blocked users placing orders

This allows practicing **real QA SQL validations**, not just reporting queries.

---

## 🎯 QA Focus of This Project

This project uses SQL as a **QA validation tool** to detect:
- Business rule violations
- Data integrity issues
- Financial inconsistencies
- Security vulnerabilities
- Backend defects after UI/API flows

---

## 🧪 Queries Structure

Queries are organized by difficulty and QA maturity:

└── queries/
    ├── basic/
    ├── intermediate/
    └── advanced/

---


Each folder contains **15+ interview-style queries**.

---

## 🎯 Purpose

- Practice SQL using a real database
- Run PostgreSQL locally with Docker
- Use pgAdmin as a professional DB UI
- Version schemas, seeds, and queries in GitHub
- Prepare a portfolio-ready QA SQL project

---

## 🧰 Technologies

- PostgreSQL 16
- pgAdmin 4
- Docker Desktop (macOS)
- SQL
- Git & GitHub
- Visual Studio Code

---

## 📁 Project Structure

qa-sql-automation-practice/
├── docker-compose.yml
├── README.md
├── schema/
│ └── 01_create_tables.sql
├── seeds/
│ ├── 01_users.sql
│ ├── 02_products.sql
│ ├── 03_orders.sql
│ ├── 04_order_items.sql
│ ├── 05_payments.sql
│ ├── 06_shipments.sql
│ └── 07_login_events.sql
└── queries/
├── basic/
├── intermediate/
└── advanced/


---

## 🚀 How to Use This Repository

Two setup flows are provided:

### A) From scratch (no Docker / DB installed)
1. Install Docker Desktop (macOS)
2. Start Docker and verify with `docker --version`
3. Run `docker compose up -d`
4. Open pgAdmin at http://localhost:5050
5. Register PostgreSQL server (`postgres`, `qa_practice`)
6. Run schema SQL
7. Run seeds in order (`seeds/01_...` → `seeds/07_...`)
8. Execute queries for practice

### B) Quick setup (repo already cloned)
1. `git clone`
2. `docker compose up -d`
3. Open pgAdmin
4. Run schema and seeds
5. Practice queries

---

## 💼 CV / Interview Value

You can confidently say:

> “I designed and populated a Dockerized PostgreSQL database simulating a real e-commerce system, including intentional business, financial, and security bugs, and created SQL queries to detect production-grade issues as a QA engineer.”

This is **real QA work**, not tutorial SQL.

---

