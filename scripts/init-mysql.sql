-- Employees table
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO employees (id, name, email) VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com'),
(3, 'Charlie', 'charlie@example.com');

-- Departments table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100),
    manager_id INT,
    budget DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO departments (dept_id, dept_name, manager_id, budget) VALUES
(1, 'Engineering', 1, 500000.00),
(2, 'Marketing', 2, 250000.00),
(3, 'Sales', 3, 300000.00),
(4, 'HR', 1, 150000.00);

-- Projects table
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(150),
    dept_id INT,
    status VARCHAR(20),
    start_date DATE,
    budget DECIMAL(12,2)
);

INSERT INTO projects (project_id, project_name, dept_id, status, start_date, budget) VALUES
(101, 'Website Redesign', 1, 'ACTIVE', '2024-01-15', 75000.00),
(102, 'Mobile App', 1, 'ACTIVE', '2024-02-01', 120000.00),
(103, 'Marketing Campaign', 2, 'COMPLETED', '2024-01-01', 45000.00),
(104, 'Sales Training', 3, 'ACTIVE', '2024-03-01', 25000.00),
(105, 'HR System', 4, 'PLANNING', '2024-04-01', 80000.00);

-- Products table (for testing different scenarios)
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(8,2),
    stock_quantity INT,
    active BOOLEAN DEFAULT TRUE
);

INSERT INTO products (product_id, product_name, category, price, stock_quantity, active) VALUES
(1001, 'Laptop Pro', 'Electronics', 1299.99, 50, TRUE),
(1002, 'Wireless Mouse', 'Electronics', 29.99, 200, TRUE),
(1003, 'Office Chair', 'Furniture', 199.99, 25, TRUE),
(1004, 'Standing Desk', 'Furniture', 399.99, 15, TRUE),
(1005, 'Bluetooth Headphones', 'Electronics', 89.99, 75, FALSE);