-- Star Schema for Retail Data Warehouse

-- Dimension: dim_date
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);

-- Dimension: dim_store
CREATE TABLE dim_store (
    store_key INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(50) NOT NULL
);

-- Dimension: dim_product
CREATE TABLE dim_product (
    product_key INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL
);

-- Fact: fact_sales
CREATE TABLE fact_sales (
    transaction_id VARCHAR(20) PRIMARY KEY,
    date_key INT NOT NULL,
    store_key INT NOT NULL,
    product_key INT NOT NULL,
    units_sold INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(15,2) NOT NULL,
    customer_id VARCHAR(20),
    FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
    FOREIGN KEY (store_key) REFERENCES dim_store(store_key),
    FOREIGN KEY (product_key) REFERENCES dim_product(product_key)
);

-- Insert dimension data (cleaned and standardized)

-- dim_date
INSERT INTO dim_date (date_key, full_date, year, month, day) VALUES
(20230829, '2023-08-29', 2023, 8, 29),
(20231212, '2023-12-12', 2023, 12, 12),
(20230205, '2023-02-05', 2023, 2, 5),
(20230220, '2023-02-20', 2023, 2, 20),
(20230115, '2023-01-15', 2023, 1, 15),
(20230809, '2023-08-09', 2023, 8, 9),
(20230331, '2023-03-31', 2023, 3, 31),
(20231026, '2023-10-26', 2023, 10, 26),
(20231208, '2023-12-08', 2023, 12, 8),
(20230815, '2023-08-15', 2023, 8, 15);

-- dim_store
INSERT INTO dim_store (store_key, store_name, store_city) VALUES
(1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Bangalore MG', 'Bangalore'),
(4, 'Pune FC Road', 'Pune'),
(5, 'Mumbai Central', 'Mumbai');

-- dim_product
INSERT INTO dim_product (product_key, product_name, category) VALUES
(1, 'Speaker', 'Electronics'),
(2, 'Tablet', 'Electronics'),
(3, 'Phone', 'Electronics'),
(4, 'Smartwatch', 'Electronics'),
(5, 'Atta 10kg', 'Groceries'),
(6, 'Jeans', 'Clothing'),
(7, 'Biscuits', 'Groceries'),
(8, 'Jacket', 'Clothing'),
(9, 'Laptop', 'Electronics'),
(10, 'Milk 1L', 'Groceries');

-- Insert fact data (cleaned sample, 10 rows)
INSERT INTO fact_sales (transaction_id, date_key, store_key, product_key, units_sold, unit_price, total_amount, customer_id) VALUES
('TXN5000', 20230829, 1, 1, 3, 49262.78, 147788.34, 'CUST045'),
('TXN5001', 20231212, 1, 2, 11, 23226.12, 255487.32, 'CUST021'),
('TXN5002', 20230205, 1, 3, 20, 48703.39, 974067.80, 'CUST019'),
('TXN5003', 20230220, 2, 2, 14, 23226.12, 325165.68, 'CUST007'),
('TXN5004', 20230115, 1, 4, 10, 58851.01, 588510.10, 'CUST004'),
('TXN5005', 20230809, 3, 5, 12, 52464.00, 629568.00, 'CUST027'),
('TXN5006', 20230331, 4, 4, 6, 58851.01, 353106.06, 'CUST025'),
('TXN5007', 20231026, 4, 6, 16, 2317.47, 37079.52, 'CUST041'),
('TXN5008', 20231208, 3, 7, 9, 27469.99, 247229.91, 'CUST030'),
('TXN5009', 20230815, 3, 4, 3, 58851.01, 176553.03, 'CUST020');