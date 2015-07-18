Create Database Assignment2;

USE Assignment2;
GO
--TABLE EmployeeMaster
CREATE TABLE EmployeeMaster(
EmpID INT PRIMARY KEY IDENTITY(1001,2),
EmpCode VARCHAR(25),
EmpFName VARCHAR(25) NOT NULL,
EmpMName VARCHAR(25),
EmpLName VARCHAR(25),
EmpDOB DATE CONSTRAINT ChkDate CHECK ((YEAR(GETDATE())-YEAR(EmpDOB))>=18),
EmpDOJ DATE NOT NULL
);

INSERT INTO EmployeeMaster VALUES('OPT20110105','Manmohan','','Singh','1983-02-10','2010-05-25');
INSERT INTO EmployeeMaster VALUES('OPT20110915','Alfred','Joseph','Lawrence','1988-02-28','2009-05-26');

SELECT * FROM EmployeeMaster;
--Table TActivity
CREATE TABLE TActivity(
ActivityID INT PRIMARY KEY,
ActivityDescription VARCHAR(25)
);

INSERT INTO TActivity VALUES(1,'Code Analysis');

INSERT INTO TActivity VALUES(2,'Lunch');

INSERT INTO TActivity VALUES(3,'Coding');

INSERT INTO TActivity VALUES(4,'Knowledge Transition');

INSERT INTO TActivity VALUES(5,'Database');

SELECT * FROM TActivity;

--Table TAttenDet
CREATE TABLE TAttenDet(
AttenID INT IDENTITY(1001,1) PRIMARY KEY,
EmpID INT CONSTRAINT FKEmp FOREIGN KEY REFERENCES EmployeeMaster(EmpID),
ActivityID INT CONSTRAINT FKAct FOREIGN KEY REFERENCES TActivity(ActivityID),
AttenStartDateTime DATETIME ,
AteendanceEndHrs INT
);

INSERT INTO TAttenDet VALUES(1001,5,'2011-02-13 10:00:00',2);

INSERT INTO TAttenDet VALUES(1001,1,'2011-01-14 10:00:00',3);

INSERT INTO TAttenDet VALUES(1001,3,'2011-01-14 13:00:00',5);

INSERT INTO TAttenDet VALUES(1003,5,'2011-02-16 10:00:00',8);

INSERT INTO TAttenDet VALUES(1003,5,'2011-02-17 10:00:00',8);

INSERT INTO TAttenDet VALUES(1003,5,'2011-02-19 10:00:00',7);

--Table TSalary
CREATE TABLE TSalary(
SalaryID INT PRIMARY KEY,
EmpID INT CONSTRAINT FKEmpSal FOREIGN KEY REFERENCES EmployeeMaster(EmpID) ,
ChangedDate DATE,
NewSalary  INT
);

INSERT INTO TSalary VALUES(1001,1003,'2011-02-16',20000);

INSERT INTO TSalary VALUES(1002,1003,'2011-01-05',20000);

INSERT INTO TSalary VALUES(1003,1001,'2011-02-16',20000);

UPDATE TSalary SET NewSalary=25000 WHERE SalaryID=1002;

UPDATE TSalary SET NewSalary=26000 WHERE SalaryID=1003;

SELECT * FROM TSalary;

--QUESTION1
 SELECT (EmpFName+' '+EmpMName+' '+EmpLName)AS FullName,EmpDOB FROM
	(SELECT EmpFName,EmpMName,EmpLName,EmpDOB=
	CASE 
	WHEN MONTH(EmpDOB)IN(1,3,5,7,8,10,12) AND DAY(EmpDOB)='31'
	THEN CONVERT(VARCHAR(25),EmpDOB,105)
	WHEN MONTH(EmpDOB)IN(4,6,9,11,12) AND DAY(EmpDOB)='30'
	THEN CONVERT(VARCHAR(25),EmpDOB,105)
	WHEN MONTH(EmpDOB) IN(2) AND ((YEAR(EmpDOB)%400=0)OR (YEAR(EmpDOB)%4=0 AND YEAR(EmpDOB)%100=0))AND DAY(EmpDOB)=29 
	THEN CONVERT(VARCHAR(25),EmpDOB,105)
	ELSE ''
	END
	FROM EmployeeMaster)AS Temp WHERE Temp.EmpDOB!='';


UPDATE EmployeeMaster SET EmpDOB='1983-02-10' WHERE EmpID=1001;

UPDATE EmployeeMaster SET EmpDOB='1988-02-28' WHERE EmpID=1003;

--QUESTION2

SELECT (EmpFName+' '+EmpMName+' '+EmpLName) AS Name,
Increment,PreviousSalary,CurrentSalary, TotalWorkedHours,
Sub2.ActivityID AS LastWorkedId, Sub2.AteendanceEndHrs AS LastHourWorked
FROM(
SELECT EmpID,
CASE
	WHEN COUNT(EmpId)>1 
	THEN 'Yes'
	ELSE 'No'
END AS Increment,
CASE
	WHEN COUNT(EmpId)>1 
	THEN MIN(NewSalary)
	ELSE 0
END AS PreviousSalary,
MAX(NewSalary) AS CurrentSalary
FROM TSalary
GROUP BY EmpID) AS Subquery1

JOIN EmployeeMaster
ON EmployeeMaster.EmpId=Subquery1.EmpID

JOIN
(
SELECT EmpID, SUM(AteendanceEndHrs)AS TotalWorkedHours
FROM TAttenDet
GROUP BY EmpID
) AS Subquery2
ON Subquery1.EmpId=Subquery2.EmpId


JOIN  (SELECT Sub1.EmpID,ActivityID,AteendanceEndHrs 
       FROM TAttenDet AS Sub1
	   JOIN (SELECT EmpId, MAX(AttenStartDateTime)m  
	   FROM TAttenDet GROUP BY EmpId)AS Sub
	   ON Sub.EmpId=Sub1.EmpId 
	   WHERE Sub1.AttenStartDateTime=Sub.m) AS Sub2
ON Sub2.EmpId=EmployeeMaster.EmpID





