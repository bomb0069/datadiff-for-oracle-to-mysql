-- Products table
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    category VARCHAR(50)
);

INSERT INTO products (id, name, price, category) VALUES
(1, 'Laptop Pro', 1299.99, 'Electronics'),
(2, 'Wireless Mouse', 29.99, 'Electronics'),
(3, 'Mechanical Keyboard', 89.99, 'Electronics'),
(4, '4K Monitor', 349.99, 'Electronics'),
(5, 'Gaming Chair', 199.99, 'Furniture'),
(6, 'USB Hub', 24.99, 'Electronics'),
(7, 'Standing Desk', 299.99, 'Furniture');

-- Customers table
CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50)
);

INSERT INTO customers (id, name, email, country) VALUES
(1, 'John Doe', 'john@example.com', 'USA'),
(2, 'Jane Smith', 'jane@example.com', 'Canada'),
(3, 'Bob Johnson', 'bob@example.com', 'UK'),
(4, 'Alice Brown', 'alice@example.com', 'Australia'),
(5, 'Charlie Wilson', 'charlie@example.com', 'Germany'),
(6, 'Maria Garcia', 'maria@example.com', 'Spain');

-- Orders table
CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE
);

INSERT INTO orders (id, customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, 1, '2024-01-15'),
(2, 2, 2, 2, '2024-01-16'),
(3, 3, 3, 1, '2024-01-17'),
(4, 1, 4, 1, '2024-01-18'),
(5, 4, 5, 1, '2024-01-19'),
(6, 5, 6, 3, '2024-01-20'),
(7, 6, 7, 1, '2024-01-21');

-- Employees table (MySQL has more fields than Oracle)
CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    manager_id INT,
    office_location VARCHAR(100)
);

INSERT INTO employees (id, first_name, last_name, email, phone, department, salary, hire_date, manager_id, office_location) VALUES
(1, 'John', 'Smith', 'john.smith@company.com', '+1-555-0101', 'Engineering', 75000.00, '2022-03-15', NULL, 'Building A, Floor 3'),
(2, 'Sarah', 'Johnson', 'sarah.johnson@company.com', '+1-555-0102', 'Marketing', 65000.00, '2022-06-01', 1, 'Building B, Floor 2'),
(3, 'Mike', 'Davis', 'mike.davis@company.com', '+1-555-0103', 'Engineering', 70000.00, '2023-01-10', 1, 'Building A, Floor 3'),
(4, 'Lisa', 'Wilson', 'lisa.wilson@company.com', '+1-555-0104', 'Sales', 68000.00, '2023-02-20', NULL, 'Building C, Floor 1'),
(5, 'David', 'Brown', 'david.brown@company.com', '+1-555-0105', 'HR', 62000.00, '2023-04-15', 4, 'Building B, Floor 1');

-- Product categories table (Oracle will have fewer fields)
CREATE TABLE product_categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100),
    description TEXT,
    parent_category_id INT,
    display_order INT,
    is_active BOOLEAN,
    created_date DATE,
    updated_date DATE,
    created_by VARCHAR(50),
    updated_by VARCHAR(50)
);

INSERT INTO product_categories (category_id, category_name, description, parent_category_id, display_order, is_active, created_date, updated_date, created_by, updated_by) VALUES
(1, 'Electronics', 'Electronic devices and accessories', NULL, 1, TRUE, '2024-01-01', '2024-01-01', 'admin', 'admin'),
(2, 'Computers', 'Desktop and laptop computers', 1, 1, TRUE, '2024-01-01', '2024-01-01', 'admin', 'admin'),
(3, 'Accessories', 'Computer accessories and peripherals', 1, 2, TRUE, '2024-01-01', '2024-01-01', 'admin', 'admin'),
(4, 'Furniture', 'Office and home furniture', NULL, 2, TRUE, '2024-01-01', '2024-01-01', 'admin', 'admin'),
(5, 'Chairs', 'Office and gaming chairs', 4, 1, TRUE, '2024-01-01', '2024-01-01', 'admin', 'admin');