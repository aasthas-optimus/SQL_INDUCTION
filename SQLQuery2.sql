CREATE DATABASE Company;

USE Company;
GO

--Create a table Employee
CREATE TABLE Employee
(Id INT PRIMARY KEY,
FirstName VARCHAR(25),
LastName VARCHAR(25),
Designation VARCHAR(25),
Age INT,
Salary INT NOT NULL,
Gender CHAR(1),
Active BIT DEFAULT 'TRUE',
CHECK (Age>20)
);

--Inserting values into Employee table
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

--Clustered index
CREATE INDEX FirstNameIndex on Employee(FirstName);

CREATE INDEX LastNameIndex on Employee(LastName);

--Create new table Designation
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
 
 --IN Operator
 SELECT * FROM Employee WHERE Salary IN(20000,30000);
 
 --Between
 SELECT * FROM Employee WHERE Salary BETWEEN 20000 AND 30000;
 
 --Alias
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

--AVG()
 SELECT * FROM Employee WHERE Salary>(SELECT AVG(Salary) FROM Employee);

--COUNT()
 SELECT COUNT(id) from Employee;

 SELECT COUNT(DepartmentId) FROM Department;

--MAX()
 SELECT * FROM Employee WHERE Salary<(SELECT MAX(Salary) FROM Employee);

--MIN()
 SELECT * FROM Employee WHERE Salary>(SELECT MIN(Salary) FROM Employee);

--SUM() function 
 SELECT SUM(Salary) AS TotalSalary FROM Employee;

--UPPER() function 
 SELECT FirstName,UPPER(LastName) FROM Employee;

--LOWER() function
 SELECT FirstName,LOWER(LastName) FROM Employee;

--LEN() Function
 SELECT LEN(FirstName) FROM Employee;

--GETDATE() function
 SELECT FirstName,GETDATE() FROM Employee;

