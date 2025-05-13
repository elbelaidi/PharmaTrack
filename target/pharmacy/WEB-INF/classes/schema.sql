-- Create sequences
CREATE SEQUENCE IF NOT EXISTS users_seq;
CREATE SEQUENCE IF NOT EXISTS suppliers_seq;
CREATE SEQUENCE IF NOT EXISTS medications_seq;
CREATE SEQUENCE IF NOT EXISTS sales_seq;
CREATE SEQUENCE IF NOT EXISTS sale_items_seq;

-- Users table
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

-- Suppliers table
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

-- Medications table
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

-- Sales table
CREATE TABLE IF NOT EXISTS sales (
    id BIGINT PRIMARY KEY DEFAULT nextval('sales_seq'),
    invoice_number VARCHAR(50) NOT NULL UNIQUE,
    customer_name VARCHAR(100) NOT NULL,
    customer_phone VARCHAR(20),
    total_amount NUMERIC(10, 2) NOT NULL,
    user_id BIGINT NOT NULL REFERENCES users(id),
    sale_date TIMESTAMP NOT NULL
);

-- Sale Items table with ON DELETE CASCADE
CREATE TABLE IF NOT EXISTS sale_items (
    id BIGINT PRIMARY KEY DEFAULT nextval('sale_items_seq'),
    sale_id BIGINT NOT NULL,
    medication_id BIGINT NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(10, 2) NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    CONSTRAINT sale_items_sale_id_fkey FOREIGN KEY (sale_id) REFERENCES sales(id) ON DELETE CASCADE,
    CONSTRAINT sale_items_medication_id_fkey FOREIGN KEY (medication_id) REFERENCES medications(id) ON DELETE CASCADE
);