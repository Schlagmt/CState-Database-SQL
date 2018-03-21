-- --------------------------------------------------------------------------------
-- Name: Matthew Schlager
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors
-- --------------------------------------------------------------------------------
-- Step #1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TEmployees
(
	intEmployeeID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(50)		NOT NULL
	,strMiddleName			VARCHAR(50)		NOT NULL
	,strLastName			VARCHAR(50)		NOT NULL
	,dtmDateOfHire			DATETIME		NOT NULL
	,strPosition			VARCHAR(50)		NOT NULL
	,CONSTRAINT TEmployees_PK PRIMARY KEY( intEmployeeID )
)

CREATE TABLE TParkingSpots
(
	intParkingSpotID		INTEGER			NOT NULL
	,strParkingSpot			VARCHAR(50)		NOT NULL

	,CONSTRAINT TParkingSpots_PK PRIMARY KEY( intParkingSpotID )
)

CREATE TABLE TEmployeeParkingSpots
(
	intEmployeeID			INTEGER			NOT NULL
	,intParkingSpotID		INTEGER			NOT NULL	
	,CONSTRAINT TEmployeeParkingSpots_PK PRIMARY KEY(intEmployeeID ,intParkingSpotID )
	,CONSTRAINT TEmployeeParkingSpots_intParkingSpotID_UN UNIQUE(intParkingSpotID )
)

-- --------------------------------------------------------------------------------
-- Step #2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
-- #	Child						Parent					Colunms
--		-----						------					------
-- 1	TEmployeeParkingSpots		TEmployee				intEmployeeID
-- 2	TEmployeeParkingSpots		TParkingSpots			intParkingSpotID


-- 1
ALTER TABLE TEmployeeParkingSpot ADD CONSTRAINT TEmployeeParkingSpots_TEmployees_FK
	FOREIGN KEY ( intEmployeeID ) REFERENCES TEmployees( intEmployeeID )
-- 2
ALTER TABLE TEmployeeParkingSpots ADD CONSTRAINT TEmployeeParkingSpots_TParkingSpots_FK
	FOREIGN KEY (intParkingSpotID ) REFERENCES TParkingSpots( intParkingSpotID )

-- --------------------------------------------------------------------------------
-- Step #3: Add 5 Employees
-- --------------------------------------------------------------------------------

INSERT INTO TEmployees (intEmployeeID, strFirstName, str, strLastName, dtmDateOfHire, str )
VALUES (1, 'Ansel', '', 'Adams', '1/1/2001', 'President' )