--CAST(0 function 
 SELECT CAST(Id AS VARCHAR(10)) AS Result FROM Employee; 

-- Creating table Abc 
 CREATE TABLE Abc(EmployeeId int,Salary int);

-- Creating table Xyz 
 CREATE TABLE Xyz(EmployeeId int,Salary int);

--Creating table Pqr 
 CREATE TABLE Pqr(EmployeeId int,Salary int);

--Inserting values in table Abc 
 INSERT INTO Abc
 VALUES(1,20000);

 INSERT INTO Abc
 VALUES(3,70000);


 INSERT INTO Abc
 VALUES(2,25000);

--Inserting values in table Pqr 
 INSERT INTO Pqr
 VALUES(10,40000);

 INSERT INTO Pqr
 VALUES(13,70000);

 INSERT INTO Pqr
 VALUES(9,80000);

--Inserting values in table Xyz 
 INSERT INTO Xyz
 VALUES(99,10000);

 INSERT INTO Xyz
 VALUES(97,20000);

 INSERT INTO Xyz
 VALUES(100,60000);

 SELECT * FROM Employee;

--Display all employees of Abc,Pqr,Xyz using UNION 
 SELECT EmployeeId FROM Abc
 UNION
 SELECT EmployeeId FROM Pqr
 UNION
 SELECT EmployeeId FROM Xyz;

UPDATE Employee SET Salary=Salary+5000;

--SUM() function
SELECT SUM(Id) AS IdSum FROM Department WHERE Id IS NOT NULL;

DROP TABLE Department;

--Creating a table named Designation
CREATE TABLE Designation 
 (DesignationId INT PRIMARY KEY,
 Name VARCHAR(25),
 Id INT
 );
 
 --Insering values in table Designation
 INSERT INTO Designation
 VALUES(10,'UI',4);
 
 INSERT INTO Designation
 VALUES(11,'Dotnet',NULL);

 INSERT INTO Designation
 VALUES(12,'Testing','');

DELETE FROM Designation WHERE Name='Testing';

DELETE FROM Designation WHERE DesignationId=13;

INSERT INTO Designation
VALUES(13,'Java',2);

SELECT * FROM Designation;

--Left join
SELECT Employee.Id,DesignationId FROM Employee LEFT JOIN Designation ON Employee.Id=Designation.Id;

--Right join
SELECT Employee.Id,DesignationId FROM Employee RIGHT JOIN Designation ON Employee.Id=Designation.Id;

--Full outer join
SELECT Employee.Id,DesignationId FROM Employee FULL OUTER JOIN Designation ON Employee.Id=Designation.Id;

--Calculating pf as 12.75% of salary
ALTER TABLE Employee
ADD Pf varchar(25);

--Update the pf's as 12.75% of salary 
UPDATE Employee SET Pf=Salary*12.75;

--Rounding pf to two digits after decimal point 
SELECT FirstName,ROUND(Pf,2) AS Pf FROM Employee; 

--Creating a table named Manager 
Create TABLE Manager(Id int,Name varchar(25),Salary int);

--Inserting values in table Manager 
INSERT INTO Manager
VALUES(1,'Shikha',80000);
INSERT INTO Manager
VALUES(1,'Shubham',70000);
INSERT INTO Manager
VALUES(1,'Simran',70000);


--Create a view of details of managers where salary>60000
CREATE VIEW ManagerDetails AS 
SELECT * FROM Manager WHERE Salary>60000;

SELECT * FROM ManagerDetails;

CREATE VIEW v1 AS 
SELECT * FROM Employee WHERE Salary>20000 AND Designation=1;

SELECT * FROM v1;

--ISNULL() 
SELECT  DesignationId,ISNULL(Id,0) AS Id FROM Designation; 

--Adding a new column Status to table Employee 
ALTER TABLE EMPLOYEE ADD Status varchar(25);

--CASE STATEMENTS 
SELECT FirstName,Status=
CASE
WHEN Age<35 AND Salary>50000 THEN 'yes'
ELSE 'no'
END 
FROM Employee;

--Creating new table named ExamResult 
CREATE TABLE ExamResult(Name VARCHAR(50),SubjectName VARCHAR(20),Marks INT);

INSERT INTO ExamResult VALUES('Adam','Maths',70);

INSERT INTO ExamResult VALUES ('Adam','Science',80);

INSERT INTO ExamResult VALUES ('Adam','Social',60);

INSERT INTO ExamResult VALUES('Rak','Maths',60);

INSERT INTO ExamResult VALUES ('Rak','Science',50);

INSERT INTO ExamResult VALUES ('Rak','Social',70);

INSERT INTO ExamResult VALUES('Sam','Maths',90);

INSERT INTO ExamResult VALUES ('Sam','Science',90);

INSERT INTO ExamResult VALUES ('Sam','Social',80);

--Ranking functions
-- (a) 
SELECT * FROM(SELECT *,
RANK() OVER( ORDER BY Salary DESC)Temp
FROM Employee )AS Rank WHERE Rank.Temp<=3;

-- (b) 
SELECT * FROM(SELECT *,
ROW_NUMBER() OVER( ORDER BY Salary DESC)Temp
FROM Employee )AS Rank WHERE (Rank.Temp)%2=1;


--Common table expression 
WITH EmployeeCte(Salary,Id)
AS(SELECT Salary,Id 
FROM Employee)
SELECT SUM(Id) FROM EmployeeCte ;

--Creating table Sales
CREATE TABLE Sales (EmpId INT, Yr INT, Sales MONEY)

INSERT INTO Sales VALUES(1, 2005, 12000);

INSERT INTO Sales VALUES(1, 2006, 18000);

INSERT INTO Sales VALUES(1, 2007, 25000);

INSERT INTO Sales VALUES(2, 2005, 15000);

INSERT INTO Sales VALUES(2, 2006, 6000);

INSERT INTO Sales VALUES(3, 2006, 20000);

INSERT INTO Sales VALUES(3, 2007, 24000);

--Roll up
SELECT Yr,EmpId,SUM(Sales) AS Sales FROM Sales GROUP BY Yr,EmpId WITH ROLLUP;


--Cube
SELECT Yr,SUM(Sales) AS Sales FROM Sales GROUP BY Yr,EmpId WITH CUBE;

--Adding new column experience to Employee table
ALTER TABLE Employee ADD Experience VARCHAR(25);

UPDATE Employee SET Experience=4 WHERE Id=1;

UPDATE Employee SET Experience=2 WHERE Id=4;

UPDATE Employee SET Experience=4 WHERE Id=5;

UPDATE Employee SET Experience=7 WHERE Id=6;

DELETE FROM Employee WHERE Id=2;

--Intersect
SELECT * FROM Employee 
INTERSECT
SELECT * FROM Employee WHERE Experience<6;

--Except
SELECT * FROM Employee 
EXCEPT
SELECT * FROM Employee WHERE Experience>=6;

--Correlated subquery
SELECT * FROM (SELECT *,ROW_NUMBER()OVER( ORDER BY Id)Row FROM Employee) AS Temp WHERE Temp.Row<=3;

--Running aggregates
SELECT Temp.Id, Temp.Salary, 
(SELECT SUM(Temp2.Salary) 
FROM Employee Temp2
WHERE Temp2.Id <= Temp.Id)AS RunningTotal
FROM   Employee Temp
ORDER BY Temp.Id;

--NonClustered index
CREATE NONCLUSTERED INDEX EmpNonClusIndex ON Employee(Salary);

--Creating a new table
CREATE TABLE EmployeeSalary(Basic INT,HR INT,DA INT,GrossSalary INT);

--Triggers
CREATE TRIGGER EmployeeTrigger
ON EmployeeSalary AFTER INSERT
AS
	BEGIN
		UPDATE EmployeeSalary
		SET GrossSalary=(Basic+HR+DA)*12;
	END;
INSERT INTO EmployeeSalary (Basic,HR,DA) VALUES(100,46,78);

INSERT INTO EmployeeSalary (Basic,HR,DA) VALUES(90,44,78);

INSERT INTO EmployeeSalary (Basic,HR,DA) VALUES(109,46,73);

INSERT INTO EmployeeSalary (Basic,HR,DA) VALUES(198,46,75);

SELECT * FROM EmployeeSalary;

--Adding a new column to employee table
ALTER TABLE Employee ADD Year int;

UPDATE Employee SET Year=2009 WHERE Id=1;

UPDATE Employee SET Year=1990 WHERE Id=6;

UPDATE Employee SET Year=2015 WHERE Id=4;

UPDATE Employee SET Year=2000 WHERE Id=5;

--Function to find leap year or not
DECLARE @Num INT;
CREATE FUNCTION Leap(@Num INT)
RETURNS NVARCHAR(MAX)
AS
	BEGIN
		DECLARE @Temp NVARCHAR(MAX);
		IF(@Num%400=0 )
		  SET @Temp='LEAP YEAR';
		ELSE IF(@Num%100=0)
			SET @Temp= 'NOT A LEAP YEAR';
		ELSE IF(@Num%4=0)
			SET @Temp='LEAP YEAR'; 
		ELSE
			SET @Temp='NOT A LEAP YEAR';
		RETURN @Temp;
	END;
GO
SELECT dbo.Leap(100) as Result;

--Cursors

UPDATE EmployeeSalary SET GrossSalary='';

DECLARE @Cbasic INT,@Chr INT,@Cda INT;

DECLARE EmployeeCursorr CURSOR FOR
SELECT Basic,HR,DA FROM EmployeeSalary;
	BEGIN
	   OPEN EmployeeCursorr;
	   FETCH NEXT FROM EmployeeCursorr into @Cbasic,@Chr,@Cda;
	   UPDATE EmployeeSalary
	   SET GrossSalary=(Basic+HR+DA)*12;
	   CLOSE EmployeeCursorr;
	END;
SELECT * FROM EmployeeSalary;

--Stored procedures
DECLARE @empNum INT;
CREATE PROCEDURE GetEmpInfoo(@empNum INT)
AS
	BEGIN
		SELECT * FROM Employee 
		WHERE Id = @empNum ;
	END
EXECUTE GetEmpInfoo 1;

--Exception handling
DECLARE @Dividend INT,@Divisor INT;
CREATE PROCEDURE DivideZero(@Dividend INT,@Divisor INT)
AS
	BEGIN
		BEGIN TRY

			SELECT @Dividend/@Divisor
		END TRY
		BEGIN CATCH
			SELECT
				ERROR_NUMBER() AS ErrorNumber
				,ERROR_SEVERITY() AS ErrorSeverity
				,ERROR_STATE() AS ErrorState
				,ERROR_PROCEDURE() AS ErrorProcedure
				,ERROR_LINE() AS ErrorLine
				,ERROR_MESSAGE() AS ErrorMessage;
		END CATCH;
	END
GO
Execute DivideZero @Dividend=100,@Divisor=0;

	
	




