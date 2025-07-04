--1.Create University Database give any University name you want
CREATE database StudentNestUniversity

USE StudentNestUniversity

--2. Under this University Create four tables and each table should have following three Column named as:-

CREATE TABLE COLLEGE_TABLE (College_ID INT PRIMARY KEY, College_Name varchar(max), College_Area varchar(max))
CREATE TABLE Department_Table (Dept_ID INT PRIMARY KEY, Dept_Name varchar(max), Dept_Facility INT)
CREATE TABLE Professor_Table (Prof_ID INT PRIMARY KEY, Prof_Name varchar(max), Prof_Subject varchar(max))
CREATE TABLE Student_Table ( Stud_ID INT PRIMARY KEY, Stud_Name varchar(max), Stud_Stream varchar(max))

--3. Apply foreign key on Department key from College_table

ALTER TABLE DEPARTMENT_TABLE
ALTER COLUMN Dept_Facility VARCHAR(MAX)

ALTER TABLE DEPARTMENT_TABLE
ADD COLLEGE_ID INT

ALTER TABLE DEPARTMENT_TABLE
ALTER COLUMN COLLEGE_ID INT NOT NULL

ALTER TABLE DEPARTMENT_TABLE
ADD CONSTRAINT FK_DEPARTMENT_COLLEGE
FOREIGN KEY (COLLEGE_ID) REFERENCES COLLEGE_TABLE(COLLEGE_ID)

--4. Apply foreign Key on Student_Table from Professor_Table

ALTER TABLE STUDENT_TABLE
ADD Prof_ID INT

ALTER TABLE STUDENT_TABLE
ALTER COLUMN Prof_ID INT NOT NULL   

ALTER TABLE STUDENT_TABLE
ADD CONSTRAINT FK_STUDENT_PROFESSOR
FOREIGN KEY (Prof_ID) REFERENCES Professor_Table(Prof_ID)

--5. Insert atleast 10 Records in each table

INSERT INTO COLLEGE_TABLE VALUES (1, 'Engineering College', 'North Campus'),
(2, 'Medical College', 'South Campus'),
(3, 'Arts College', 'East Wing'),
(4, 'Science College', 'West Wing'),
(5, 'Law College', 'Central Campus'),
(6, 'Business School', 'City Center'),
(7, 'Pharmacy College', 'Block A'),
(8, 'Architecture College', 'Block B'),
(9, 'Education College', 'Block C'),
(10, 'Agriculture College', 'Green Zone')

INSERT INTO Department_Table VALUES (101, 'Computer Science', 'Lab, Wi-Fi', 1),
(102, 'Mechanical', 'Workshop', 1),
(103, 'Anatomy', 'Dissection Hall', 2),
(104, 'Fine Arts', 'Studio', 3),
(105, 'Physics', 'Research Lab', 4),
(106, 'Corporate Law', 'Moot Court', 5),
(107, 'Finance', 'Smart Classrooms', 6),
(108, 'Pharmacology', 'Drug Lab', 7),
(109, 'Interior Design', 'Draft Studio', 8),
(110, 'Agri-Tech', 'Field Lab', 10)

INSERT INTO Professor_Table VALUES (201, 'Dr. Arun Kumar', 'Data Structures'),
(202, 'Dr. Neha Mehta', 'Thermodynamics'),
(203, 'Dr. Shalini Rao', 'Human Anatomy'),
(204, 'Dr. Raj Verma', 'Art History'),
(205, 'Dr. Sneha Das', 'Quantum Physics'),
(206, 'Dr. Vikram Singh', 'Criminal Law'),
(207, 'Dr. Alok Jain', 'Corporate Finance'),
(208, 'Dr. Priya Nair', 'Pharmaceutical Chemistry'),
(209, 'Dr. Manish Rawat', 'Architectural Design'),
(210, 'Dr. Kavita Joshi', 'Soil Science')

