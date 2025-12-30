-- seeds/02_products.sql
-- Insert 60 products (55 active, 5 inactive)

INSERT INTO products (sku, name, price, is_active) VALUES
-- Active products
('SKU-001','Wireless Mouse', 399.00, TRUE),
('SKU-002','Mechanical Keyboard', 1299.00, TRUE),
('SKU-003','USB-C Cable', 149.00, TRUE),
('SKU-004','Laptop Stand', 599.00, TRUE),
('SKU-005','27-inch Monitor', 5499.00, TRUE),
('SKU-006','Webcam HD', 899.00, TRUE),
('SKU-007','Noise Cancelling Headphones', 2499.00, TRUE),
('SKU-008','Bluetooth Speaker', 1199.00, TRUE),
('SKU-009','External SSD 1TB', 2999.00, TRUE),
('SKU-010','Gaming Mouse Pad', 299.00, TRUE),

('SKU-011','USB Hub 4 Ports', 349.00, TRUE),
('SKU-012','Ergonomic Chair', 6999.00, TRUE),
('SKU-013','Desk Lamp LED', 499.00, TRUE),
('SKU-014','Smartwatch', 3499.00, TRUE),
('SKU-015','Wireless Charger', 799.00, TRUE),
('SKU-016','Power Bank 20000mAh', 999.00, TRUE),
('SKU-017','Ethernet Cable', 99.00, TRUE),
('SKU-018','Microphone USB', 1599.00, TRUE),
('SKU-019','Webcam 4K', 2499.00, TRUE),
('SKU-020','Laptop Backpack', 899.00, TRUE),

('SKU-021','Tablet 10 inch', 4999.00, TRUE),
('SKU-022','Stylus Pen', 399.00, TRUE),
('SKU-023','Portable Projector', 7999.00, TRUE),
('SKU-024','Smart Plug', 299.00, TRUE),
('SKU-025','WiFi Router', 1899.00, TRUE),
('SKU-026','Gaming Keyboard RGB', 1799.00, TRUE),
('SKU-027','USB Flash Drive 128GB', 249.00, TRUE),
('SKU-028','Cooling Pad Laptop', 549.00, TRUE),
('SKU-029','Desk Organizer', 199.00, TRUE),
('SKU-030','Mechanical Pencil', 59.00, TRUE),

('SKU-031','Office Desk', 4599.00, TRUE),
('SKU-032','Monitor Arm', 1399.00, TRUE),
('SKU-033','Wireless Earbuds', 1999.00, TRUE),
('SKU-034','Smart Light Bulb', 249.00, TRUE),
('SKU-035','Graphic Tablet', 3299.00, TRUE),
('SKU-036','Surge Protector', 349.00, TRUE),
('SKU-037','HDMI Cable', 129.00, TRUE),
('SKU-038','USB-C to HDMI Adapter', 499.00, TRUE),
('SKU-039','NAS Storage 4TB', 8999.00, TRUE),
('SKU-040','Mini PC', 10999.00, TRUE),

('SKU-041','Laptop Sleeve', 399.00, TRUE),
('SKU-042','Wireless Presenter', 699.00, TRUE),
('SKU-043','Security Camera', 1799.00, TRUE),
('SKU-044','VR Headset', 11999.00, TRUE),
('SKU-045','Smart Door Lock', 6499.00, TRUE),
('SKU-046','Standing Desk Converter', 3799.00, TRUE),
('SKU-047','USB Desk Fan', 229.00, TRUE),
('SKU-048','Cable Management Box', 349.00, TRUE),
('SKU-049','Laptop Docking Station', 3299.00, TRUE),
('SKU-050','Wireless Numeric Keypad', 699.00, TRUE),

('SKU-051','Conference Speakerphone', 4599.00, TRUE),
('SKU-052','Screen Cleaning Kit', 149.00, TRUE),
('SKU-053','Fingerprint Reader', 899.00, TRUE),
('SKU-054','Industrial Barcode Scanner', 15999.00, TRUE), -- high price edge case
('SKU-055','Basic USB Cable', 29.00, TRUE), -- low price edge case

-- Inactive products
('SKU-056','Old Model Webcam', 799.00, FALSE),
('SKU-057','Legacy Keyboard', 999.00, FALSE),
('SKU-058','Discontinued Mouse', 299.00, FALSE),
('SKU-059','Outdated Router', 1499.00, FALSE),
('SKU-060','Old Headset', 899.00, FALSE);
