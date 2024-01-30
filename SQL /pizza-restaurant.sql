CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    phone_number VARCHAR(20),
    email VARCHAR(30)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(8,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE menu (
    pizza_id INT PRIMARY KEY,
    name VARCHAR(100),
    toppings VARCHAR(255),
    price DECIMAL(5,2)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    pizza_id INT,
    quantity INT,
    subtotal DECIMAL(8,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES menu(pizza_id)
);

INSERT INTO customers (customer_id, name, phone_number, email) VALUES
    (1, 'Taylor Swift', '088-123-9862', 'tay.tayy@email.com'),
    (2, 'Jane Smith', '088-123-9863', 'jane.smith@email.com'),
    (3, 'Jane Doe', '077-345-6789', 'jane.doe@email.com'),
    (4, 'Alex Johnson', '099-876-5432', 'alex.johnson@email.com'),
    (5, 'Emily White', '055-789-0123', 'emily.white@email.com'),
    (6, 'David Brown', '066-234-5678', 'david.brown@email.com');

INSERT INTO menu (pizza_id, name, toppings, price) VALUES
    (1, 'Margherita', 'Tomato, Mozzarella, Basil', 8.99),
    (2, 'Pepperoni Lover''s', 'Pepperoni, Mozzarella', 9.99),
    (3, 'Vegetarian Delight', 'Bell Peppers, Olives, Mushrooms', 10.99),
    (4, 'BBQ Chicken', 'Chicken, BBQ Sauce, Red Onions', 12.99),
    (5, 'Hawaiian', 'Ham, Pineapple, Mozzarella', 11.99);

INSERT INTO orders (order_id, customer_id, order_date, total_price) VALUES
    (1, 1, '2024-01-30', 25.99),
    (2, 2, '2024-01-31', 18.99),
    (3, 3, '2024-02-01', 22.50),
    (4, 4, '2024-02-02', 30.75),
    (5, 5, '2024-02-03', 16.99),
    (6, 1, '2024-02-04', 19.95),
    (7, 2, '2024-02-05', 27.50);

INSERT INTO order_details (order_detail_id, order_id, pizza_id, quantity, subtotal) VALUES
    (1, 1, 1, 2, 17.98),
    (2, 1, 2, 1, 9.99),
    (3, 2, 1, 1, 8.99),
    (4, 3, 3, 3, 32.97),
    (5, 3, 2, 2, 19.98),
    (6, 4, 4, 1, 12.50),
    (7, 4, 1, 2, 17.98);

-- View customer orders with details
SELECT
    c.customer_id,
    c.name AS customer_name,
    o.order_id,
    o.order_date,
    od.quantity,
    m.name AS pizza_name,
    m.toppings,
    m.price AS unit_price,
    od.subtotal
FROM
    customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN menu m ON od.pizza_id = m.pizza_id;

-- Find the top 3 most ordered food items
SELECT
    m.pizza_id,
    m.name AS pizza_name,
    m.toppings,
    m.price,
    COUNT(od.pizza_id) AS total_orders
FROM
    menu m
JOIN
    order_details od ON m.pizza_id = od.pizza_id
GROUP BY
    m.pizza_id, m.name, m.toppings, m.price
ORDER BY
    total_orders DESC
LIMIT 3;

-- Find customers with the most purchases
SELECT
    c.customer_id,
    c.name AS customer_name,
    COUNT(o.order_id) AS total_purchases
FROM
    customers c
JOIN
    orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id, c.name
ORDER BY
    total_purchases DESC
LIMIT 1;
