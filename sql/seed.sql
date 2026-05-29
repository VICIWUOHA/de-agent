-- =============================================================
-- DE Agent — Sample Schema + Dummy Data
-- Run via: run_query (not run_select_query — this is DDL/DML)
-- =============================================================

-- ---------------------------------------------------------------
-- DATABASES
-- ---------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS analytics;
CREATE DATABASE IF NOT EXISTS product_events;
CREATE DATABASE IF NOT EXISTS user_metrics;


-- ===============================================================
-- analytics
-- ===============================================================

CREATE TABLE IF NOT EXISTS analytics.page_views (
    event_date      Date,
    event_time      DateTime,
    user_id         UInt64,
    session_id      String,
    page_url        String,
    referrer        String,
    device_type     LowCardinality(String),
    country         LowCardinality(String),
    duration_seconds UInt32
) ENGINE = MergeTree()
ORDER BY (event_date, user_id);

INSERT INTO analytics.page_views VALUES
('2025-05-01', '2025-05-01 08:01:00', 101, 'sess_a1', '/home',        '',                    'desktop', 'NG', 45),
('2025-05-01', '2025-05-01 08:03:00', 101, 'sess_a1', '/pricing',     '/home',               'desktop', 'NG', 120),
('2025-05-01', '2025-05-01 09:15:00', 102, 'sess_b2', '/home',        'https://google.com',  'mobile',  'GH', 30),
('2025-05-01', '2025-05-01 09:18:00', 102, 'sess_b2', '/features',    '/home',               'mobile',  'GH', 200),
('2025-05-02', '2025-05-02 10:00:00', 103, 'sess_c3', '/home',        '',                    'tablet',  'KE', 60),
('2025-05-02', '2025-05-02 10:05:00', 103, 'sess_c3', '/blog/intro',  '/home',               'tablet',  'KE', 340),
('2025-05-02', '2025-05-02 14:22:00', 104, 'sess_d4', '/pricing',     'https://twitter.com', 'desktop', 'ZA', 90),
('2025-05-03', '2025-05-03 07:45:00', 105, 'sess_e5', '/home',        '',                    'desktop', 'NG', 25),
('2025-05-03', '2025-05-03 07:47:00', 105, 'sess_e5', '/dashboard',   '/home',               'desktop', 'NG', 180),
('2025-05-03', '2025-05-03 11:30:00', 106, 'sess_f6', '/home',        'https://linkedin.com','mobile',  'US', 55),
('2025-05-04', '2025-05-04 09:00:00', 107, 'sess_g7', '/blog/intro',  '',                    'desktop', 'GB', 420),
('2025-05-04', '2025-05-04 16:10:00', 108, 'sess_h8', '/pricing',     '/blog/intro',         'mobile',  'CA', 75),
('2025-05-05', '2025-05-05 13:00:00', 109, 'sess_i9', '/home',        '',                    'desktop', 'NG', 40),
('2025-05-05', '2025-05-05 13:02:00', 109, 'sess_i9', '/features',    '/home',               'desktop', 'NG', 310);


CREATE TABLE IF NOT EXISTS analytics.conversions (
    event_date      Date,
    event_time      DateTime,
    user_id         UInt64,
    conversion_type LowCardinality(String),   -- signup | upgrade | purchase
    plan            LowCardinality(String),
    revenue_usd     Float64,
    campaign_id     String
) ENGINE = MergeTree()
ORDER BY (event_date, user_id);

INSERT INTO analytics.conversions VALUES
('2025-05-01', '2025-05-01 08:10:00', 101, 'signup',   'free',    0.00,  'organic'),
('2025-05-01', '2025-05-01 09:20:00', 102, 'signup',   'free',    0.00,  'google_cpc'),
('2025-05-02', '2025-05-02 10:10:00', 103, 'signup',   'pro',     49.00, 'organic'),
('2025-05-02', '2025-05-02 14:30:00', 104, 'upgrade',  'pro',     49.00, 'twitter'),
('2025-05-03', '2025-05-03 07:50:00', 105, 'signup',   'free',    0.00,  'organic'),
('2025-05-04', '2025-05-04 09:30:00', 107, 'purchase', 'pro',     49.00, 'linkedin'),
('2025-05-05', '2025-05-05 13:05:00', 109, 'upgrade',  'enterprise', 199.00, 'organic');


-- ===============================================================
-- product_events
-- ===============================================================

CREATE TABLE IF NOT EXISTS product_events.events (
    event_date   Date,
    event_time   DateTime,
    user_id      UInt64,
    event_name   LowCardinality(String),
    feature      LowCardinality(String),
    session_id   String,
    properties   String    -- JSON string
) ENGINE = MergeTree()
ORDER BY (event_date, event_time, user_id);

