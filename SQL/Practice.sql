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


DELIMITER $$

CREATE PROCEDURE calculate_factorial(IN num INT)
BEGIN
    DECLARE fact INT DEFAULT 1;
    DECLARE i INT DEFAULT 1;

    -- Loop to calculate the factorial
    WHILE i <= num DO
        SET fact = fact * i;
        SET i = i + 1;
    END WHILE;

    -- Return the factorial
    SELECT fact AS 'Factorial';
END $$

DELIMITER ;

CALL calculate_factorial(5);

                                           
CREATE TABLE FibonacciSeries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fibonacci_term INT
);

DELIMITER $$



CREATE PROCEDURE insert_fibonacci_series(IN n INT)
BEGIN
    DECLARE a INT DEFAULT 0;  -- First Fibonacci term
    DECLARE b INT DEFAULT 1;  -- Second Fibonacci term
    DECLARE temp INT;         -- Temporary variable for swapping
    DECLARE i INT DEFAULT 1;

    -- Loop to calculate and insert Fibonacci series
    WHILE i <= n DO
        INSERT INTO FibonacciSeries (fibonacci_term) VALUES (a);  -- Insert the Fibonacci number
        SET temp = a;
        SET a = b;
        SET b = temp + b;
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

CALL insert_fibonacci_series(10);  -- Change 10 to the number of terms you want
SELECT * FROM FibonacciSeries;


DELIMITER $$

CREATE PROCEDURE reverse_string(IN input_string VARCHAR(255))
BEGIN
    DECLARE reversed_string VARCHAR(255) DEFAULT '';
    DECLARE string_length INT;
    DECLARE i INT;

    -- Get the length of the input string
    SET string_length = CHAR_LENGTH(input_string);
    SET i = string_length;

    -- Loop through the string in reverse order and append characters to reversed_string
    WHILE i > 0 DO
        SET reversed_string = CONCAT(reversed_string, SUBSTRING(input_string, i, 1));
        SET i = i - 1;
    END WHILE;

    -- Return the reversed string
    SELECT reversed_string AS 'Reversed String';
END $$

DELIMITER ;

CALL reverse_string('Hello World');


DELIMITER $$

CREATE PROCEDURE sum_of_digits(IN input_number INT)
BEGIN
    DECLARE sum INT DEFAULT 0;
    DECLARE digit INT;

    -- Loop to extract each digit from the number and add it to the sum
    WHILE input_number > 0 DO
        SET digit = input_number % 10;  -- Get the last digit
        SET sum = sum + digit;          -- Add the digit to the sum
        SET input_number = input_number DIV 10;  -- Remove the last digit
    END WHILE;

    -- Output the result
    SELECT CONCAT('Sum of digits: ', sum) AS result;
END $$

DELIMITER ;

CALL sum_of_digits(12345);  -- Change this number to test with other inputs


DELIMITER $$

CREATE PROCEDURE get_employee_salaries()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_name VARCHAR(50);
    DECLARE emp_salary DECIMAL(10, 2);

    -- Declare the cursor
    DECLARE employee_cursor CURSOR FOR
        SELECT EmployeeName, Salary
        FROM EmployeeTable;

    -- Declare the handler for when the cursor reaches the end
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN employee_cursor;

    -- Fetch and display employee details row by row
    read_loop: LOOP
        FETCH employee_cursor INTO emp_name, emp_salary;
        
        -- Exit the loop when all rows are fetched
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Display the employee name and salary
        SELECT CONCAT('Employee Name: ', emp_name, ', Salary: ', emp_salary) AS employee_details;
    END LOOP;

    -- Close the cursor
    CLOSE employee_cursor;
END $$

DELIMITER ;

CALL get_employee_salaries();

DELIMITER $$

CREATE PROCEDURE average_salary_per_department()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE dept_id VARCHAR(50);
    DECLARE dept_name VARCHAR(50);
    DECLARE avg_salary DECIMAL(10,2);

    -- Declare the cursor to get all unique departments
    DECLARE department_cursor CURSOR FOR 
        SELECT DISTINCT DepartmentID, DepartmentName
        FROM Department;

    -- Declare the handler to set the flag when the cursor reaches the end
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN department_cursor;

    -- Loop through each department
    read_loop: LOOP
        FETCH department_cursor INTO dept_id, dept_name;
        
        -- Exit loop if no more rows are found
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Calculate the average salary for the current department
        SELECT AVG(Salary) INTO avg_salary
        FROM EmployeeTable
        WHERE DepartmentID = dept_id;

        -- Display the department and its average salary
        SELECT CONCAT('Department: ', dept_name, ', Average Salary: ', avg_salary) AS department_salary;
    END LOOP;

    -- Close the cursor
    CLOSE department_cursor;
END $$

DELIMITER ;

CALL average_salary_per_department();

DELIMITER $$

CREATE PROCEDURE fetch_high_salary_employees()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(50);
    DECLARE emp_salary DECIMAL(10,2);

    -- Declare cursor to fetch employee details where salary is greater than 20,000
    DECLARE employee_cursor CURSOR FOR 
        SELECT EmployeeId, EmployeeName, Salary
        FROM EmployeeTable
        WHERE Salary > 20000;

    -- Declare handler for when the cursor finishes fetching all rows
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN employee_cursor;

    -- Loop through the rows fetched by the cursor
    read_loop: LOOP
        FETCH employee_cursor INTO emp_id, emp_name, emp_salary;
        
        -- Exit the loop if no more rows are found
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Display employee details
        SELECT CONCAT('Employee ID: ', emp_id, ', Employee Name: ', emp_name, ', Salary: ', emp_salary) AS Employee_Details;
    END LOOP;

    -- Close the cursor
    CLOSE employee_cursor;
