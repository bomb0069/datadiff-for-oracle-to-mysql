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