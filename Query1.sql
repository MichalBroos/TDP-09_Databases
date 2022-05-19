# Lecture

# View all databases
show databases;

# Create a new database
-- create database mcdonalds;
create database if not exists mcdonalds;

# Use a specific database
use mcdonalds;

# Creating a table (use snake_case)
create table items(
id int unique not null auto_increment,
item_name varchar(100) not null,
price decimal(6,2) not null, -- e.g. 1234.56
descript varchar(255) default 'Description TBC',
primary key (id)
);

# Describe the table definition (run and see what it does but simply details about the table)
describe items;

# Show all columns from the given table
SELECT * FROM items;

# Add a new record
INSERT INTO items(item_name, price) VALUES('Fries', 0.99);
INSERT INTO items(item_name, price) VALUES('McSpicy', 3.99), ('Mozzarella', 1.99), ('McFlurry5', 1.50);

# Update a record - DML
UPDATE items SET descript = 'cheesy', price = 1.89 WHERE id = 3;

# Delete a record - DML
DELETE FROM items WHERE id = 2;

# Delete a table (same for db but DATABASE)
DROP TABLE items;

## After task - Updating the schema

# Add another column to the table
ALTER TABLE items ADD `description` VARCHAR(250); # use backticks e.g. when wanting to use a keyword as a database identifier, e.g. column name
# Modifying existing columns
ALTER TABLE items MODIFY item_name VARCHAR(150) NOT NULL;
# Removing a column from the table
ALTER TABLE items DROP COLUMN descript;

# Further view of the table - DML
# not written down, check Aswene's file
