-- Insert sales
INSERT INTO sales (invoice_number, customer_name, customer_phone, total_amount, user_id, sale_date)
VALUES 
    ('INV001', 'Alice Johnson', '+1234567890', 35.48, 2, NOW()),
    ('INV002', 'Bob Wilson', '+0987654321', 25.25, 2, NOW()),
    ('INV003', 'Carol Davis', '+1122334455', 45.97, 3, NOW()),
    ('INV004', 'David Miller', '+5566778899', 18.98, 2, NOW())
ON CONFLICT (invoice_number) DO NOTHING;

-- Insert sale items
INSERT INTO sale_items (sale_id, medication_id, quantity, unit_price, total_price)
VALUES 
    -- Sale 1 (INV001)
    (1, 1, 2, 5.99, 11.98),  -- 2 Paracetamol
    (1, 2, 1, 12.50, 12.50), -- 1 Amoxicillin
    (1, 3, 1, 7.25, 7.25),   -- 1 Ibuprofen
    (1, 4, 1, 3.75, 3.75),   -- 1 Cetirizine
    
    -- Sale 2 (INV002)
    (2, 1, 3, 5.99, 17.97),  -- 3 Paracetamol
    (2, 3, 1, 7.25, 7.25),   -- 1 Ibuprofen
    
    -- Sale 3 (INV003)
    (3, 2, 2, 12.50, 25.00), -- 2 Amoxicillin
    (3, 4, 2, 9.99, 19.98),  -- 2 Cetirizine
    (3, 1, 1, 5.99, 5.99),   -- 1 Paracetamol
    
    -- Sale 4 (INV004)
    (4, 3, 2, 7.25, 14.50),  -- 2 Ibuprofen
    (4, 4, 1, 3.75, 3.75)    -- 1 Cetirizine
ON CONFLICT (id) DO NOTHING; 