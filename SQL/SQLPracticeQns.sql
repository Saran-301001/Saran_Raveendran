Create Database dummy;

use dummy;

Create Table EmployeeTable ( EmployeeId INT primary key,
 EmployeeName Varchar(50),
 Gender Varchar(50),
 DOB DATE, 
 DOJ DATE,
 Designation Varchar(50),
 DepartmentID Varchar(50),
 Salary DECIMAL(10,2) CHECK (Salary > 0),
 PhoneNo Varchar(50));
 
 -- Below in the column EmployeeName NOT NULL Constraint is enforced.
 ALTER Table EmployeeTable
 MODIFY Column EmployeeName Varchar(50) NOT NULL;
 
  ALTER Table EmployeeTable
 MODIFY Column Gender Varchar(50) NOT NULL, 
 MODIFY Column DOB DATE NOT NULL;
 
ALTER Table EmployeeTable
MODIFY Column DOJ DATE NOT NULL,
MODIFY Column Designation Varchar(50) NOT NULL,
MODIFY Column Salary DECIMAL(10,2) CHECK (Salary > 0) NOT NULL,
MODIFY Column PhoneNO Varchar(50) NOT NULL;

Select * from EmployeeTable;

Create Table Department(
DepartmentID INT Primary KEY,
DepartmentName Varchar(50) NOT NULL);


Alter Table EmployeeTable
Add Constraint fk_DepartmentID Foreign Key (DepartmentID) References Department(DepartmentID);

Alter Table EmployeeTable
Modify Column DepartmentId INT;

Alter Table EmployeeTable
Add Constraint fk_DepartmentID Foreign Key (DepartmentID) References Department(DepartmentID);

Insert into Department(DepartmentID, DepartmentName) Values
(1, "D&A"),
(2, "IAS"),
(3, "Insurance"),
(4, "Testing"),
(5, "ES"),
(6, ".NET"),
(7, "EI"); -- This has a child row

Insert Into EmployeeTable ( EmployeeId,EmployeeName, Gender, DOB, DOJ, Designation, DepartmentId, Salary, PhoneNO)
Values (001, "Chandra", "Male", '2001-11-20', '2024-11-08',"Project Manager", 1, 20000, 9080204578);

Select * From EmployeeTable;

Alter Table EmployeeTable
Modify Column PhoneNO Varchar(50) Unique;

Insert Into EmployeeTable ( EmployeeId,EmployeeName, Gender, DOB, DOJ, Designation, DepartmentId, Salary, PhoneNO)
Values (002, "Mukesh", "Male", '2001-05-21', '2024-11-08',"Project Lead", 1, 25000, 9080204578); -- This doesn't work because of unique constraint

Insert Into EmployeeTable ( EmployeeId,EmployeeName, Gender, DOB, DOJ, Designation, DepartmentId, Salary, PhoneNO)
Values (002, "Mukesh", "Male", '2001-05-21', '2024-11-08',"Project Lead", 1, 25000, 9080204579); 

Select * From EmployeeTable;

Select * From Department;

Delete from EmployeeTable where EmployeeId = 002;

INSERT INTO EmployeeTable (EmployeeId, EmployeeName, Gender, DOB, DOJ, Designation, DepartmentId, Salary, PhoneNo)
VALUES 
(002, "Subash", "Male", '1998-05-15', '2024-01-10', "Software Engineer", 2, 15000, 9012345678),
(003, "Janani", "Female", '1995-08-25', '2023-05-20', "Analyst", 3, 18000, 9123456789),
(004, "Saran", "Male", '2000-10-10', '2022-11-15', "Tester", 4, 14000, 9234567890),
(005, "Sandhiya", "Female", '1997-03-30', '2020-04-01', "Developer", 6, 22000, 9345678901),
(006, "Bharath", "Male", '1996-07-18', '2019-08-25', "Senior Developer", 6, 25000, 9456789012),
(007, "Vaishnavi", "Female", '1999-12-12', '2021-03-05', "Consultant", 5, 17000, 9567890123),
(008, "Mukesh", "Male", '1993-11-01', '2018-06-18', "Engineer", 7, 19000, 9678901234);

-- 1. Write a query to display all rows and columns from the employees table.

Select * From EmployeeTable;

-- 2. Retrieve only the name and salary of all employees from the employees table.

Select EmployeeName, Salary From EmployeeTable;

-- 3. Write a query to find all employees whose salary is greater than 15,000.

Select EmployeeName From EmployeeTable
WHERE Salary > 15000;

-- 4. List all employees who joined the company in the year 2020.

Select EmployeeName From EmployeeTable
Where Year(DOJ) = 2020;

-- 5. Retrieve the details of employees whose names End with the letter 'A'.

Select EmployeeName From EmployeeTable
Where EmployeeName LIKE '%A';

-- For Start with Letter 'A' We use A% 

-- Aggregate Functions

-- 1. Write a query to calculate the average salary of all employees.

Select avg(Salary) as Average_Salary From EmployeeTable;

