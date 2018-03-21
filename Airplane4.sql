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

DROP TABLE TFlightFlightAttendant
DROP TABLE TFlightPassenger
DROP TABLE TFlightPilot
DROP TABLE TFlights

-- --------------------------------------------------------------------------------
-- Step #3.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TFlights
(
	intFlightID						INTEGER			NOT NULL
	,strFlight						VARCHAR(50)		NOT NULL
	,strDescription					VARCHAR(50)		NOT NULL		--(e.g. CVG to ATL)
	,strAirplaneNumber				VARCHAR(50)		NOT NULL
	,strAirplaneType				VARCHAR(50)		NOT NULL
	,intAirplaneCapacity			INTEGER			NOT NULL
	,CONSTRAINT TFlights_PK PRIMARY KEY( intFlightID )
)

CREATE TABLE TFlightPilot
(
	intFlightID						INTEGER			NOT NULL
	,intPilotIndex					INTEGER			NOT NULL
	,strPilotName					VARCHAR(50)		NOT NULL
	,strPilotPhoneNumber			VARCHAR(50)		NOT NULL
	,CONSTRAINT TFlightPilot_PK PRIMARY KEY( intFlightID , intPilotIndex )
)

CREATE TABLE TFlightPassenger
(
	intFlightID						INTEGER			NOT NULL
	,intPassengerIndex				INTEGER			NOT NULL
	,strPassengerName				VARCHAR(50)		NOT NULL
	,strPassengerPhoneNumber		VARCHAR(50)		NOT NULL		--200
	,strPassengerSeatNumber			VARCHAR(50)		NOT NULL
	,CONSTRAINT TPassenger_PK PRIMARY KEY( intFlightID, intPassengerIndex )
)

CREATE TABLE TFlightFlightAttendant
(
	intFlightID						INTEGER			NOT NULL
	,intFlightAttendentIndex		INTEGER			NOT NULL
	,strFlightAttendantName			VARCHAR(50)		NOT NULL
	,strFlightAttendantPhoneNumber	VARCHAR(50)		NOT NULL		--5
	,CONSTRAINT TFlightAttendant_PK PRIMARY KEY( intFlightID , intFlightAttendentIndex )
)

-- --------------------------------------------------------------------------------
-- Step #3.2: Identify and Create Foreign Key
-- --------------------------------------------------------------------------------
--
--#		Child					Parent					Column
--		-----					------					------
--		TFlightPilot			TFlights				intFlightID
--		TFlightPassenger		TFlights				intFlightID
--		TFlightFlightAttendant	TFlights				intFlightID

ALTER TABLE TFlightPilot ADD CONSTRAINT TFlightPilot_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

ALTER TABLE TFlightPassenger ADD CONSTRAINT TFlightPassenger_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

ALTER TABLE TFlightFlightAttendant ADD CONSTRAINT TFlightFlightAttendant_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

-- --------------------------------------------------------------------------------
-- Step #3.3: Add at least three flights
-- --------------------------------------------------------------------------------

INSERT INTO TFlights(intFlightID,strFlight,strDescription,strAirplaneNumber,strAirplaneType,intAirplaneCapacity)
VALUES		(1,'1','CVG to ATL','11','BIG',200 )
INSERT INTO TFlights(intFlightID,strFlight,strDescription,strAirplaneNumber,strAirplaneType,intAirplaneCapacity)
VALUES		(2,'2','CVG to ATL','22','BIGGER',300 )
INSERT INTO TFlights(intFlightID,strFlight,strDescription,strAirplaneNumber,strAirplaneType,intAirplaneCapacity)
VALUES		(3,'3','CVG to ATL','33','BIGGEST',400 )

SELECT * FROM TFlights

-- --------------------------------------------------------------------------------
-- Step #3.4: Add at least two pilots to each flights
-- --------------------------------------------------------------------------------

INSERT INTO TFlightPilot (intFlightID,intPilotIndex, strPilotName,strPilotPhoneNumber)
VALUES		(1,1,'John Crash','(222)222-2222')
			,(1,2,'John Crash I','(222)222-2223')
			,(2,3,'John Crash II','(222)222-2224')
			,(2,4,'John Crash III','(222)222-2224')
			,(3,5,'John Crash IV','(222)222-2224')
			,(3,6,'John Crash V','(222)222-2224')

SELECT * FROM TFlightPilot

-- --------------------------------------------------------------------------------
-- Step #3.5: Add at least two flight attentant to each flights
-- --------------------------------------------------------------------------------

INSERT INTO TFlightFlightAttendant (intFlightID,intFlightAttendentIndex, strFlightAttendantName,strFlightAttendantPhoneNumber)
VALUES		(1,1,'Meg Ryan', '(111)111-1111')
			,(1,2,'Sara Lee', '(111)111-1112')
			,(2,3,'Sam Tom', '(111)111-1113')
			,(2,4,'Maria Anthony', '(111)111-1114')
			,(3,5,'Cara Smith', '(111)111-1115')
			,(3,6,'Mark Long', '(111)111-1116')

SELECT * FROM TFlightFlightAttendant

-- --------------------------------------------------------------------------------
-- Step #3.6: Add at least two passengers to each flights
-- --------------------------------------------------------------------------------

INSERT INTO TFlightPassenger (intFlightID, intPassengerIndex, strPassengerName,strPassengerPhoneNumber,strPassengerSeatNumber)
VALUES		(1,1,'Guy 1','(999)999-9999','1')
			,(1,2,'Guy 2','(999)399-9999','11')
			,(2,3,'Guy 3','(999)299-9999','101')
			,(2,4,'Guy 4','(999)199-9999','19')
			,(3,5,'Guy 5','(999)899-9999','198')
			,(3,6,'Guy 6','(999)799-9999','13')
			
SELECT * FROM TFlightPassenger
