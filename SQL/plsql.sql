Create database plsql;
use plsql;

-- Create the table with DDL and key constraints
CREATE TABLE Employee (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key
    FirstName VARCHAR(50) NOT NULL,            -- Not Null Constraint
    LastName VARCHAR(50) NOT NULL,             -- Not Null Constraint
    DepartmentID INT,                          -- Foreign Key Field
    Salary DECIMAL(10, 2) CHECK (Salary > 0),  -- Check Constraint
    HireDate DATE,        -- Default Constraint
    UNIQUE (FirstName, LastName)               -- Unique Constraint
);

-- Step 3: Create another table for Foreign Key constraint
CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY, -- Primary Key
    DepartmentName VARCHAR(100) NOT NULL         -- Not Null Constraint
);

-- Step 4: Add Foreign Key constraint to Employee table
ALTER TABLE Employee
ADD CONSTRAINT fk_DepartmentID FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID);

-- Step 5: Insert DML data into Department table
INSERT INTO Department (DepartmentName) VALUES ('HR'), ('IT'), ('Finance');

-- Step 6: Insert DML data into Employee table
INSERT INTO Employee (FirstName, LastName, DepartmentID, Salary, HireDate) 
VALUES 
('John', 'Doe', 1, 50000.00, '2024-01-15'),
('Jane', 'Smith', 2, 60000.00, '2024-02-01'),
('Michael', 'Brown', 3, 55000.00, '2024-03-10');

-- Step 7: Retrieve data to verify the setup
SELECT * FROM Employee;
SELECT * FROM Department;


DELIMITER $$
-- Create the procedure
CREATE PROCEDURE InsertEmployee (
    IN p_FirstName VARCHAR(50),
    IN p_LastName VARCHAR(50),
    IN p_DepartmentID INT,
    IN p_Salary DECIMAL(10, 2),
    IN p_HireDate DATE
)
BEGIN
    -- Error handling: Check if the DepartmentID exists
    IF NOT EXISTS (SELECT 1 FROM Department WHERE DepartmentID = p_DepartmentID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid DepartmentID: The department does not exist.';
    END IF;

    -- Error handling: Check if the salary is positive
    IF p_Salary <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid Salary: Salary must be greater than 0.';
    END IF;

    -- Insert into Employee table
    INSERT INTO Employee (FirstName, LastName, DepartmentID, Salary, HireDate)
    VALUES (p_FirstName, p_LastName, p_DepartmentID, p_Salary, 
            IFNULL(p_HireDate, CURRENT_DATE));

END $$

DELIMITER ;

SELECT * FROM Employee;
SELECT * FROM Department;

CALL InsertEmployee('Alice', 'Johnson', 1, 45000.00, '2024-01-20');
CALL InsertEmployee('Bob', 'Williams', 2, 55000.00, NULL);


DELIMITER $$

CREATE PROCEDURE GetHighEarningEmployees (
    IN p_SalaryThreshold DECIMAL(10, 2),
    IN p_DepartmentID INT
)
BEGIN
    -- Check if a department filter is applied
    IF p_DepartmentID IS NOT NULL THEN
        -- Query employees in a specific department with salary greater than the threshold
        SELECT EmployeeID, FirstName, LastName, Salary, HireDate, DepartmentID
        FROM Employee
        WHERE Salary > p_SalaryThreshold AND DepartmentID = p_DepartmentID;
    ELSE
        -- Query all employees with salary greater than the threshold
        SELECT EmployeeID, FirstName, LastName, Salary, HireDate, DepartmentID
        FROM Employee
        WHERE Salary > p_SalaryThreshold;
    END IF;
END $$

DELIMITER ;

-- Get employees in Department 2 with salary > 40,000
CALL GetHighEarningEmployees(40000, 2);

DELIMITER $$
CREATE PROCEDURE GetAllEmployees()
BEGIN
    -- Select all records from the Employee table
    SELECT * FROM Employee;
END $$

DELIMITER ;

CALL GetAllEmployees();

-- Get all employees with salary > 40,000
CALL GetHighEarningEmployees(40000, NULL);

DELIMITER $$

CREATE PROCEDURE GetEmployeesByYear(IN joinYear INT)
BEGIN
    -- Retrieve and display employees who joined in the specified year
    SELECT EmployeeID 
    FirstName, 
    LastName,
    DepartmentID,
    Salary,
    HireDate
    FROM Employees
    WHERE YEAR(HireDate) = joinYear;
END$$

DELIMITER 

Drop procedure GetEmployeesByYear;

Alter table Employee Rename to Employees;

Call GetEmployeesByYear(2024);

CREATE VIEW SeniorMostEmployees AS
SELECT *
FROM Employees
WHERE HireDate = (SELECT MIN(HireDate) FROM Employees);


SELECT * FROM SeniorMostEmployees;

-- Create a log table to store record count
CREATE TABLE InsertLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    TableName VARCHAR(50),
    InsertedRecords INT,
    InsertedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create the trigger
DELIMITER $$

CREATE TRIGGER CountInsertTrigger
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    -- Insert the count into the InsertLog table
    INSERT INTO InsertLog (TableName, InsertedRecords)
    VALUES ('Employees', 1);
END$$

DELIMITER ;

INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, HireDate) 
VALUES 
('Alaas', 'Ken', 1, 50000.00, '2024-01-15');

INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary, HireDate) 
VALUES 
('Karunya', 'Kib', 3, 50000.00, '2024-01-15');

SELECT * FROM InsertLog;

