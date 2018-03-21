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
DROP TABLE TBooks
DROP TABLE TCourseBooks
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
	,CONSTRAINT TCourses_PK PRIMARY KEY( intCourseID,intRoomID )
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
	,CONSTRAINT TCourseStudents_PK PRIMARY KEY( intCourseID,intStudentID )
)
CREATE TABLE TGrades
(
	intStudentID						INTEGER			NOT NULL
	,intCourseID						INTEGER			NOT NULL
	,intGradeID							INTEGER			NOT NULL
	,strGrade							VARCHAR(50)		NOT NULL
	,decGradePointValue					DECIMAL			NOT NULL
	,CONSTRAINT TGrades_PK PRIMARY KEY( intStudentID,intCourseID,intGradeID )
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
--		TRooms					TCourses				intCourseID
--		TCourseStudents			TCourses				intCourseID
--		TCourseStudents			TStudents				intStudentID
--		TCourseBooks			TCourses				intCourseID
--		TCourseBooks			TBook					intBookID

ALTER TABLE TCourses ADD CONSTRAINT TCourses_TInstructors_FK
FOREIGN KEY ( intInstructorID ) REFERENCES TInstructors ( intInstructorID )
ALTER TABLE TRooms ADD CONSTRAINT TRooms_TCourses_FK
FOREIGN KEY ( intCourseID,intRoomID ) REFERENCES TCourses ( intCourseID,intRoomID )
ALTER TABLE TCourseStudents ADD CONSTRAINT TStudents_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )
ALTER TABLE TCourseStudents ADD CONSTRAINT TStudents_TStudents_FK
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
INSERT INTO TCourses (intCourseID,strCourse,strDescription,intInstructorID,intRoomID,strRoomMeetingTime)
VALUES		(1,'SQL','Basic SQL',1,1,'8:00 - 10:00am Friday')
			,(2,'HTML','Basic HTML',2,2,'10:00 - 11:00am Friday')
INSERT INTO TRooms (intRoomID,strRoomNumber,intCapacity)
VALUES		(1,'101',50)
			,(2,'102',50)
INSERT INTO TBooks(intBookID, strBookTitle, strBookAuthor, strBookISBN)
VALUES		(1,'Book of things','Mark OBrian','978-3-16-148410-3')
			,(2,'Other Book','Lindsey Coder','978-3-16-148410-2')
INSERT INTO TCourseBooks(intCourseID,intBookID)
VALUES		(1,1)
			,(2,2)
INSERT INTO TStudents (intStudentID,strFirstName,strLastName,strStudentNumber,strPhoneNumber)
VALUES		(1,'Carmelo','Anthony','217186','(567)890-1234')
			,(2,'Lebron','James','212186','(567)891-1234')
INSERT INTO TGrades (intCourseID,intStudentID,intGradeID,strGrade,decGradePointValue)
VALUES		(1,1,1,'A',90)
			,(2,2,2,'B',80)
INSERT INTO TCourseStudents (intCourseID,intStudentID,intGradeID) 
VALUES		(1,1,1)
			,(2,2,2)
-- --------------------------------------------------------------------------------
-- Step #3.4: Write the join that will display the course ID, name, description and meeting times along with the 
--            instructor information and the room information.  Be sure to include an ORDER BY clause.
-- --------------------------------------------------------------------------------
SELECT
	TC.intCourseID
	,TC.strCourse
	,TC.strDescription
	,TI.intInstructorID
	,TI.strFirstName
	,TI.strLastName
	,TI.strPhoneNumber
	,TR.intRoomID
	,TR.strRoomNumber
	,TR.intCapacity
	,TC.strRoomMeetingTime
FROM
	TCourses		AS TC
	,TInstructors	AS TI
	,TRooms			AS TR
WHERE
	TC.intInstructorID = TI.intInstructorID
AND	TC.intRoomID = TR.intRoomID
ORDER BY
	intCourseID
-- --------------------------------------------------------------------------------
-- Step #3.5: Write the join that will show display a record for every student in a course along with the student's grade.  
--             Be sure to include an ORDER BY clause.
-- --------------------------------------------------------------------------------
SELECT
	TC.intCourseID
	,TC.strCourse
	,TS.intStudentID
	,TS.strLastName + ', ' + TS.strFirstName AS strStudent
	,TG.intGradeID
	,TG.strGrade
	,TG.decGradePointValue
FROM
	TCourses		AS TC
	,TCourseStudents AS TCS
	,TStudents		AS TS
	,TGrades		AS TG
WHERE
	TC.intCourseID = TCS.intCourseID
AND	TCS.intStudentID = TS.intStudentID
AND TCS.intGradeID = TG.intGradeID
ORDER BY
	intCourseID