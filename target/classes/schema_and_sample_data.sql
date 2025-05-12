-- Schema creation script with sequences and tables

-- Create sequences
CREATE SEQUENCE IF NOT EXISTS users_seq;
CREATE SEQUENCE IF NOT EXISTS suppliers_seq;
CREATE SEQUENCE IF NOT EXISTS medications_seq;
CREATE SEQUENCE IF NOT EXISTS sales_seq;
CREATE SEQUENCE IF NOT EXISTS sale_items_seq;

-- Create tables
CREATE TABLE IF NOT EXISTS users (
    id BIGINT PRIMARY KEY DEFAULT nextval('users_seq'),
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role VARCHAR(20) NOT NULL,
    phone_number VARCHAR(20),
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL,
    last_login TIMESTAMP
);

CREATE TABLE IF NOT EXISTS suppliers (
    id BIGINT PRIMARY KEY DEFAULT nextval('suppliers_seq'),
    name VARCHAR(100) NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    contact_person VARCHAR(100),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    notes TEXT,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS medications (
    id BIGINT PRIMARY KEY DEFAULT nextval('medications_seq'),
    name VARCHAR(100) NOT NULL,
    code VARCHAR(50) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    type VARCHAR(20) NOT NULL,
    dosage VARCHAR(50),
    price NUMERIC(10, 2) NOT NULL,
    stock INTEGER NOT NULL,
    alert_threshold INTEGER NOT NULL DEFAULT 10,
    expiration_date DATE NOT NULL,
    supplier_id BIGINT REFERENCES suppliers(id),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS sales (
    id BIGINT PRIMARY KEY DEFAULT nextval('sales_seq'),
    invoice_number VARCHAR(50) NOT NULL UNIQUE,
    customer_name VARCHAR(100) NOT NULL,
    customer_phone VARCHAR(20),
    total_amount NUMERIC(10, 2) NOT NULL,
    user_id BIGINT NOT NULL REFERENCES users(id),
    sale_date TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS sale_items (
    id BIGINT PRIMARY KEY DEFAULT nextval('sale_items_seq'),
    sale_id BIGINT NOT NULL REFERENCES sales(id),
    medication_id BIGINT NOT NULL REFERENCES medications(id),
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL
);

-- Sample data insertion

-- Insert sample user
INSERT INTO users (username, password, full_name, email, role, phone_number, active, created_at)
VALUES ('testuser', '$2a$10$7QJ1vQ1Q1Q1Q1Q1Q1Q1QeOQ1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q1Q', 'Test User', 'testuser@example.com', 'USER', '123-456-7890', TRUE, NOW());

-- Insert sample supplier
INSERT INTO suppliers (name, code, contact_person, phone_number, email, address, notes, active, created_at, updated_at)
VALUES ('Sample Supplier', 'SUP001', 'John Doe', '123-456-7890', 'supplier@example.com', '123 Supplier St', 'Notes here', TRUE, NOW(), NOW());

-- Insert sample medication
INSERT INTO medications (name, code, description, type, dosage, price, stock, alert_threshold, expiration_date, supplier_id, created_at, updated_at)
VALUES ('Sample Medication', 'MED001', 'Description of medication', 'Tablet', '500mg', 10.00, 100, 10, CURRENT_DATE + INTERVAL '1 year', 1, NOW(), NOW());

-- Insert sample sales
INSERT INTO sales (invoice_number, customer_name, customer_phone, total_amount, user_id, sale_date)
VALUES 
('INV-1001', 'Customer 1', '123-456-7891', 100.00, 1, NOW() - INTERVAL '10 days'),
('INV-1002', 'Customer 2', '123-456-7892', 150.00, 1, NOW() - INTERVAL '9 days'),
('INV-1003', 'Customer 3', '123-456-7893', 200.00, 1, NOW() - INTERVAL '8 days'),
('INV-1004', 'Customer 4', '123-456-7894', 250.00, 1, NOW() - INTERVAL '7 days'),
('INV-1005', 'Customer 5', '123-456-7895', 300.00, 1, NOW() - INTERVAL '6 days'),
('INV-1006', 'Customer 6', '123-456-7896', 350.00, 1, NOW() - INTERVAL '5 days'),
('INV-1007', 'Customer 7', '123-456-7897', 400.00, 1, NOW() - INTERVAL '4 days'),
('INV-1008', 'Customer 8', '123-456-7898', 450.00, 1, NOW() - INTERVAL '3 days'),
('INV-1009', 'Customer 9', '123-456-7899', 500.00, 1, NOW() - INTERVAL '2 days'),
('INV-1010', 'Customer 10', '123-456-7800', 550.00, 1, NOW() - INTERVAL '1 day');

-- Insert sample sale items
INSERT INTO sale_items (sale_id, medication_id, quantity, unit_price, total_price)
VALUES
((SELECT id FROM sales WHERE invoice_number = 'INV-1001'), 1, 10, 10.00, 100.00),
((SELECT id FROM sales WHERE invoice_number = 'INV-1002'), 1, 15, 10.00, 150.00),
((SELECT id FROM sales WHERE invoice_number = 'INV-1003'), 1, 20, 10.00, 200.00),
((SELECT id FROM sales WHERE invoice_number = 'INV-1004'), 1, 25, 10.00, 250.00),
((SELECT id FROM sales WHERE invoice_number = 'INV-1005'), 1, 30, 10.00, 300.00),
((SELECT id FROM sales WHERE invoice_number = 'INV-1006'), 1, 35, 10.00, 350.00),
((SELECT id FROM sales WHERE invoice_number = 'INV-1007'), 1, 40, 10.00, 400.00),
((SELECT id FROM sales WHERE invoice_number = 'INV-1008'), 1, 45, 10.00, 450.00),
((SELECT id FROM sales WHERE invoice_number = 'INV-1009'), 1, 50, 10.00, 500.00),
((SELECT id FROM sales WHERE invoice_number = 'INV-1010'), 1, 55, 10.00, 550.00);