-- 2. Find the total number of employees in the company.

Select Count(*) as No_of_Employees from EmployeeTable;

-- 3. Write a query to find the highest salary in the employees table.

Select Max(Salary) as Highest_Salary, EmployeeName from EmployeeTable;

-- 4. Calculate the total salary paid by the company for all employees.

Select Sum(Salary) as Total_Salary_Paid_By_Company From EmployeeTable;

-- 5. Find the count of employees in each department.

SELECT d.DepartmentName, COUNT(e.EmployeeId) AS EmployeeCount
FROM EmployeeTable e
JOIN Department d ON e.DepartmentId = d.DepartmentID
GROUP BY d.DepartmentName;

-- Joins

-- 1. Write a query to retrieve employee names along with their department names (using employees and departments tables).

Select e.Employeename, d.DepartmentName
From EmployeeTable e
Join Department d ON e.DepartmentID = d.DepartmentID;


CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL
);

CREATE TABLE EmployeeProject (
    EmployeeId INT,
    ProjectID INT,
    FOREIGN KEY (EmployeeId) REFERENCES EmployeeTable(EmployeeId),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
    PRIMARY KEY (EmployeeId, ProjectID)
);

INSERT INTO Project (ProjectID, ProjectName)
VALUES (1, 'Project Alpha'), (2, 'Project Beta'), (3, 'Project Gamma');

-- Assign Employees to Projects
INSERT INTO EmployeeProject (EmployeeId, ProjectID)
VALUES 
(1, 1), (2, 1), (2, 2), (3, 3), (4, 1), (4, 3);

Alter Table EmployeeTable
Add Column ManagerID INT;

Select * From EmployeeTable;

Create Table ManagerTable(
ManagerName Varchar(50),
ManagerID Int);

Insert into ManagerTable(ManagerName, ManagerID) Values
('John', 2),
('Muthu', 3),
('Raj', 4);

UPDATE EmployeeTable
SET ManagerId = 1
WHERE EmployeeId = 2;

UPDATE EmployeeTable
SET ManagerId = NULL
WHERE EmployeeId = 1;

UPDATE EmployeeTable
SET ManagerId = 1
WHERE EmployeeId IN (2, 3, 4);

UPDATE EmployeeTable
SET ManagerId = 2
WHERE EmployeeId IN (5, 6);

UPDATE EmployeeTable
SET ManagerId = 3
WHERE EmployeeId IN (7);

UPDATE EmployeeTable
SET ManagerId = 4
WHERE EmployeeId IN (8);

Select * From EmployeeTable;

-- 2. List all employees who have a manager (self-join on employees table).
SELECT e.EmployeeName AS Employee
FROM EmployeeTable e
WHERE e.ManagerId IS NOT NULL;


-- 3. Find the names of employees who are working on multiple projects (using employees and projects tables).

Select * From project;

ALTER TABLE EmployeeTable
ADD ProjectID INT;

ALTER TABLE EmployeeTable
ADD CONSTRAINT FK_Project FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID);

Update EmployeeTable 
SET 
ProjectID = 1
Where EmployeeID IN (1,2,3);

ALTER TABLE EmployeeTable
DROP FOREIGN KEY FK_Project;


ALTER TABLE EmployeeTable
DROP COLUMN ProjectID;


CREATE TABLE EmployeeProject (
    EmployeeId INT,
    ProjectID INT,
    PRIMARY KEY (EmployeeId, ProjectID),
    FOREIGN KEY (EmployeeId) REFERENCES EmployeeTable(EmployeeId),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

INSERT INTO EmployeeProject (EmployeeId, ProjectID)
VALUES 
(2, 1),
(2, 2); 

Insert Into EmployeeProject (EmployeeId,ProjectID)
Values
(1, 3),
(1, 2),
(3, 1),
(4, 2),
(6, 3);

Select * From EmployeeProject;

Select * From EmployeeTable;

SELECT e.EmployeeName
FROM EmployeeTable e
JOIN EmployeeProject ep ON e.EmployeeId = ep.EmployeeId
GROUP BY e.EmployeeId, e.EmployeeName
HAVING COUNT(ep.ProjectID) > 1;


-- 4. Write a query to display all projects and the employees assigned to them.

SELECT p.ProjectName, e.EmployeeName
FROM Project p
LEFT JOIN EmployeeProject ep ON p.ProjectID = ep.ProjectID
LEFT JOIN EmployeeTable e ON ep.EmployeeId = e.EmployeeId;

-- 5. Retrieve the names of employees who do not belong to any department.
SELECT EmployeeName
FROM EmployeeTable
WHERE DepartmentId IS NULL;


-- Subqueries

-- 1. Write a query to find the employees with the second-highest salary.

SELECT EmployeeName
FROM EmployeeTable
ORDER BY Salary DESC
LIMIT 1 OFFSET 1;

-- or

SELECT EmployeeName
FROM EmployeeTable
WHERE Salary = (
    SELECT MAX(Salary)
    FROM EmployeeTable
    WHERE Salary < (SELECT MAX(Salary) FROM EmployeeTable)
);

-- 2. Retrieve the names of employees whose salary is above the department average salary.

SELECT e.EmployeeName, d.DepartmentName
FROM EmployeeTable e
JOIN Department d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM EmployeeTable e2
    WHERE e2.DepartmentID = e.DepartmentID
);

