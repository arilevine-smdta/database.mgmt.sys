-- Write a SQL Update to change customer 10001.  
-- New Name is ‘ Technology Inc.’, New Address is ‘111 Franklin St, Philadelphia, PA 19130’
START TRANSACTION;
UPDATE customer
set cust_name = 'Technology Inc.', cust_address = '111 Franklin St', cust_city = 'Philadelphia', cust_state = 'PA', cust_zip = '19130'
WHERE cust_id = '10001';

-- Write a SQL Delete to remove customer 10002.
START TRANSACTION;
DELETE FROM customer
WHERE cust_id = '10002';

-- Select Statements
-- Write 3 SQL statements to find the highest (MAX), Lowest (MIN) and Average (AVG) price from the product table.
SELECT MAX(prod_price)
FROM product;

SELECT MIN(prod_price)
FROM product;

SELECT AVG(prod_price)
FROM product;

-- Rewrite 6.1 above to use 1 SQL statement with labels for each attribute the result should look like.         
	-- Price High   Low    Average
	-- 		 99.99  99.99  99.99
SELECT 
    MAX(prod_price) AS High,
    MIN(prod_price) AS Low,
    ROUND(AVG(prod_price),2) AS Average
FROM product;

-- List vendor name,  product name and product price
SELECT vend_name, prod_name, prod_price
FROM product, vendor
WHERE product.vend_id = vendor.vend_id;

-- OR
SELECT vendor.vend_name, product.prod_name, product.prod_price
FROM product
JOIN vendor ON product.vend_id = vendor.vend_id;

-- List Customer name and product name and order date.  Sort the list by order date.
SELECT customer.cust_name, product.prod_name, orders.order_date
FROM customer
JOIN orders ON customer.cust_id = orders.cust_id
JOIN orderitem ON orders.order_num = orderitem.order_num
JOIN product ON orderitem.prod_id = product.prod_id;

-- List Vendor Name of Vendors that don’t have products.
SELECT vend_name
FROM vendor
WHERE vend_id NOT IN (SELECT vend_id FROM product);

-- List Product Name and Price. Sort the list by price descending.
SELECT prod_name, prod_price
FROM product
ORDER BY prod_price DESC;

-- List State and count of vendors by state (State, Count) use Group By
SELECT vend_state AS State, COUNT(vend_id) AS Count
FROM vendor
GROUP BY vend_state;