INSERT INTO product_events.events VALUES
('2025-05-01', '2025-05-01 08:12:00', 101, 'feature_viewed',  'dashboard',    'sess_a1', '{"source":"nav"}'),
('2025-05-01', '2025-05-01 08:14:00', 101, 'button_clicked',  'export_csv',   'sess_a1', '{"format":"csv"}'),
('2025-05-01', '2025-05-01 09:22:00', 102, 'feature_viewed',  'dashboard',    'sess_b2', '{"source":"nav"}'),
('2025-05-02', '2025-05-02 10:08:00', 103, 'feature_viewed',  'reports',      'sess_c3', '{"source":"sidebar"}'),
('2025-05-02', '2025-05-02 10:12:00', 103, 'report_created',  'reports',      'sess_c3', '{"type":"weekly"}'),
('2025-05-02', '2025-05-02 14:25:00', 104, 'feature_viewed',  'dashboard',    'sess_d4', '{"source":"nav"}'),
('2025-05-02', '2025-05-02 14:28:00', 104, 'button_clicked',  'invite_user',  'sess_d4', '{}'),
('2025-05-03', '2025-05-03 07:52:00', 105, 'feature_viewed',  'dashboard',    'sess_e5', '{"source":"nav"}'),
('2025-05-03', '2025-05-03 07:55:00', 105, 'feature_viewed',  'settings',     'sess_e5', '{"source":"avatar"}'),
('2025-05-04', '2025-05-04 09:10:00', 107, 'feature_viewed',  'reports',      'sess_g7', '{"source":"sidebar"}'),
('2025-05-04', '2025-05-04 09:15:00', 107, 'report_created',  'reports',      'sess_g7', '{"type":"daily"}'),
('2025-05-04', '2025-05-04 16:12:00', 108, 'feature_viewed',  'dashboard',    'sess_h8', '{"source":"nav"}'),
('2025-05-05', '2025-05-05 13:03:00', 109, 'feature_viewed',  'dashboard',    'sess_i9', '{"source":"nav"}'),
('2025-05-05', '2025-05-05 13:08:00', 109, 'button_clicked',  'export_csv',   'sess_i9', '{"format":"xlsx"}');


CREATE TABLE IF NOT EXISTS product_events.feature_usage_daily (
    event_date  Date,
    feature     LowCardinality(String),
    unique_users UInt64,
    total_events UInt64
) ENGINE = MergeTree()
ORDER BY (event_date, feature);

INSERT INTO product_events.feature_usage_daily VALUES
('2025-05-01', 'dashboard',   2, 3),
('2025-05-01', 'export_csv',  1, 1),
('2025-05-02', 'dashboard',   2, 2),
('2025-05-02', 'reports',     1, 2),
('2025-05-02', 'invite_user', 1, 1),
('2025-05-03', 'dashboard',   1, 1),
('2025-05-03', 'settings',    1, 1),
('2025-05-04', 'reports',     1, 2),
('2025-05-04', 'dashboard',   1, 1),
('2025-05-05', 'dashboard',   1, 1),
('2025-05-05', 'export_csv',  1, 1);


-- ===============================================================
-- user_metrics
-- ===============================================================

CREATE TABLE IF NOT EXISTS user_metrics.users (
    user_id     UInt64,
    email       String,
    signup_date Date,
    plan        LowCardinality(String),   -- free | pro | enterprise
    country     LowCardinality(String),
    is_active   UInt8
) ENGINE = MergeTree()
ORDER BY user_id;

INSERT INTO user_metrics.users VALUES
(101, 'ada@example.com',     '2025-05-01', 'free',       'NG', 1),
(102, 'ben@example.com',     '2025-05-01', 'free',       'GH', 1),
(103, 'chi@example.com',     '2025-05-02', 'pro',        'KE', 1),
(104, 'dan@example.com',     '2025-05-02', 'pro',        'ZA', 1),
(105, 'eve@example.com',     '2025-05-03', 'free',       'NG', 1),
(106, 'frank@example.com',   '2025-05-03', 'free',       'US', 0),
(107, 'grace@example.com',   '2025-05-04', 'pro',        'GB', 1),
(108, 'hank@example.com',    '2025-05-04', 'free',       'CA', 1),
(109, 'iris@example.com',    '2025-05-05', 'enterprise', 'NG', 1);


CREATE TABLE IF NOT EXISTS user_metrics.daily_signups (
    event_date   Date,
    plan         LowCardinality(String),
    signups      UInt64,
    revenue_usd  Float64
) ENGINE = MergeTree()
ORDER BY (event_date, plan);

INSERT INTO user_metrics.daily_signups VALUES
('2025-05-01', 'free',       2,  0.00),
('2025-05-02', 'pro',        1, 49.00),
('2025-05-02', 'free',       0,  0.00),
('2025-05-03', 'free',       1,  0.00),
('2025-05-04', 'pro',        1, 49.00),
('2025-05-04', 'free',       1,  0.00),
('2025-05-05', 'enterprise', 1, 199.00);


CREATE TABLE IF NOT EXISTS user_metrics.retention (
    cohort_date  Date,
    day_number   UInt16,   -- days since signup
    cohort_size  UInt64,
    retained     UInt64
) ENGINE = MergeTree()
ORDER BY (cohort_date, day_number);

INSERT INTO user_metrics.retention VALUES
('2025-05-01', 0,  2, 2),
('2025-05-01', 1,  2, 2),
('2025-05-01', 2,  2, 1),
('2025-05-01', 3,  2, 1),
('2025-05-02', 0,  2, 2),
('2025-05-02', 1,  2, 2),
('2025-05-02', 2,  2, 1),
('2025-05-03', 0,  2, 2),
('2025-05-03', 1,  2, 2);
