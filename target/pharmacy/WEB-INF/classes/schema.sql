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

-- Insert demo users (passwords are: admin123, pharmacy123, assistant123)
INSERT INTO users (username, password, full_name, email, role, created_at)
VALUES 
    ('admin', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.AQubh4a', 'Admin User', 'admin@pharmacy.com', 'ADMIN', NOW()),
    ('pharmacist', '$2a$10$uXxvBGD2iC.xZ.Z5L.3YHe4XE6gRUjCLVDiwXGgEcRz3vL2w4AgSS', 'Pharmacist User', 'pharmacist@pharmacy.com', 'PHARMACIST', NOW()),
    ('assistant', '$2a$10$3nqFKzYCEz6rbYgWR9FVXeoR6gV5xHFXZzBk3arFQrh.K.7i.FzW', 'Assistant User', 'assistant@pharmacy.com', 'ASSISTANT', NOW())
ON CONFLICT (username) DO NOTHING;

-- Insert demo suppliers
INSERT INTO suppliers (name, code, contact_person, phone_number, email, address, active, created_at, updated_at)
VALUES 
    ('PharmaCorp', 'SUP001', 'John Smith', '555-123-4567', 'john@pharmacorp.com', '123 Pharma St, Medicity', TRUE, NOW(), NOW()),
    ('MediSupply', 'SUP002', 'Jane Brown', '555-987-6543', 'jane@medisupply.com', '456 Health Ave, Medicity', TRUE, NOW(), NOW())
ON CONFLICT (code) DO NOTHING;

-- Insert demo medications
INSERT INTO medications (name, code, description, type, dosage, price, stock, alert_threshold, expiration_date, supplier_id, created_at, updated_at)
VALUES 
    ('Paracetamol', 'MED001', 'Pain reliever and fever reducer', 'TABLETS', '500mg', 5.99, 100, 20, '2025-12-31', 1, NOW(), NOW()),
    ('Amoxicillin', 'MED002', 'Antibiotic to treat bacterial infections', 'CAPSULES', '250mg', 12.50, 50, 10, '2025-06-30', 1, NOW(), NOW()),
    ('Ibuprofen', 'MED003', 'Non-steroidal anti-inflammatory drug', 'TABLETS', '400mg', 7.99, 80, 15, '2025-10-15', 2, NOW(), NOW()),
    ('Cetirizine', 'MED004', 'Antihistamine for allergies', 'TABLETS', '10mg', 9.99, 60, 12, '2025-08-20', 2, NOW(), NOW())
ON CONFLICT (code) DO NOTHING;
