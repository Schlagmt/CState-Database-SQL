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
DROP TABLE TStudents
DROP TABLE TCourseRooms
DROP TABLE TRooms
DROP TABLE TCourses
DROP TABLE TInstructors

-- --------------------------------------------------------------------------------
-- Step #3.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TCourses
(
	intCourseID							INTEGER			NOT NULL
	,strCourse							VARCHAR(50)		NOT NULL
	,strDescription						VARCHAR(50)		NOT NULL
	,intInstructorID						INTEGER			NOT NULL
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
CREATE TABLE TCourseRooms
(
	intCourseID							INTEGER			NOT NULL
	,intRoomID							INTEGER			NOT NULL
	,strMeetingTimes					VARCHAR(50)		NOT NULL		
	,CONSTRAINT TCourseRoom_PK PRIMARY KEY( intCourseID, intRoomID )
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
	,CONSTRAINT TCourseStudents_PK PRIMARY KEY( intCourseID,intStudentID )
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
--		TCourseRooms			TCourses				intCourseID
--		TCourseRooms			TRoom					intRoomID
--		TCourseStudents			TCourses				intCourseID
--		TCourseStudents			TStudents				intStudentID
--		TCourseBooks			TCourses				intCourseID
--		TCourseBooks			TBook					intBookID

ALTER TABLE TCourses ADD CONSTRAINT TCourses_TInstructors_FK
FOREIGN KEY ( intInstructorID ) REFERENCES TInstructors ( intInstructorID )

ALTER TABLE TCourseRooms ADD CONSTRAINT TCourseRooms_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

ALTER TABLE TCourseRooms ADD CONSTRAINT TCourseRooms_TRooms_FK
FOREIGN KEY ( intRoomID ) REFERENCES TRooms ( intRoomID )

ALTER TABLE TCourseStudents ADD CONSTRAINT TStudents_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

ALTER TABLE TCourseStudents ADD CONSTRAINT TStudents_TStudents_FK
FOREIGN KEY ( intStudentID ) REFERENCES TStudents ( intStudentID )

ALTER TABLE TCourseBooks ADD CONSTRAINT TCourseBooks_TCourses_FK
FOREIGN KEY ( intCourseID ) REFERENCES TCourses ( intCourseID )

ALTER TABLE TCourseBooks ADD CONSTRAINT TCourseBooks_TBooks_FK
FOREIGN KEY ( intBookID ) REFERENCES TBooks ( intBookID )
-- --------------------------------------------------------------------------------
-- Step #3.3: Write the SQL that will add at least 3 courses.
-- --------------------------------------------------------------------------------
INSERT INTO TInstructors (intInstructorID,strFirstName,strLastName,strPhoneNumber)
VALUES		(1,'Matt','Rock','1111111')
			,(2,'Matt','Rock II','2111111')
			,(3,'Matt','Rock III','3111111')

INSERT INTO TCourses (intCourseID,strCourse,strDescription,intInstructorID)
VALUES		(1,'SQL','Basic SQL',1)
			,(2,'HTML','Basic HTML',2)
			,(3,'Visual Basic','Basic Visual Basic',3)

-- --------------------------------------------------------------------------------
-- Step #3.4: Write the SQL that will add at least 3 rooms and assign at least one to each course.
-- --------------------------------------------------------------------------------
INSERT INTO TRooms (intRoomID,strRoomNumber,intCapacity)
VALUES		(1,'101',50)
			,(2,'102',50)
			,(3,'103',50)

INSERT INTO TCourseRooms (intCourseID,intRoomID,strMeetingTimes)
VALUES		(1,1,'8:00 - 10:00am Friday')
			,(1,2,'9:00 - 11:00am Monday')
			,(2,3,'10:00 - 11:00am Friday')
			,(3,1,'8:00 - 10:00am Tuesday')
			,(3,2,'9:00 - 11:00am Thursday')

-- --------------------------------------------------------------------------------
-- Step #3.5: Write the SQL that will add at least 3 books and assign at least one to each course.
-- --------------------------------------------------------------------------------
INSERT INTO TBooks(intBookID, strBookTitle, strBookAuthor, strBookISBN)
VALUES		(1,'Book of things','Mark OBrian','978-3-16-148410-3')
			,(2,'Other Book','Lindsey Coder','978-3-16-148410-2')
			,(3,'Some Book','Dat Boi','978-3-16-148410-1')
			,(4,'Book of things 2','Mark OBrian II','978-3-26-148410-3')
			,(5,'Other Book 2','Lindsey Coder II','978-3-16-448410-2')
			,(6,'Some Book 2','Dat Boi II','978-3-16-148410-3')

INSERT INTO TCourseBooks(intCourseID,intBookID)
VALUES		(1,1)
			,(1,2)
			,(2,3)
			,(2,4)
			,(3,5)
			,(3,6)

-- --------------------------------------------------------------------------------
-- Step #3.6: Write the SQL that will add at least 3 students and assign at least two to each course.
-- --------------------------------------------------------------------------------
INSERT INTO TStudents (intStudentID,strFirstName,strLastName,strStudentNumber,strPhoneNumber)
VALUES		(1,'Carmelo','Anthony','217186','(567)890-1234')
			,(2,'Lebron','James','212186','(567)891-1234')
			,(3,'Dywane','Wade','227186','(567)892-1234')
			,(4,'Carmelo','Anthony II','217286','(567)892-1234')
			,(5,'Lebron','James II','212126','(567)891-1434')
			,(6,'Dywane','Wade II','227182','(567)892-1254')

INSERT INTO TCourseStudents (intCourseID,intStudentID) 
VALUES		(1,1)
			,(1,2)
			,(2,3)
			,(2,4)
			,(3,5)
			,(3,6)