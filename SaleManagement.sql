use sale_management

CREATE TABLE Customer (
  cID   INT AUTO_INCREMENT PRIMARY KEY,
  cName VARCHAR(100) NOT NULL,
  cAge  INT NOT NULL,
  CONSTRAINT chk_customer_age CHECK (cAge BETWEEN 0 AND 120)
);

CREATE TABLE Product (
  pID    INT AUTO_INCREMENT PRIMARY KEY,
  pName  VARCHAR(150) NOT NULL,
  pPrice DECIMAL(12,2) NOT NULL,
  CONSTRAINT chk_product_price CHECK (pPrice >= 0)
);

CREATE TABLE Orders (
  oID          INT AUTO_INCREMENT PRIMARY KEY,
  cID          INT NOT NULL,
  oDate        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  oTotalPrice  DECIMAL(12,2) NOT NULL DEFAULT 0,
  CONSTRAINT fk_orders_customer
    FOREIGN KEY (cID) REFERENCES Customer(cID)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT chk_orders_total CHECK (oTotalPrice >= 0)
);

CREATE TABLE IF NOT EXISTS OrderDetail (
  oID   INT NOT NULL,
  pID   INT NOT NULL,
  odQTY INT NOT NULL,
  PRIMARY KEY (oID, pID),

  CONSTRAINT fk_orderdetail_orders
    FOREIGN KEY (oID) REFERENCES Orders(oID)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

  CONSTRAINT fk_orderdetail_product
    FOREIGN KEY (pID) REFERENCES Product(pID)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,

  CONSTRAINT chk_orderdetail_qty CHECK (odQTY > 0)
);

-------------------------------------------------------------
Homework 1:

INSERT INTO Customer (cID, cName, cAge) VALUES
(1, 'Minh Quan', 10),
(2, 'Ngoc Oanh', 20),
(3, 'Hong Ha', 50);

INSERT INTO Orders (oID, cID, oDate) VALUES
(1, 1, '2006-03-21'),
(2, 2, '2006-03-23'),
(3, 1, '2006-03-16');

INSERT INTO Product (pID, pName, pPrice) VALUES
(1, 'May Giat', 3),
(2, 'Tu Lanh', 5),
(3, 'Dieu Hoa', 7),
(4, 'Quat', 1),
(5, 'Bep Dien', 2);

INSERT INTO OrderDetail (oID, pID, odQTY) VALUES
(1, 1, 3),
(1, 3, 7),
(1, 4, 2),
(2, 1, 1),
(3, 1, 8),
(2, 5, 4),
(2, 3, 3);

// Hiển thị các thông tin  gồm oID, oDate, oPrice của tất cả các hóa đơn trong bảng Order
SELECT oID, oDate, oTotalPrice AS oPrice
FROM Orders;

// Hiển thị danh sách các khách hàng đã mua hàng, và danh sách sản phẩm được mua bởi các khách
SELECT 
  c.cID, c.cName,
  o.oID, o.oDate,
  p.pID, p.pName,
  od.odQTY,
  p.pPrice,
  (od.odQTY * p.pPrice) AS lineTotal
FROM Customer c
JOIN Orders o       ON o.cID = c.cID
JOIN OrderDetail od ON od.oID = o.oID
JOIN Product p      ON p.pID = od.pID
ORDER BY c.cName, o.oID, p.pName;

// Hiển thị tên những khách hàng không mua bất kỳ một sản phẩm nào
SELECT DISTINCT c.cName
FROM Customer c
LEFT JOIN Orders o       ON o.cID = c.cID
LEFT JOIN OrderDetail od ON od.oID = o.oID
WHERE od.oID IS NULL;

// Hiển thị mã hóa đơn, ngày bán và giá tiền của từng hóa đơn (giá một hóa đơn được tính bằng tổng giá bán của từng loại mặt hàng xuất hiện trong hóa đơn. Giá bán của từng loại được tính = odQTY*pPrice)
SELECT
  o.oID,
  o.oDate,
  SUM(od.odQTY * p.pPrice) AS orderTotal
FROM Orders o
JOIN OrderDetail od ON od.oID = o.oID
JOIN Product p      ON p.pID = od.pID
GROUP BY o.oID, o.oDate
ORDER BY o.oID;