INSERT INTO Student_Table VALUES (301, 'Ravi Sharma', 'Computer Science', 201),
(302, 'Aarti Singh', 'Mechanical', 202),
(303, 'Nikita Bansal', 'MBBS', 203),
(304, 'Ajay Deshmukh', 'Fine Arts', 204),
(305, 'Snehal Patil', 'Physics', 205),
(306, 'Zainab Hussain', 'Law', 206),
(307, 'Manoj Shetty', 'MBA', 207),
(308, 'Pooja Rao', 'Pharmacy', 208),
(309, 'Vishal Jha', 'Architecture', 209),
(310, 'Jyoti Kumari', 'Agriculture', 210)

SELECT*FROM COLLEGE_TABLE
SELECT*FROM Department_Table
SELECT*FROM Professor_Table
SELECT*FROM Student_Table

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--1. Give the information of College_ID and College_name from College_Table

SELECT College_id,College_name from COLLEGE_TABLE

--2. Show Top 5 rows from Student table.

select top 5 * from Student_Table

--3. What is the name of professor whose ID is 5

SELECT Prof_Name FROM Professor_Table
WHERE Prof_ID = 5

--4. Convert the name of the Professor into Upper case

SELECT UPPER(PROF_NAME) AS UpperProfName from Professor_Table

--5. Show me the names of those students whose name is start with a

SELECT STUD_ID,Stud_Name FROM Student_Table where Stud_Name LIKE 'a%'

--6. Give the name of those colleges whose end with a

SELECT College_ID,College_Name FROM COLLEGE_TABLE
WHERE College_Name LIKE '%a'

--7. Add one Salary Column in Professor_Table

ALTER TABLE Professor_Table
ADD SALARY DECIMAL(10,2)

SELECT*FROM Professor_Table

--8. Add one Contact Column in Student_table

ALTER TABLE Student_Table
ADD CONTACT VARCHAR(MAX)

SELECT*FROM Student_Table

--9. Find the total Salary of Professor

SELECT SUM(SALARY) AS TotalSalary FROM Professor_Table

--10. Change datatype of any one column of any one Table

ALTER TABLE Professor_Table
ALTER COLUMN SALARY FLOAT

SELECT*FROM Professor_Table

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--1. Show first 5 records from Students table and Professor table Combine

SELECT TOP 5 *
FROM(
    SELECT STUD_ID AS ID,STUD_NAME AS NAME, 'STUDENT' AS ROLE
    FROM Student_Table
    UNION ALL
    SELECT PROF_ID AS ID,PROF_NAME AS NAME, 'PROFESSOR' AS ROLE
    FROM Professor_Table
) AS COMBINED 
ORDER BY ROLE DESC,ID

-- 2. Apply Inner join on all 4 tables together(Syntax is mandatory)

SELECT
C.COLLEGE_ID,C.College_Name,C.College_Area,
D.Dept_ID,D.Dept_Name,D.Dept_Facility,
P.PROF_ID,P.PROF_NAME,P.Prof_Subject,
S.STUD_ID,S.STUD_NAME,S.STUD_STREAM
FROM COLLEGE_TABLE C 
INNER JOIN Department_Table D 
ON C.College_ID = D.COLLEGE_ID
INNER JOIN Student_Table S 
ON S.PROF_ID = S.PROF_ID
INNER JOIN Professor_Table P 
ON P.Prof_ID = S.PROF_ID

--3. Show Some null values from Department table and Professor table.

SELECT* FROM Department_Table
WHERE Dept_Facility IS NULL

SELECT*FROM Professor_Table 
WHERE Prof_Subject IS NULL

--4. Create a View from College Table and give those records whose college name starts with C

CREATE VIEW VIEW_COLG_NAME AS 
SELECT*FROM COLLEGE_TABLE WHERE College_Name LIKE 'C%'

SELECT*FROM VIEW_COLG_NAME

--5. Create Stored Procedure of Professor table whatever customer ID will be given by user it should show whole records of it.

CREATE PROC GetProfByID
@Prof_id INT
AS 
BEGIN
SELECT*FROM Professor_Table
WHERE Prof_ID = @Prof_id
END

EXEC GetProfByID @Prof_id = 201

--6. Rename the College_Table to College_Tables_Data 

EXEC sp_rename 'COLLEGE_TABLE', 'COLLEGE_TABLES_DATA'

Select*FROM COLLEGE_TABLES_DATA
