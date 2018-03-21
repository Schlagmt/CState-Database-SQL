-- --------------------------------------------------------------------------------
-- Name: Matthew Schlager
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors
-- --------------------------------------------------------------------------------
-- Drop Table
-- --------------------------------------------------------------------------------
DROP TABLE TCourseBooks
DROP TABLE TBooks
DROP TABLE TCourseStudents
DROP TABLE TGrades
DROP TABLE TStudents
DROP TABLE TCourses
DROP TABLE TRooms
DROP TABLE TInstructors
-- --------------------------------------------------------------------------------
-- Step #3.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TCourses
(
	intCourseID							INTEGER			NOT NULL
	,strCourse							VARCHAR(50)		NOT NULL
	,strDescription						VARCHAR(50)		NOT NULL
	,intInstructorID					INTEGER			NOT NULL
	,intRoomID							INTEGER			NOT NULL
	,strRoomMeetingTime					VARCHAR(50)		NOT NULL
	,decCreditHours						DECIMAL			NOT NULL
	,CONSTRAINT TCourses_PK PRIMARY KEY( intCourseID )
)
CREATE TABLE TInstructors
(
	intInstructorID						INTEGER			NOT NULL
	,strFirstName						VARCHAR(50)		NOT NULL
	,strLastName						VARCHAR(50)		NOT NULL
	,strPhoneNumber						VARCHAR(50)		NOT NULL
	,CONSTRAINT TInstructors_PK PRIMARY KEY( intInstructorID )
)
CREATE TABLE TRooms
(
	intRoomID							INTEGER			NOT NULL
	,strRoomNumber						VARCHAR(50)		NOT NULL
	,intCapacity						INTEGER			NOT NULL			
	,CONSTRAINT TRooms_PK PRIMARY KEY( intRoomID )
)
CREATE TABLE TCourseStudents
(
	intCourseID							INTEGER			NOT NULL
	,intStudentID						INTEGER			NOT NULL
	,intGradeID							INTEGER			NOT NULL
	,CONSTRAINT TCourseStudents_PK PRIMARY KEY( intCourseID,intStudentID,intGradeID )
)
CREATE TABLE TStudents
(
	intStudentID						INTEGER			NOT NULL
	,strFirstName						VARCHAR(50)		NOT NULL
	,strLastName						VARCHAR(50)		NOT NULL		
	,strStudentNumber					VARCHAR(50)		NOT NULL		
	,strPhoneNumber						VARCHAR(50)		NOT NULL
	,CONSTRAINT TStudents_PK PRIMARY KEY( intStudentID )
)
CREATE TABLE TGrades
(
	intGradeID							INTEGER			NOT NULL
	,strGrade							VARCHAR(50)		NOT NULL
	,decGradePointValue					DECIMAL			NOT NULL
	,CONSTRAINT TGrades_PK PRIMARY KEY( intGradeID )
)
CREATE TABLE TCourseBooks
(
	intCourseID							INTEGER			NOT NULL
	,intBookID							INTEGER			NOT NULL		
	,CONSTRAINT TCourseBook_PK PRIMARY KEY ( intCourseID, intBookID )
)
CREATE TABLE TBooks
(
	intBookID							INTEGER			NOT NULL
	,strBookTitle						VARCHAR(50)		NOT NULL
	,strBookAuthor						VARCHAR(50)		NOT NULL		
	,strBookISBN						VARCHAR(50)		NOT NULL		
	,CONSTRAINT TBooks_PK PRIMARY KEY ( intBookID )
)
-- --------------------------------------------------------------------------------
-- Step #3.2: Identify and Create Foreign Key
-- --------------------------------------------------------------------------------
--
--#		Child					Parent					Column
--		-----					------					------
--		TCourses				TInstructors			intInstructorID
--		TCourses				TRooms					intRoomID
--		TCourseStudents			TCourses				intCourseID
--		TCourseStudents			TStudents				intStudentID
--		TCourseBooks			TCourses				intCourseID
--		TCourseBooks			TBooks					intBookID
ALTER TABLE TCourses ADD CONSTRAINT TCourses_TInstructors_FK
FOREIGN KEY ( intInstructorID ) REFERENCES TInstructors ( intInstructorID )
ALTER TABLE TCourses ADD CONSTRAINT TCourses_TRooms_FK
FOREIGN KEY ( intRoomID ) REFERENCES TRooms ( intRoomID )
ALTER TABLE TCourseStudents ADD CONSTRAINT TStudents_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )
ALTER TABLE TCourseStudents ADD CONSTRAINT TCourseStudents_TStudents_FK
FOREIGN KEY ( intStudentID ) REFERENCES TStudents ( intStudentID )
ALTER TABLE TCourseBooks ADD CONSTRAINT TCourseBooks_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )
ALTER TABLE TCourseBooks ADD CONSTRAINT TCourseBooks_TBooks_FK
FOREIGN KEY ( intBookID ) REFERENCES TBooks ( intBookID )
-- --------------------------------------------------------------------------------
-- Step #3.3: Add sample data (at least two inserts per table).
-- --------------------------------------------------------------------------------
INSERT INTO TInstructors (intInstructorID,strFirstName,strLastName,strPhoneNumber)
VALUES		(1,'Matt','Rock','1111111')
			,(2,'Matt','Rock II','2111111')
