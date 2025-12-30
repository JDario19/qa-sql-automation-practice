-- =========================================================
-- seeds/07_login_events.sql
-- Login events seed data for QA SQL practice
--
-- Inserts normal login activity plus intentional security bug:
-- blocked users with login_success events.
-- =========================================================


-- ---------------------------------------------------------
-- 1️⃣ NORMAL CASE — Mix of login_success / login_failed
-- for random users (realistic activity).
-- ---------------------------------------------------------
INSERT INTO login_events (user_id, event_type, ip_address, user_agent, created_at)
SELECT
  u.id AS user_id,
  CASE
    WHEN random() < 0.70 THEN 'login_success'
    ELSE 'login_failed'
  END AS event_type,
  -- random-ish private IPv4 patterns
  (10 + (random() * 200)::int)::text || '.' ||
  (1 + (random() * 250)::int)::text  || '.' ||
  (1 + (random() * 250)::int)::text  || '.' ||
  (1 + (random() * 250)::int)::text  AS ip_address,
  CASE
    WHEN random() < 0.33 THEN 'Chrome on macOS'
    WHEN random() < 0.66 THEN 'Safari on iOS'
    ELSE 'Firefox on Windows'
  END AS user_agent,
  NOW() - INTERVAL '1 hour' * (1 + (random() * 240)::int) AS created_at
FROM users u
ORDER BY random()
LIMIT 220;  -- robust dataset


-- ---------------------------------------------------------
-- 2️⃣ BUG (SECURITY) — BLOCKED USERS WITH login_success
--
-- Bug description:
-- blocked users should NOT be able to login successfully.
-- ---------------------------------------------------------
INSERT INTO login_events (user_id, event_type, ip_address, user_agent, created_at)
SELECT
  u.id,
  'login_success',
  '203.0.113.' || (1 + (random() * 200)::int)::text,   -- sample public range format
  'Chrome on macOS',
  NOW() - INTERVAL '1 hour' * (1 + (random() * 48)::int)
FROM users u
WHERE u.status = 'blocked'
ORDER BY random()
LIMIT 3;
