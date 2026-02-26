use student_management;

create table class (
	ClassID int not null auto_increment primary key,
	ClassName VARCHAR(60) not null,
	StartDate DATETIME not null,
	Status BIT
)

create table Student (
	StudentId INT not null auto_increment primary key,
	StudentName VARCHAR(30) not null,
	Address VARCHAR(50),
	Phone VARCHAR(50),
	Status BIT,
	ClassID INT not null,
	foreign key (ClassID) references Class (ClassID)
)

create table Subject (
	SubID INT not null auto_increment primary key,
	SubName VARCHAR(30) not null,
	Credit tinyint not null default 1 check (Credit >=1),
	Status BIT default 1
)

create table Mark (
	MarkID INT not null auto_increment primary key,
	SubID INT not null,
	StudentId INT not null,
	Mark FLOAT default 0 check (Mark between 0 and 100),
	ExamTimes tinyint default 1,
	unique (SubID, StudentId),
	foreign key (SubID) references Subject (SubID),
	foreign key (StudentId) references Student (StudentId)
)

-------------------------------------------------------------
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





