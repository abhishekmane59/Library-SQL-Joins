Enter password: ****
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 27
Server version: 9.3.0 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> create database tables;
Query OK, 1 row affected (0.149 sec)

mysql> use tables;
Database changed
mysql> CREATE TABLE Customers (
    ->     CustomerID INT PRIMARY KEY,
    ->     CustomerName VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.797 sec)

mysql> CREATE TABLE Orders (
    ->     OrderID INT PRIMARY KEY,
    ->     CustomerID INT,
    ->     Product VARCHAR(100),
    ->     FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    -> );
Query OK, 0 rows affected (0.394 sec)

mysql> INSERT INTO Customers VALUES
    -> (1, 'Abhishek'),
    -> (2, 'Neha'),
    -> (3, 'Rahul'),
    -> (4, 'Meena');
Query OK, 4 rows affected (0.087 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Orders VALUES
    -> (101, 1, 'Laptop'),
    -> (102, 1, 'Mouse'),
    -> (103, 2, 'Keyboard'),
    -> (104, 5, 'Monitor');
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`tables`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`))
mysql> SELECT Customers.CustomerID, Customers.CustomerName, Orders.Product
    -> FROM Customers
    -> INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
Empty set (0.015 sec)

mysql> SHOW TABLES;
+------------------+
| Tables_in_tables |
+------------------+
| customers        |
| orders           |
+------------------+
2 rows in set (0.171 sec)

mysql> SELECT * FROM Customers;
+------------+--------------+
| CustomerID | CustomerName |
+------------+--------------+
|          1 | Abhishek     |
|          2 | Neha         |
|          3 | Rahul        |
|          4 | Meena        |
+------------+--------------+
4 rows in set (0.029 sec)

mysql> SELECT * FROM Orders;
Empty set (0.005 sec)

mysql> SELECT * FROM orders;
Empty set (0.010 sec)

mysql> DROP TABLE IF EXISTS Orders;
Query OK, 0 rows affected (0.180 sec)

mysql> CREATE TABLE Orders (
    ->     OrderID INT PRIMARY KEY,
    ->     CustomerID INT,
    ->     Product VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.178 sec)

mysql> INSERT INTO Orders VALUES
    -> (101, 1, 'Laptop'),
    -> (102, 1, 'Mouse'),
    -> (103, 2, 'Keyboard'),
    -> (104, 5, 'Monitor');
Query OK, 4 rows affected (0.043 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> SHOW TABLES;
+------------------+
| Tables_in_tables |
+------------------+
| customers        |
| orders           |
+------------------+
2 rows in set (0.033 sec)

mysql> SELECT * FROM Orders;
+---------+------------+----------+
| OrderID | CustomerID | Product  |
+---------+------------+----------+
|     101 |          1 | Laptop   |
|     102 |          1 | Mouse    |
|     103 |          2 | Keyboard |
|     104 |          5 | Monitor  |
+---------+------------+----------+
4 rows in set (0.009 sec)

mysql> SELECT Customers.CustomerID, Customers.CustomerName, Orders.Product
    -> FROM Customers
    -> INNER JOIN Orders
    -> ON Customers.CustomerID = Orders.CustomerID;
+------------+--------------+----------+
| CustomerID | CustomerName | Product  |
+------------+--------------+----------+
|          1 | Abhishek     | Laptop   |
|          1 | Abhishek     | Mouse    |
|          2 | Neha         | Keyboard |
+------------+--------------+----------+
3 rows in set (0.023 sec)

mysql> SELECT Customers.CustomerID, Customers.CustomerName, Orders.Product
    -> FROM Customers
    -> LEFT JOIN Orders
    -> ON Customers.CustomerID = Orders.CustomerID;
+------------+--------------+----------+
| CustomerID | CustomerName | Product  |
+------------+--------------+----------+
|          1 | Abhishek     | Mouse    |
|          1 | Abhishek     | Laptop   |
|          2 | Neha         | Keyboard |
|          3 | Rahul        | NULL     |
|          4 | Meena        | NULL     |
+------------+--------------+----------+
5 rows in set (0.043 sec)

mysql> SELECT Customers.CustomerID, Customers.CustomerName, Orders.Product
    -> FROM Customers
    -> RIGHT JOIN Orders
    -> ON Customers.CustomerID = Orders.CustomerID;
+------------+--------------+----------+
| CustomerID | CustomerName | Product  |
+------------+--------------+----------+
|          1 | Abhishek     | Laptop   |
|          1 | Abhishek     | Mouse    |
|          2 | Neha         | Keyboard |
|       NULL | NULL         | Monitor  |
+------------+--------------+----------+
4 rows in set (0.007 sec)

mysql> -- FULL OUTER JOIN simulation using UNION
Query OK, 0 rows affected (0.011 sec)

mysql> SELECT Customers.CustomerID, Customers.CustomerName, Orders.Product
    -> FROM Customers
    -> LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
    ->
    -> UNION
    ->
    -> SELECT Customers.CustomerID, Customers.CustomerName, Orders.Product
    -> FROM Customers
    -> RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
+------------+--------------+----------+
| CustomerID | CustomerName | Product  |
+------------+--------------+----------+
|          1 | Abhishek     | Mouse    |
|          1 | Abhishek     | Laptop   |
|          2 | Neha         | Keyboard |
|          3 | Rahul        | NULL     |
|          4 | Meena        | NULL     |
|       NULL | NULL         | Monitor  |
+------------+--------------+----------+
6 rows in set (0.067 sec)

mysql>