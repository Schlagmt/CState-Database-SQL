-- --------------------------------------------------------------------------------
-- Name: Matthew Schlager
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL3; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors
-- --------------------------------------------------------------------------------
-- Drop Table
-- --------------------------------------------------------------------------------

DROP TABLE TCourseBook
DROP TABLE TCourseStudents
DROP TABLE TCourseRoom
DROP TABLE TCourses

-- --------------------------------------------------------------------------------
-- Step #2.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TCourses
(
	intCourseID							INTEGER			NOT NULL
	,strCourse							VARCHAR(50)		NOT NULL
	,strDescription						VARCHAR(50)		NOT NULL
	,strInstructorFirstName				VARCHAR(50)		NOT NULL
	,strInstructorLastName				VARCHAR(50)		NOT NULL
	,strInstructorPhoneNumber			VARCHAR(50)		NOT NULL
	,CONSTRAINT TCourses_PK PRIMARY KEY( intCourseID )
)

CREATE TABLE TCourseRoom
(
	intCourseID							INTEGER			NOT NULL
	,intRoomIndex						INTEGER			NOT NULL
	,strRoomRoomNumber					VARCHAR(50)		NOT NULL
	,intRoomCapacity					INTEGER			NOT NULL		--3 rooms
	,strRoomMeetingTimes				VARCHAR(50)		NOT NULL		--M/W/F 10-11:20am'
	,CONSTRAINT TCourseRoom_PK PRIMARY KEY( intCourseID, intRoomIndex )
)

CREATE TABLE TCourseStudents
(
	intCourseID							INTEGER			NOT NULL
	,intStudentIndex					INTEGER			NOT NULL
	,strStudentFirstName				VARCHAR(50)		NOT NULL
	,strStudentLastName					VARCHAR(50)		NOT NULL		--20 studnets
	,strStudentStudentNumber			VARCHAR(50)		NOT NULL		
	,strStudentPhoneNumber				VARCHAR(50)		NOT NULL
	,CONSTRAINT TCourseStudents_PK PRIMARY KEY( intCourseID,intStudentIndex )
)

CREATE TABLE TCourseBook
(
	intCourseID							INTEGER			NOT NULL
	,intBookIndex						INTEGER			NOT NULL
	,strBookName						VARCHAR(50)		NOT NULL
	,strBookAuthor						VARCHAR(50)		NOT NULL		--3 books
	,strBookISBN						VARCHAR(50)		NOT NULL		--'ISBN: International Standard Book Number'
	,CONSTRAINT TCourseBook_PK PRIMARY KEY ( intCourseID, intBookIndex )
)

-- --------------------------------------------------------------------------------
-- Step #2.2: Identify and Create Foreign Key
-- --------------------------------------------------------------------------------
--
--#		Child					Parent					Column
--		-----					------					------
--		TCourseRoom				TCourses				intCourseID
--		TCourseStudents			TCourses				intCourseID
--		TCourseBook				TCourses				intCourseID

ALTER TABLE TCourseRoom ADD CONSTRAINT TCourseRoom_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

ALTER TABLE TCourseStudents ADD CONSTRAINT TCourseStudents_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

ALTER TABLE TCourseBook ADD CONSTRAINT TCourseBook_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

-- --------------------------------------------------------------------------------
-- Step #2.3: Add at least three Courses
-- --------------------------------------------------------------------------------

INSERT INTO TCourses (intCourseID,strCourse,strDescription,strInstructorFirstName,strInstructorLastName,strInstructorPhoneNumber)
VALUES		( 1, 'Computer Science 1', 'Visual Basic Intro', 'That One Guy?', 'I Think?', '(513)444-4444')
			, ( 2, 'Computer Science 2', 'HTML Intro','That Other Guy?', 'I Think?Right?', '(513)111-1111')
			, ( 3, 'Computer Science 3', 'SQL Intro','That Other Other Guy?', 'I Think?Maybe?', '(513)333-3333')

SELECT * FROM TCourses

-- --------------------------------------------------------------------------------
-- Step #2.4: Add at least two rooms to the Courses
-- --------------------------------------------------------------------------------

INSERT INTO TCourseRoom (intCourseID, intRoomIndex, strRoomRoomNumber,intRoomCapacity, strRoomMeetingTimes)	
VALUES		(1,101,1,50, 'M 10-11:00am')	
			,(1,102,2, 58, 'W 9-10:00am')
			,(2,103,3, 57, 'F 8-9:00am')
			,(2,104,4, 51, 'M 1-2:00pm')
			,(3,105,5, 52, 'W 3-4:00pm')
			,(3,106,6, 59, 'F 4-5:00pm')


SELECT * FROM TCourseRoom

-- --------------------------------------------------------------------------------
-- Step #2.5: Add at least two books to the Courses
-- --------------------------------------------------------------------------------

INSERT INTO TCourseBook (intCourseID,intBookIndex,strBookName,strBookAuthor,strBookISBN)
VALUES		(1,1,'The Big book of VB', 'Mark Wallberg I', '978-3-16-148410-0')
			,(1,2,'The Bigger book of VB', 'Mark Wallberg II', '978-4-16-148410-0')
			,(2,3,'The Big book of HTML', 'Mark Wallberg III', '978-5-16-148410-0')
			,(2,4,'The Bigger book of HTML', 'Mark Wallberg IV', '978-6-16-148410-0')
			,(3,5,'The Big book of SQL', 'Mark Wallberg V', '978-7-16-148410-0')
			,(3,6,'The Biger book of SQL', 'Mark Wallberg VI', '978-8-16-148410-0')

SELECT * FROM TCourseBook

-- --------------------------------------------------------------------------------
-- Step #2.6: Add at least two students to the Courses
-- --------------------------------------------------------------------------------

INSERT INTO TCourseStudents (intCourseID,intStudentIndex,strStudentFirstName,strStudentLastName,strStudentStudentNumber,strStudentPhoneNumber)
VALUES		(1,1, 'Karl', 'Towns','123456789','(434)676-8989')
			,(1,2,'Bol', 'Bol','123356789','(434)677-8989')
			,(2,3,'Lebron', 'James','123236789','(434)678-8989')
			,(2,4,'Kevin', 'Durant','1234756789','(434)696-8989')
			,(3,5,'Kevin', 'Garnett','123486789','(434)670-8989')
			,(3,6,'Tim', 'Duncan','123496789','(434)671-8989')

SELECT * FROM TCourseStudents