END $$

DELIMITER ;

CALL fetch_high_salary_employees();

DELIMITER $$

CREATE PROCEDURE display_employees_by_doj()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(50);
    DECLARE emp_doj DATE;
    DECLARE emp_salary DECIMAL(10,2);

    -- Declare the cursor to fetch employee details ordered by their DOJ
    DECLARE employee_cursor CURSOR FOR 
        SELECT EmployeeId, EmployeeName, DOJ, Salary
        FROM EmployeeTable
        ORDER BY DOJ;

    -- Declare handler for when no rows are found
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN employee_cursor;

    -- Loop through each employee record
    read_loop: LOOP
        FETCH employee_cursor INTO emp_id, emp_name, emp_doj, emp_salary;
        
        -- Exit the loop when all rows are processed
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Display the employee details
        SELECT CONCAT('Employee ID: ', emp_id, ', Name: ', emp_name, ', DOJ: ', emp_doj, ', Salary: ', emp_salary) AS Employee_Details;
    END LOOP;

    -- Close the cursor
    CLOSE employee_cursor;
END $$

DELIMITER ;

CALL display_employees_by_doj();

CREATE TABLE EmployeeBackupTable (
    EmployeeId INT,
    EmployeeName VARCHAR(50),
    Gender VARCHAR(50),
    DOB DATE,
    DOJ DATE,
    Designation VARCHAR(50),
    DepartmentId VARCHAR(50),
    Salary DECIMAL(10,2),
    PhoneNo VARCHAR(50)
);

DELIMITER $$

CREATE PROCEDURE insert_employee_details()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE emp_id INT;
    DECLARE emp_name VARCHAR(50);
    DECLARE emp_gender VARCHAR(50);
    DECLARE emp_dob DATE;
    DECLARE emp_doj DATE;
    DECLARE emp_designation VARCHAR(50);
    DECLARE emp_department_id VARCHAR(50);
    DECLARE emp_salary DECIMAL(10,2);
    DECLARE emp_phone_no VARCHAR(50);

    -- Declare cursor to fetch employee details from EmployeeTable
    DECLARE employee_cursor CURSOR FOR 
        SELECT EmployeeId, EmployeeName, Gender, DOB, DOJ, Designation, DepartmentId, Salary, PhoneNo
        FROM EmployeeTable;

    -- Declare handler for when no more rows are found
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN employee_cursor;

    -- Loop through each employee record
    read_loop: LOOP
        FETCH employee_cursor INTO emp_id, emp_name, emp_gender, emp_dob, emp_doj, emp_designation, emp_department_id, emp_salary, emp_phone_no;
        
        -- Exit the loop when all rows are processed
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Insert employee details into EmployeeBackupTable
        INSERT INTO EmployeeBackupTable (EmployeeId, EmployeeName, Gender, DOB, DOJ, Designation, DepartmentId, Salary, PhoneNo)
        VALUES (emp_id, emp_name, emp_gender, emp_dob, emp_doj, emp_designation, emp_department_id, emp_salary, emp_phone_no);

    END LOOP;

    -- Close the cursor
    CLOSE employee_cursor;
END $$

DELIMITER ;

CALL insert_employee_details();
Select * From employeebackuptable;

ALTER TABLE EmployeeTable
ADD COLUMN last_modified DATETIME DEFAULT NULL;

DELIMITER $$

CREATE TRIGGER update_last_modified
BEFORE UPDATE ON EmployeeTable
FOR EACH ROW
BEGIN
    -- Update the last_modified column with the current timestamp
    SET NEW.last_modified = NOW();
END $$

DELIMITER ;

UPDATE EmployeeTable
SET EmployeeName = 'Mari'
WHERE EmployeeId = 5;

SELECT EmployeeId, EmployeeName, last_modified
FROM EmployeeTable
WHERE EmployeeId = 5;

DELIMITER $$

CREATE TRIGGER prevent_department_deletion
BEFORE DELETE ON department
FOR EACH ROW
BEGIN
    -- Check if the department being deleted has associated employees
    DECLARE emp_count INT;

    -- Count how many employees are assigned to the department
    SELECT COUNT(*) INTO emp_count
    FROM EmployeeTable
    WHERE DepartmentID = OLD.DepartmentID;

    -- If there are employees in the department, prevent the deletion
    IF emp_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete department with associated employees';
    END IF;
END $$

DELIMITER ;

CREATE TABLE SalaryChangeLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10, 2),
    NewSalary DECIMAL(10, 2),
    ChangeTime DATETIME DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER log_salary_change
BEFORE UPDATE ON EmployeeTable
FOR EACH ROW
BEGIN
    -- Check if salary has changed
    IF OLD.Salary <> NEW.Salary THEN
        -- Insert the salary change details into the SalaryChangeLog table
        INSERT INTO SalaryChangeLog (EmployeeID, OldSalary, NewSalary)
        VALUES (OLD.EmployeeId, OLD.Salary, NEW.Salary);
    END IF;
END $$

DELIMITER ;

UPDATE EmployeeTable
SET Salary = 25000
WHERE EmployeeId = 5;

SELECT * FROM SalaryChangeLog;

DELIMITER $$

CREATE TRIGGER ensure_positive_salary
BEFORE INSERT ON EmployeeTable
FOR EACH ROW
BEGIN
    -- Check if the new salary is negative
    IF NEW.Salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be a negative value.';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER ensure_positive_salary_update
BEFORE UPDATE ON EmployeeTable
FOR EACH ROW
BEGIN
    -- Check if the new salary is negative
    IF NEW.Salary < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be a negative value.';
    END IF;
END $$

DELIMITER ;

