CREATE DATABASE demo_db;
USE demo_db;

CREATE TABLE Products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(50),
    productName VARCHAR(100),
    productPrice DECIMAL(10,2),
    productAmount INT,
    productDescription TEXT,
    productStatus VARCHAR(50)
);

INSERT INTO Products
(productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
('P001','Laptop Dell',1200,10,'Dell Inspiron','Available'),
('P002','Macbook Pro',2000,5,'Apple laptop','Available'),
('P003','Keyboard',50,100,'Mechanical keyboard','Available'),
('P004','Mouse',25,200,'Wireless mouse','Out of stock');

------------------------------index--------------------------

CREATE UNIQUE INDEX idx_productCode
ON Products(productCode);

CREATE INDEX idx_name_price
ON Products(productName, productPrice);

EXPLAIN SELECT * FROM Products
WHERE productCode = 'P002';

------------------------------VIEW--------------------------


CREATE VIEW product_views AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

SELECT * FROM product_views;

CREATE OR REPLACE VIEW product_views AS
SELECT productCode, productName, productPrice
FROM Products;

DROP VIEW product_views;

------------------------------PROCEDURE--------------------------

CREATE PROCEDURE getAllProducts()
BEGIN
    SELECT * FROM Products;
end;


CALL getAllProducts();

SHOW PROCEDURE STATUS
WHERE Db = 'demo_db';

CREATE PROCEDURE insertProduct(
    IN pCode VARCHAR(50),
    IN pName VARCHAR(100),
    IN pPrice DECIMAL(10,2),
    IN pAmount INT,
    IN pDesc TEXT,
    IN pStatus VARCHAR(50)
)
BEGIN
    INSERT INTO Products
    (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES
    (pCode, pName, pPrice, pAmount, pDesc, pStatus);
end;

CALL insertProduct('P005','Monitor',300,20,'LCD monitor','Available');



CREATE PROCEDURE updateProduct(
    IN pId INT,
    IN pName VARCHAR(100),
    IN pPrice DECIMAL(10,2),
    IN pAmount INT,
    IN pDesc TEXT,
    IN pStatus VARCHAR(50)
)
BEGIN
    UPDATE Products
    SET
        productName = pName,
        productPrice = pPrice,
        productAmount = pAmount,
        productDescription = pDesc,
        productStatus = pStatus
    WHERE id = pId;
end;

CALL updateProduct(1,'Laptop Dell XPS',1500,8,'New version','Available');



CREATE PROCEDURE deleteProduct(
    IN pId INT
)
BEGIN
    DELETE FROM Products
    WHERE id = pId;
END

CALL deleteProduct(3);



















