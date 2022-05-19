# Task2.png

CREATE DATABASE my_mcdonalds;

USE my_mcdonalds;

CREATE TABLE suppliers (
    id INT UNIQUE NOT NULL AUTO_INCREMENT,
    supplier_name VARCHAR(99) NOT NULL,
    address VARCHAR(199) DEFAULT 'Street, Town, Postcode',
    phone_number INT UNIQUE NOT NULL,
    start_date DATE,
    end_date DATE,
    reliable BOOL,
    PRIMARY KEY (id)
);

DESCRIBE suppliers;

SELECT * FROM suppliers;

INSERT INTO suppliers(supplier_name, address, phone_number, start_date, end_date, reliable) VALUES('Sup1', 'Street1, Town1, Postcode1', 12345, '2019-01-01', '2019-02-02', 0);

INSERT INTO suppliers(supplier_name, address, phone_number, start_date, reliable)
VALUES('Sup2', 'Street2, Town2, Postcode2', 123456, '2020-01-01', 1), ('Sup3', 'Street2, Town2, Postcode2', 1234567, '2021-01-01', 1),
('Sup4', 'Street3, Town3, Postcode3', 12345678, '2022-01-01', 1), ('Sup5', 'Street2, Town2, Postcode2', 123456789, '2022-01-01', 1);

UPDATE suppliers SET supplier_name = 'Better name', phone_number = 22222 WHERE id = 2;

DELETE FROM suppliers WHERE id = 3;
INSERT INTO suppliers(supplier_name, address, phone_number, start_date, reliable) VALUES('Sup6', 'Street6, Town6, Postcode6', 67890, '2019-01-01', 1);

DROP TABLE suppliers



