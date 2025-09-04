-- Employees table
CREATE TABLE employees (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100)
);

INSERT INTO employees (id, name, email) VALUES (1, 'Alice', 'alice@example.com');
INSERT INTO employees (id, name, email) VALUES (2, 'Bob', 'bob@example.com');
INSERT INTO employees (id, name, email) VALUES (3, 'Charlie', 'charlie@example.com');

-- Departments table
CREATE TABLE departments (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(100),
    manager_id NUMBER,
    budget NUMBER(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO departments (dept_id, dept_name, manager_id, budget) VALUES (1, 'Engineering', 1, 500000.00);
INSERT INTO departments (dept_id, dept_name, manager_id, budget) VALUES (2, 'Marketing', 2, 250000.00);
INSERT INTO departments (dept_id, dept_name, manager_id, budget) VALUES (3, 'Sales', 3, 300000.00);
INSERT INTO departments (dept_id, dept_name, manager_id, budget) VALUES (4, 'HR', 1, 150000.00);

-- Projects table (with intentional differences for testing)
CREATE TABLE projects (
    project_id NUMBER PRIMARY KEY,
    project_name VARCHAR2(150),
    dept_id NUMBER,
    status VARCHAR2(20),
    start_date DATE,
    budget NUMBER(12,2)
);

INSERT INTO projects (project_id, project_name, dept_id, status, start_date, budget) VALUES (101, 'Website Redesign', 1, 'ACTIVE', DATE '2024-01-15', 75000.00);
INSERT INTO projects (project_id, project_name, dept_id, status, start_date, budget) VALUES (102, 'Mobile App', 1, 'ACTIVE', DATE '2024-02-01', 120000.00);
INSERT INTO projects (project_id, project_name, dept_id, status, start_date, budget) VALUES (103, 'Marketing Campaign', 2, 'COMPLETED', DATE '2024-01-01', 45000.00);
INSERT INTO projects (project_id, project_name, dept_id, status, start_date, budget) VALUES (104, 'Sales Training', 3, 'COMPLETED', DATE '2024-03-01', 25000.00);
-- Note: Project 105 missing in Oracle for difference testing
INSERT INTO projects (project_id, project_name, dept_id, status, start_date, budget) VALUES (106, 'Oracle Migration', 1, 'ACTIVE', DATE '2024-05-01', 95000.00);

-- Products table (with some differences for testing)
CREATE TABLE products (
    product_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100),
    category VARCHAR2(50),
    price NUMBER(8,2),
    stock_quantity NUMBER,
    active NUMBER(1) DEFAULT 1
);

INSERT INTO products (product_id, product_name, category, price, stock_quantity, active) VALUES (1001, 'Laptop Pro', 'Electronics', 1299.99, 50, 1);
INSERT INTO products (product_id, product_name, category, price, stock_quantity, active) VALUES (1002, 'Wireless Mouse', 'Electronics', 29.99, 200, 1);
INSERT INTO products (product_id, product_name, category, price, stock_quantity, active) VALUES (1003, 'Office Chair', 'Furniture', 199.99, 25, 1);
INSERT INTO products (product_id, product_name, category, price, stock_quantity, active) VALUES (1004, 'Standing Desk', 'Furniture', 449.99, 15, 1);
-- Note: Different price for Standing Desk (449.99 vs 399.99) and missing Bluetooth Headphones
INSERT INTO products (product_id, product_name, category, price, stock_quantity, active) VALUES (1006, 'Wireless Keyboard', 'Electronics', 59.99, 100, 1);