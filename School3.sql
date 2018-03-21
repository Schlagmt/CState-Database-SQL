-- --------------------------------------------------------------------------------
-- Name: Matthew Schlager
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL2; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors
-- --------------------------------------------------------------------------------
-- Drop Table
-- --------------------------------------------------------------------------------
IF OBJECT_ID( 'TCourseBooks' ) IS NOT NULL DROP TABLE TCourseBooks
IF OBJECT_ID( 'TBooks' ) IS NOT NULL DROP TABLE TBooks
IF OBJECT_ID( 'TCourseStudents' ) IS NOT NULL DROP TABLE TCourseStudents
IF OBJECT_ID( 'TGrades' ) IS NOT NULL DROP TABLE TGrades
IF OBJECT_ID( 'TStudents' ) IS NOT NULL DROP TABLE TStudents
IF OBJECT_ID( 'TCourses' ) IS NOT NULL DROP TABLE TCourses
IF OBJECT_ID( 'TRooms' ) IS NOT NULL DROP TABLE TRooms
IF OBJECT_ID( 'TInstructors' ) IS NOT NULL DROP TABLE TInstructors

IF OBJECT_ID( 'VCourse' )  IS NOT NULL DROP VIEW  VCourse
IF OBJECT_ID( 'VCourseStudentGrades' )  IS NOT NULL DROP VIEW  VCourseStudentGrades

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
-- Step #3.4: Create the view VCoures.  Write few test SELECT commands to make sure it works correctly.
-- --------------------------------------------------------------------------------
GO

CREATE VIEW VCourse
AS
SELECT
	TC.intCourseID							
	,TC.strCourse							
	,TC.strDescription						
	,TC.intInstructorID					
	,TC.intRoomID							
	,TC.strRoomMeetingTime					
	,TC.decCreditHours
FROM
	TCourses AS TC

GO
-- --------------------------------------------------------------------------------
-- Step #3.5: Create the view VCourseStudentGrades.  Write few test SELECT commands to make sure it works correctly.
-- --------------------------------------------------------------------------------
GO

CREATE VIEW  VCourseStudentGrades
AS
SELECT
	TS.intStudentID
	,TS.strFirstName + ' ' + TS.strLastName AS strFullName
	,TCS.intCourseID	
	,TG.strGrade
FROM
	TStudents AS TS
	,TCourseStudents AS TCS
	,TGrades AS TG
WHERE
	TS.intStudentID = TCS.intStudentID
AND TCS.intGradeID = TG.intGradeID
GO