INSERT INTO TRooms (intRoomID,strRoomNumber,intCapacity)
VALUES		(1,'101',50)
			,(2,'102',50)
INSERT INTO TCourses (intCourseID,strCourse,strDescription,intInstructorID,intRoomID,strRoomMeetingTime,decCreditHours)
VALUES		(1,'SQL','Basic SQL',1,1,'8:00 - 10:00am Friday',3)
			,(2,'HTML','Basic HTML',2,2,'10:00 - 11:00am Friday',4)
			,(3,'JAVA','Basic Java',1,1,'9:00 - 10:00am Monday',3)
			,(4,'VB','Basic VB',2,2,'10:00 - 11:00am MOnday',2)
INSERT INTO TBooks(intBookID, strBookTitle, strBookAuthor, strBookISBN)
VALUES		(1,'Book of things','Mark OBrian','978-3-16-148410-3')
			,(2,'Other Book','Lindsey Coder','978-3-16-148410-2')
INSERT INTO TCourseBooks(intCourseID,intBookID)
VALUES		(1,1)
			,(2,2)
INSERT INTO TStudents (intStudentID,strFirstName,strLastName,strStudentNumber,strPhoneNumber)
VALUES		(1,'Carmelo','Anthony','217186','(567)890-1234')
			,(2,'Lebron','James','212286','(567)891-1234')
			,(3,'Mark','Davis','212182','(567)891-1233')
			,(4,'LebrJohnon','MaCado','222186','(567)391-1234')
			,(5,'Tim','McCaw','212286','(567)891-1233')
INSERT INTO TGrades (intGradeID,strGrade,decGradePointValue)
VALUES		( 1, 'A', 4.0 )
			,( 2, 'B', 3.0 )
			,( 3, 'C', 2.0 )
			,( 4, 'D', 1.0 )
			,( 5, 'F', 0.0 )
			,( 6, 'S', 4.0 )	-- Satisfactory
			,( 7, 'N', 0.0 )	-- Not Satisfactory
			,( 8, 'I', 0.0 )	-- Incomplete
			,( 9, 'W', 0.0 )	-- Withdrawal
INSERT INTO TCourseStudents (intCourseID,intStudentID,intGradeID) 
VALUES		( 1 , 1 , 3 )
			,( 1 , 2 , 2 )
			,( 1 , 3 , 1 )
			,( 1 , 4 , 2 )
			,( 1 , 5 , 3 )

			,( 2 , 1 , 4 )
			,( 2 , 2 , 5 )
			,( 2 , 3 , 1 )
			,( 2 , 4 , 7 )
			,( 2 , 5 , 8 )

			,( 3 , 1 , 9 )
			,( 3 , 2 , 9 )
			,( 3 , 3 , 2 )
			,( 3 , 4 , 7 )
			,( 3 , 5 , 6 )

			,( 4 , 1 , 5 )
			,( 4 , 2 , 4 )
			,( 4 , 3 , 3 )
			,( 4 , 4 , 2 )
			,( 4 , 5 , 1 )

-- --------------------------------------------------------------------------------
-- Step #3.4: Write the query that will show the ID and name for every course along with the 
--room capacity, a count of how many students are current enrolled and how many spots are left 
--in the class (room capacity – current enrollment count)
-- --------------------------------------------------------------------------------
SELECT
	TCS.intCourseID AS 'Course ID'
	,TC.strCourse AS 'Course'
	,TR.intCapacity AS 'Class Capacity'
	,COUNT(TCS.intCourseID) AS 'Number Of Students In Class'
	,TR.intCapacity - (COUNT(TCS.intCourseID)) AS 'Avalible Spots In Class'
FROM
	TCourses AS TC
	,TRooms AS TR
	,TCourseStudents AS TCS
WHERE
	TC.intRoomID = TR.intRoomID
AND	TCS.intCourseID = TC.intCourseID
GROUP BY
	TCS.intCourseID 
	,TC.strCourse 
	,TR.intCapacity			
ORDER BY
	TC.strCourse
-- --------------------------------------------------------------------------------
-- Step #3.5: Write the query that will show the ID and name for every student along with each 
-- student’s grade point average (GPA).  Sort by last name and first name.  
-- Do not count incompletes and/or withdrawals.
-- --------------------------------------------------------------------------------
SELECT
	TS.intStudentID AS 'Student ID'
	,TS.strLastName + ', ' + TS.strFirstName AS 'Student Name'
	,SUM(TC.decCreditHours * TG.decGradePointValue)/SUM(TC.decCreditHours) AS 'Grade Point Average'
FROM
	TCourses AS TC
	,TCourseStudents AS TCS
	,TStudents AS TS
	,TGrades AS TG		
WHERE
	TC.intCourseID = TCS.intCourseID
AND	TCS.intStudentID = TS.intStudentID
AND	TCS.intGradeID = TG.intGradeID
AND TG.intGradeID NOT IN ( 8, 9 )
GROUP BY
	TS.intStudentID
	,TS.strLastName
	,TS.strFirstName
ORDER BY
	TS.strLastName
	,TS.strFirstName