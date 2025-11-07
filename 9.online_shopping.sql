CREATE DATABASE OnlineShopDB;
USE OnlineShopDB;

-- Create tables
CREATE TABLE CUSTOMER(
  cust_id INT PRIMARY KEY,
  cust_name VARCHAR(50),
  city VARCHAR(50)
);

CREATE TABLE PRODUCT(
  prod_id INT PRIMARY KEY,
  prod_name VARCHAR(50),
  price DECIMAL(10,2)
);

CREATE TABLE ORDER_MASTER(
  order_id INT PRIMARY KEY,
  cust_id INT,
  order_date DATE,
  FOREIGN KEY (cust_id) REFERENCES CUSTOMER(cust_id)
);

CREATE TABLE ORDER_DETAIL(
  order_id INT,
  prod_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES ORDER_MASTER(order_id),
  FOREIGN KEY (prod_id) REFERENCES PRODUCT(prod_id)
);

-- Insert sample data
INSERT INTO CUSTOMER VALUES
(1, 'Amit', 'Pune'),
(2, 'Sneha', 'Mumbai');

INSERT INTO PRODUCT VALUES
(101, 'Laptop', 60000),
(102, 'Mouse', 500);

INSERT INTO ORDER_MASTER VALUES
(1, 1, '2025-11-01'),
(2, 2, '2025-11-02');

INSERT INTO ORDER_DETAIL VALUES
(1, 101, 1),
(1, 102, 2),
(2, 101, 1);

-- 1️⃣ View: Customer name, product name, quantity, order date
CREATE VIEW customer_orders AS
SELECT c.cust_name, p.prod_name, od.quantity, om.order_date
FROM CUSTOMER c, PRODUCT p, ORDER_MASTER om, ORDER_DETAIL od
WHERE c.cust_id = om.cust_id
AND om.order_id = od.order_id
AND od.prod_id = p.prod_id;

-- 2️⃣ View: Total amount spent by each customer
CREATE VIEW total_spent AS
SELECT c.cust_name, SUM(p.price * od.quantity) AS total
FROM CUSTOMER c, PRODUCT p, ORDER_MASTER om, ORDER_DETAIL od
WHERE c.cust_id = om.cust_id
AND om.order_id = od.order_id
AND od.prod_id = p.prod_id
GROUP BY c.cust_name;

-- 3️⃣ View: Products with price > average price
CREATE VIEW high_price_products AS
SELECT prod_name, price
FROM PRODUCT
WHERE price > (SELECT AVG(price) FROM PRODUCT);

-- 4️⃣ View: Total sales of each product
CREATE VIEW total_sales AS
SELECT p.prod_name, SUM(od.quantity * p.price) AS sales
FROM PRODUCT p, ORDER_DETAIL od
WHERE p.prod_id = od.prod_id
GROUP BY p.prod_name;

-- 5️⃣ View: Orders from customers in Pune
CREATE VIEW pune_orders AS
SELECT c.cust_name, p.prod_name, od.quantity
FROM CUSTOMER c, PRODUCT p, ORDER_MASTER om, ORDER_DETAIL od
WHERE c.cust_id = om.cust_id
AND om.order_id = od.order_id
AND od.prod_id = p.prod_id
AND c.city = 'Pune';

-- Check all views
SELECT * FROM customer_orders;
SELECT * FROM total_spent;
SELECT * FROM high_price_products;
SELECT * FROM total_sales;
SELECT * FROM pune_orders;