-- 3. Find employees who earn more than the average salary of the entire company.

SELECT EmployeeName, Salary
FROM EmployeeTable
WHERE Salary > (
    SELECT AVG(Salary)
    FROM EmployeeTable
);

-- 4. Write a query to find the department with the highest number of employees.

SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount
FROM Department d
JOIN EmployeeTable e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
ORDER BY EmployeeCount DESC
LIMIT 1;

-- 5. List all employees who work in a department located in 'New York'.

Alter Table department
Add column Location Varchar(50) NOT NULL;

Update department 
Set
Location = "New York"
Where DepartmentID in (1,5,6);

Update department 
Set
Location = "Los Angles"
Where DepartmentID in (2, 3);

Update department 
Set
Location = "Chennai"
Where DepartmentID in (4,7);

Select * From Department;

SELECT e.EmployeeName, d.DepartmentName, Location
FROM EmployeeTable e
JOIN Department d ON e.DepartmentID = d.DepartmentID
WHERE d.Location = 'New York';

-- Set Operators

-- 1. Write a query to find employees who work in either the 'D&A' or 'IAS' department.

SELECT e.EmployeeName, d.DepartmentName
FROM EmployeeTable e
JOIN Department d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('D&A', 'IAS');


-- 2. Retrieve the names of employees who are working on both Project Alpha and Project Beta.

SELECT e.EmployeeName
FROM EmployeeTable e
JOIN EmployeeProject ep ON e.EmployeeId = ep.EmployeeId
JOIN Project p ON ep.ProjectID = p.ProjectID
WHERE p.ProjectName IN ('Project Alpha', 'Project Beta')
GROUP BY e.EmployeeId, e.EmployeeName
HAVING COUNT(DISTINCT p.ProjectName) = 2;


-- 3. Find employees who are not assigned to any project.

SELECT e.EmployeeName
FROM EmployeeTable e
WHERE NOT EXISTS (
    SELECT 1
    FROM EmployeeProject ep
    WHERE ep.EmployeeId = e.EmployeeId
);

-- 4. Write a query to get all unique job titles across all departments.

SELECT DISTINCT Designation
FROM EmployeeTable;

-- 5. Combine two tables (employees and former_employees) and remove duplicates.

CREATE TABLE former_employees (
    EmployeeId INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Gender VARCHAR(50),
    DOB DATE,
    DOJ DATE,
    Designation VARCHAR(100),
    DepartmentID VARCHAR(50),
    Salary DECIMAL(10, 2),
    PhoneNo VARCHAR(50)
);

SELECT EmployeeId, EmployeeName, Gender, DOB, DOJ, Designation, DepartmentID, Salary, PhoneNo
FROM (
    SELECT EmployeeId, EmployeeName, Gender, DOB, DOJ, Designation, DepartmentID, Salary, PhoneNo
    FROM EmployeeTable
    
    UNION ALL
    
    SELECT EmployeeId, EmployeeName, Gender, DOB, DOJ, Designation, DepartmentID, Salary, PhoneNo
    FROM former_employees
) AS CombinedResults
GROUP BY EmployeeId;

-- 1. Write a query to add a new employee to the employees table.

Insert into employeetable (EmployeeId, EmployeeName, Gender, DOB, DOJ, Designation, DepartmentId, Salary, PhoneNO, ManagerID)
Values
(9, "Goutham", "Male", "2001-11-22", "2020-05-16", "Assistant engineer", 3, 22000, 8978986745, 1);

-- 2. Update the salary of all employees in the 'D&A' department by 10%.

UPDATE EmployeeTable e
JOIN Department d ON e.DepartmentID = d.DepartmentID
SET e.Salary = e.Salary * 1.10
WHERE d.DepartmentName = 'D&A';


-- 3. Delete all employees who have not worked for more than 1 years.
Set SQl_SAFE_UPDATEs = 0;

DELETE FROM EmployeeTable
WHERE TIMESTAMPDIFF(YEAR, DOJ, CURDATE()) <= 2;

DELETE FROM employeeproject
WHERE EmployeeId IN (
    SELECT EmployeeId
    FROM EmployeeTable
    WHERE TIMESTAMPDIFF(YEAR, DOJ, CURDATE()) <= 2
);

DELETE FROM EmployeeTable
WHERE TIMESTAMPDIFF(YEAR, DOJ, CURDATE()) <= 2;

-- 4. Create a new table departments_backup with the same structure as the departments table.

CREATE TABLE departments_backup LIKE department;

-- 5. Drop the temporary_data table from the database.
