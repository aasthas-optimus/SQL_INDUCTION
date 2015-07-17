CREATE DATABASE Assignment;

USE Assignment;
GO

--Creating table TProductMaster
CREATE TABLE TProductMaster
(ProductID VARCHAR(25) PRIMARY KEY,ProductName VARCHAR(25),CostPerItem INT);

INSERT INTO  TProductMaster
VALUES('P1','Pen',10);

INSERT INTO TProductMaster
VALUES('P2','Scale',15);

INSERT INTO  TProductMaster
VALUES('P3','Note Book',25);

SELECT * FROM TProductMaster;

--Creating table TUserMaster
CREATE TABLE TUserMaster
(UserID VARCHAR(25)PRIMARY KEY,UserName VARCHAR(25));

INSERT INTO  TUserMaster
VALUES('U1','Alfred Lawrence');

INSERT INTO  TUserMaster
VALUES('U2','William Paul');

INSERT INTO  TUserMaster
VALUES('U3','Edward Fillip');

SELECT * FROM TUserMaster;

--Creating table TTransaction
CREATE TABLE TTransaction
(UserID VARCHAR(25)FOREIGN KEY REFERENCES TUserMaster(UserID),
ProductID VARCHAR(25)FOREIGN KEY REFERENCES TProductMaster(ProductID),
TransactionDate Date,TransactionType VARCHAR(25),
TransactionAmount INT );

INSERT INTO TTransaction
VALUES('U1','P1','2010-10-25','Order',150);

INSERT INTO TTransaction
VALUES('U1','P1','2010-11-20','Payment',750);

INSERT INTO TTransaction
VALUES('U1','P1','2010-11-20','Order',200);

INSERT INTO TTransaction
VALUES('U1','P3','2010-11-25','Order',50);

INSERT INTO TTransaction
VALUES('U3','P2','2010-11-26','Order',100);

INSERT INTO TTransaction
VALUES('U2','P1','2010-12-15','Order',75);

INSERT INTO TTransaction
VALUES('U3','P2','2011-01-15','Payment',250);

SELECT * FROM TTransaction;

SELECT convert(VARCHAR(25), TransactionDate, 105) AS TransactionDate FROM TTransaction ;

--Assinment DBO1
SELECT UserName,ProductName,OrderedQuantity,AmountPaid,LastTransactionDate,Balance 
FROM
	(SELECT TTransaction.ProductID,TTransaction.UserID, 
	
	SUM(
	CASE 
	WHEN TransactionType='Order'
	THEN TransactionAmount
	END) AS Orderedquantity,
	
	SUM(
	CASE 
	WHEN TransactionType='Payment'
	THEN TransactionAmount
	ELSE 0
	END) AS AmountPaid,
	
	CONVERT(VARCHAR(20),MAX(TransactionDate),105) AS LastTransactionDate,
	
	SUM(
	 CASE 
	 WHEN TransactionType='Order'
	 THEN TProductMaster.CostPerItem*TransactionAmount 
	 ELSE -TransactionAmount
	 END)AS Balance
	 
	 FROM TTransaction
	 
	 JOIN TProductMaster  ON TTransaction.ProductID=TProductMaster.ProductID 
	 
	 GROUP BY TTransaction.UserID,TTransaction.ProductID) AS S
	 
	 JOIN TProductMaster  ON S.ProductID=TProductMaster.ProductID 
	 
	 JOIN TUserMaster ON S.UserID=TUserMaster.UserID ;
	 
 
 
  
