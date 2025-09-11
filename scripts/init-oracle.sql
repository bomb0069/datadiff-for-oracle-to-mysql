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

-- EMPLOYEES table (Oracle has fewer fields than MySQL)
-- MySQL has: id, first_name, last_name, email, phone, department, salary, hire_date, manager_id, office_location (10 fields)
-- Oracle has: id, first_name, last_name, email, department, salary (6 fields - only common fields)
CREATE TABLE EMPLOYEES (
    ID NUMBER PRIMARY KEY,
    FIRST_NAME VARCHAR2(50),
    LAST_NAME VARCHAR2(50),
    EMAIL VARCHAR2(100),
    DEPARTMENT VARCHAR2(50),
    SALARY NUMBER(10,2)
);

-- PRODUCT_CATEGORIES table (Oracle has fewer fields than MySQL)  
-- MySQL has: category_id, category_name, description, parent_category_id, display_order, is_active, created_date, updated_date, created_by, updated_by (10 fields)
-- Oracle has: category_id, category_name, parent_category_id, is_active (4 fields - only common core fields)
CREATE TABLE PRODUCT_CATEGORIES (
    CATEGORY_ID NUMBER PRIMARY KEY,
    CATEGORY_NAME VARCHAR2(100),
    PARENT_CATEGORY_ID NUMBER,
    IS_ACTIVE NUMBER(1)
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

INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, EMAIL, DEPARTMENT, SALARY) VALUES (1, 'John', 'Smith', 'john.smith@company.com', 'Engineering', 78000.00);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, EMAIL, DEPARTMENT, SALARY) VALUES (2, 'Sarah', 'Johnson', 'sarah.johnson@company.com', 'Marketing', 65000.00);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, EMAIL, DEPARTMENT, SALARY) VALUES (3, 'Mike', 'Davis', 'mike.davis@company.com', 'Engineering', 70000.00);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, EMAIL, DEPARTMENT, SALARY) VALUES (4, 'Lisa', 'Wilson', 'lisa.wilson@company.com', 'Sales', 68000.00);
INSERT INTO EMPLOYEES (ID, FIRST_NAME, LAST_NAME, EMAIL, DEPARTMENT, SALARY) VALUES (5, 'David', 'Brown', 'david.brown@company.com', 'IT', 62000.00);

INSERT INTO PRODUCT_CATEGORIES (CATEGORY_ID, CATEGORY_NAME, PARENT_CATEGORY_ID, IS_ACTIVE) VALUES (1, 'Electronics', NULL, 1);
INSERT INTO PRODUCT_CATEGORIES (CATEGORY_ID, CATEGORY_NAME, PARENT_CATEGORY_ID, IS_ACTIVE) VALUES (2, 'Computers', 1, 1);
INSERT INTO PRODUCT_CATEGORIES (CATEGORY_ID, CATEGORY_NAME, PARENT_CATEGORY_ID, IS_ACTIVE) VALUES (3, 'Accessories', 1, 1);
INSERT INTO PRODUCT_CATEGORIES (CATEGORY_ID, CATEGORY_NAME, PARENT_CATEGORY_ID, IS_ACTIVE) VALUES (4, 'Furniture', NULL, 1);
INSERT INTO PRODUCT_CATEGORIES (CATEGORY_ID, CATEGORY_NAME, PARENT_CATEGORY_ID, IS_ACTIVE) VALUES (5, 'Office Equipment', 4, 1);

-- Commit all changes
COMMIT;
