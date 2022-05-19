# Amazon example
CREATE DATABASE amazon;
USE amazon;

CREATE TABLE customer(
cust_id INT UNIQUE NOT NULL AUTO_INCREMENT,
cust_name VARCHAR(100) NOT NULL,
cust_addr VARCHAR(200) NOT NULL,
card_no INT UNIQUE NOT NULL,
PRIMARY KEY (cust_id)
);

SHOW TABLES;
DESCRIBE customer;

CREATE TABLE orders(
order_id INT UNIQUE NOT NULL AUTO_INCREMENT,
fk_cust_id INT NOT NULL,
order_total DECIMAL(6,2) DEFAULT 0.00,
order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (order_id),
FOREIGN KEY (fk_cust_id) REFERENCES customer(cust_id)
);

INSERT INTO customer(cust_name, cust_addr, card_no) VALUES('ash', '1 abc lane', 1234), ('luke', '2 x drive', 1111), ('john', '5 z road', 4322);
SELECT * FROM customer;

INSERT INTO orders(fk_cust_id) VALUES(3);
SELECT * FROM orders;
SELECT * FROM orders o JOIN customer c ON o.fk_cust_id = c.cust_id; -- o and c are aliases for orders and customer, no need to type orders.fk_cust_id = customer.cust_id

# Task3.png
INSERT INTO customer(cust_name, cust_addr, card_no) VALUES('qust', 'q lane', 4444), ('wust', 'w street', 5555);
INSERT INTO orders(fk_cust_id) VALUES(5), (4), (2), (1);

CREATE TABLE items(
item_id INT UNIQUE NOT NULL AUTO_INCREMENT,
item_name VARCHAR(100) NOT NULL,
price DECIMAL(6,2) DEFAULT 0.00,
stock INT DEFAULT 0,
PRIMARY KEY (item_id)
);

INSERT INTO items(item_name, price, stock) VALUES('zitem', 1, 10), ('xitem', 2, 20), ('citem', 3, 30), ('vitem', 4, 40);
INSERT INTO items(item_name) VALUES('bitem');
SELECT * FROM items;

CREATE TABLE order_items(
order_item_id INT UNIQUE NOT NULL AUTO_INCREMENT,
fk_order_id INT NOT NULL,
fk_item_id INT NOT NULL,
quantity INT DEFAULT 0,
orderline_total DECIMAL(10,2) DEFAULT 0.00,
PRIMARY KEY (order_item_id),
FOREIGN KEY (fk_order_id) REFERENCES orders(order_id),
FOREIGN KEY (fk_item_id) REFERENCES items(item_id)
);
drop table order_items;
INSERT INTO order_items(fk_order_id, fk_item_id, quantity) VALUES(1, 1, 10), (1, 2, 20), (2, 2, 10), (2, 3, 20), (3, 3, 10), (3, 4, 20), (4, 4, 10), (4, 5, 20), (5, 5, 10), (5, 1, 20);
SELECT * FROM order_items;
# end of Task3.png

# me playing with viewing
SELECT * FROM orders o JOIN customer c ON o.fk_cust_id = c.cust_id; -- o and c are aliases for orders and customer, no need to type orders.fk_cust_id = customer.cust_id
SELECT * FROM orders o JOIN order_items oi ON o.order_id = oi.order_item_id; 
# from Aswene
SELECT * FROM orders o JOIN customer c ON o.fk_cust_id=c.cust_id;-- JOIN order_items oi ON oi.fk_order_id=o.order_id JOIN items i ON oi.fk_item_id=i.item_id;
-- one more

# Aggregate functions
SELECT SUM(stock) FROM items;
SELECT MIN(stock) FROM items;
SELECT MAX(stock) FROM items;
SELECT AVG(stock) FROM items;
SELECT COUNT(stock) FROM items;

# Nested queries - INCOMPLETE - see Aswene's
SELECT fk_cust_id FROM orders WHERE order_id=2;
SELECT * FROM customer WHERE cust_id=5;
-- is equivalent to
SELECT * FROM customer WHERE cust_id=(SELECT fk_cust_id FROM orders WHERE order_id=2);

SELECT * FROM items WHERE item_id=(SELECT fk_item_id FROM order_items WHERE order_item_id=2);

# Task4.png
SELECT * FROM order_items;

## 1.
UPDATE orders SET order_total=1.20 WHERE order_id > 1;
UPDATE order_items SET orderline_total=1.20 WHERE order_item_id > 0;
## 2.
SELECT fk_order_id, SUM(quantity) FROM order_items GROUP BY fk_order_id;
## 3.
SELECT item_name FROM ITEMS WHERE stock=(SELECT MIN(stock) FROM items);
SELECT item_name FROM ITEMS WHERE stock=(SELECT MAX(stock) FROM items); -- SELECT item_name, MAX(stock) FROM items;
SELECT COUNT(cust_id) FROM customer;
SELECT AVG(order_total) FROM orders;
SELECT fk_order_id, SUM(orderline_total) FROM order_items GROUP BY fk_order_id;
## 4.
SELECT * FROM order_items;
SELECT * FROM items WHERE item_id=(SELECT fk_item_id FROM order_items WHERE fk_order_id=4 LIMIT 1); # only works with 1 item
SELECT cust_addr FROM customer WHERE cust_id=(SELECT fk_cust_id FROM orders WHERE order_id=4);
SELECT order_id FROM orders WHERE fk_cust_id=(SELECT cust_id FROM customer WHERE cust_name='luke');

#SELECT fk_item_id, quantity, orderline_total FROM order_items WHERE fk_order_id=4;
# 4.1 improved to work for all items under the given order id
SELECT item_id, item_name, price, stock FROM items i JOIN (SELECT * FROM order_items WHERE fk_order_id=4) oi_filtered ON i.item_id=oi_filtered.fk_item_id;
# further improvement, no need to SELECT * in () because I only need item ids under the given order in this case
SELECT item_id, item_name, price, stock FROM items i JOIN (SELECT fk_item_id FROM order_items WHERE fk_order_id=4) oi_filtered ON i.item_id=oi_filtered.fk_item_id;

# Extension
# this was my original attempt, where it failed was that I was simply trying to update a view/read of a table and that doesn't work,
# it complained about having to reference the view or something like that so I tried to solve it by using AS but that was complicating it,
# what I should have done was simply to update the joined table, not its view which is what is done in the UPDATE below,
# should be references update which is why the original order_items is updated automatically when any join of it is updated
UPDATE (SELECT * FROM order_items oi JOIN items i ON oi.order_item_id=i.item_id) AS tt SET tt.orderline_total=quantity*price WHERE quantity=10;
# helpers
SELECT * FROM order_items oi JOIN items i ON oi.fk_item_id=i.item_id;
SELECT * FROM order_items;
# solution
UPDATE (order_items oi JOIN items i ON oi.fk_item_id=i.item_id) SET oi.orderline_total = oi.quantity * i.price;

