-- 02_business_tables.sql
-- Business tables for QA SQL practice

CREATE TABLE IF NOT EXISTS products (
  id         BIGSERIAL PRIMARY KEY,
  sku        VARCHAR(50) NOT NULL UNIQUE,
  name       VARCHAR(150) NOT NULL,
  price      NUMERIC(10,2) NOT NULL CHECK (price >= 0),
  is_active  BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS orders (
  id           BIGSERIAL PRIMARY KEY,
  user_id      BIGINT NOT NULL REFERENCES users(id),
  status       VARCHAR(20) NOT NULL DEFAULT 'created', -- created, paid, shipped, delivered, canceled
  total_amount NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0),
  created_at   TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS order_items (
  id         BIGSERIAL PRIMARY KEY,
  order_id   BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  product_id BIGINT NOT NULL REFERENCES products(id),
  qty        INT NOT NULL CHECK (qty > 0),
  unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0)
);

CREATE TABLE IF NOT EXISTS payments (
  id           BIGSERIAL PRIMARY KEY,
  order_id     BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  amount       NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
  method       VARCHAR(20) NOT NULL DEFAULT 'card',   -- card, paypal, cash, transfer
  status       VARCHAR(20) NOT NULL DEFAULT 'pending', -- pending, approved, declined, refunded
  paid_at      TIMESTAMP NULL,
  created_at   TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_payments_order_id ON payments(order_id);
