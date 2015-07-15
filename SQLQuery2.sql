CREATE DATABASE Company;
USE Company;
GO
CREATE TABLE Employee
(Id INT PRIMARY KEY,
FirstName VARCHAR(25),
LastName VARCHAR(25),
Designation VARCHAR(25),
Age int,
Salary INT NOT NULL,
Gender CHAR(1),
Active BIT DEFAULT 'TRUE',
CHECK (Age>20)
);
INSERT INTO Employee
VALUES(1,'Aastha','Sharma','Trainee',21,25000,'F','TRUE');
INSERT INTO Employee
VALUES(2,'Swati','Gakhar','Trainee',22,30000,'F','TRUE');
INSERT INTO Employee
VALUES(6,'Nipun','Chawla','HR',23,50000,'M','TRUE');
INSERT INTO Employee
VALUES(5,'Vaishali','Taneja','Manager',25,40000,'F','TRUE');
INSERT INTO Employee
VALUES(4,'Rishabh','Sethi','Tech lead',21,20000,'M','TRUE');
SELECT * FROM Employee;
CREATE INDEX FirstNameIndex on Employee(FirstName);
CREATE INDEX LastNameIndex on Employee(LastName);
CREATE TABLE Designation
(Id INT,
 Name VARCHAR(25)
 );
 DROP TABLE Designation;
 UPDATE Employee 
 SET Designation=4 WHERE Designation='Trainee';
 UPDATE Employee 
 SET Designation=1 WHERE Designation='HR';
 UPDATE Employee 
 SET Designation=2 WHERE Designation='Manager';
 UPDATE Employee 
 SET Designation=3 WHERE Designation='Tech lead';
 ALTER TABLE Employee 
 ALTER COLUMN Designation int;
 SELECT * FROM Employee WHERE Salary IN(20000,30000);
 SELECT * FROM Employee WHERE Salary BETWEEN 20000 AND 30000;
 SELECT FirstName as Name FROM Employee;
 CREATE TABLE Department 
 (DepartmentId INT PRIMARY KEY,
 Name VARCHAR(25),
 Id INT
 );
 INSERT INTO Department
VALUES(10,'UI',4);
INSERT INTO Department
VALUES(11,'Dotnet',NULL);
INSERT INTO Department
VALUES(12,'Testing','');
DELETE FROM Department WHERE Name='Testing';
DELETE FROM Department WHERE DepartmentId=13;
INSERT INTO Department
VALUES(13,'Java',2);
SELECT * FROM Department;
SELECT * FROM Employee WHERE Salary>(SELECT AVG(Salary) FROM Employee);
SELECT COUNT(id) from Employee;
SELECT COUNT(DepartmentId) FROM Department;
SELECT * FROM Employee WHERE Salary<(SELECT MAX(Salary) FROM Employee);
SELECT * FROM Employee WHERE Salary>(SELECT MIN(Salary) FROM Employee);
SELECT SUM(Salary) AS TotalSalary FROM Employee;
SELECT FirstName,UPPER(LastName) FROM Employee;
SELECT FirstName,LOWER(LastName) FROM Employee;
SELECT LEN(FirstName) FROM Employee;
SELECT FirstName,GETDATE() FROM Employee;
SELECT CAST(Id AS VARCHAR(10)) AS Result FROM Employee; 