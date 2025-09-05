-- Connect as SYSTEM user to create tables in SYSTEM schema
ALTER SESSION SET CURRENT_SCHEMA=SYSTEM;

-- Products table
CREATE TABLE products (
    ID NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    price NUMBER(10,2),
    category VARCHAR2(50)
);

-- Customers table  
CREATE TABLE customers (
    ID NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    country VARCHAR2(50)
);

-- Orders table
CREATE TABLE orders (
    ID NUMBER PRIMARY KEY,
    customer_id NUMBER,
    product_id NUMBER,
    quantity NUMBER,
    order_date DATE
);

-- Insert products data (with some differences for testing)
INSERT INTO products (ID, name, price, category) VALUES (1, 'Laptop Pro', 1399.99, 'Electronics');
INSERT INTO products (ID, name, price, category) VALUES (2, 'Wireless Mouse', 29.99, 'Electronics');
INSERT INTO products (ID, name, price, category) VALUES (3, 'Mechanical Keyboard', 89.99, 'Electronics');
INSERT INTO products (ID, name, price, category) VALUES (4, '4K Monitor', 349.99, 'Electronics');
INSERT INTO products (ID, name, price, category) VALUES (5, 'Gaming Chair', 249.99, 'Furniture');
INSERT INTO products (ID, name, price, category) VALUES (6, 'USB Hub', 24.99, 'Electronics');

-- Insert customers data (with some differences)
INSERT INTO customers (ID, name, email, country) VALUES (1, 'John Doe', 'john@example.com', 'USA');
INSERT INTO customers (ID, name, email, country) VALUES (2, 'Jane Smith', 'jane.smith@example.com', 'Canada');
INSERT INTO customers (ID, name, email, country) VALUES (3, 'Bob Johnson', 'bob@example.com', 'UK');
INSERT INTO customers (ID, name, email, country) VALUES (4, 'Alice Brown', 'alice@example.com', 'Australia');
INSERT INTO customers (ID, name, email, country) VALUES (5, 'Charlie Wilson', 'charlie@example.com', 'Germany');
INSERT INTO customers (ID, name, email, country) VALUES (7, 'David Lee', 'david@example.com', 'France');

-- Insert orders data (with some differences)
INSERT INTO orders (ID, customer_id, product_id, quantity, order_date) VALUES (1, 1, 1, 1, DATE '2024-01-15');
INSERT INTO orders (ID, customer_id, product_id, quantity, order_date) VALUES (2, 2, 2, 2, DATE '2024-01-16');
INSERT INTO orders (ID, customer_id, product_id, quantity, order_date) VALUES (3, 3, 3, 1, DATE '2024-01-17');
INSERT INTO orders (ID, customer_id, product_id, quantity, order_date) VALUES (4, 1, 4, 2, DATE '2024-01-18');
INSERT INTO orders (ID, customer_id, product_id, quantity, order_date) VALUES (5, 4, 5, 1, DATE '2024-01-19');
INSERT INTO orders (ID, customer_id, product_id, quantity, order_date) VALUES (6, 5, 6, 3, DATE '2024-01-20');
INSERT INTO orders (ID, customer_id, product_id, quantity, order_date) VALUES (8, 7, 1, 1, DATE '2024-01-22');

-- Commit all changes
COMMIT;
