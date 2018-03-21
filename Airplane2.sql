-- --------------------------------------------------------------------------------
-- Name: Matthew Schlager
-- Class: SQL #1
-- Abstract: Homework 10
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors
-- --------------------------------------------------------------------------------
-- Drop Table
-- --------------------------------------------------------------------------------

DROP TABLE TFlightFlightAttendants
DROP TABLE TFlightAttendants
DROP TABLE TFlightPassengers
DROP TABLE TPassengers
DROP TABLE TFlightPilots
DROP TABLE TPilots
DROP TABLE TFlights
DROP TABLE TAirplanes

-- --------------------------------------------------------------------------------
-- Step #4.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TFlights
(
		intFlightID					INTEGER			NOT NULL
		, strFlight					VARCHAR(50)		NOT NULL
		, strDescription			VARCHAR(50)		NOT NULL
		, intAirplaneID				INTEGER			NOT NULL
		, CONSTRAINT TFlights_PK PRIMARY KEY( intFlightID )
)
CREATE TABLE TAirplanes
(
		intAirplaneID				INTEGER			NOT NULL					
		, strAirplaneNumber			VARCHAR(50)		NOT NULL
		, strAirplaneType			VARCHAR(50)		NOT NULL
		, intAirplaneCapacity		INTEGER			NOT NULL
		, CONSTRAINT TAirplanes_PK PRIMARY KEY( intAirplaneID )
)
CREATE TABLE TFlightPilots
(
		intFlightID					INTEGER			NOT NULL	
		, intPilotID				INTEGER 		NOT NULL
		, strPilotRole				VARCHAR(50)		NOT NULL
		, CONSTRAINT TFlightPilots_PK PRIMARY KEY( intFlightID,intPilotID )
)
CREATE TABLE TPilots
(
		intPilotID					INTEGER			NOT NULL
		,strFirstName				VARCHAR(50)		NOT NULL
		,strLastName				VARCHAR(50)		NOT NULL
		,strPhoneNumber				VARCHAR(50)		NOT NULL	
		, CONSTRAINT TPilots_PK PRIMARY KEY( intPilotID )
)
CREATE TABLE TFlightPassengers
(
		intFlightID					INTEGER			NOT NULL
		, intPassengerIndex			INTEGER			NOT NULL
		, intPassengerID			INTEGER			NOT NULL
		, strSeatNumber				VARCHAR(50)		NOT NULL
		, CONSTRAINT TTFlightPassengers_PK PRIMARY KEY( intFlightID,intPassengerID)
)
CREATE TABLE TPassengers	
(
		intPassengerID				INTEGER			NOT NULL
		, strFirstName				VARCHAR(50)		NOT NULL
		, strLastName				VARCHAR(50)		NOT NULL
		, strPhoneNumber		    VARCHAR(50)		NOT NULL   
		, CONSTRAINT TPassengers_PK PRIMARY KEY( intPassengerID )
)
CREATE TABLE TFlightFlightAttendants
(
		intFlightID					INTEGER			NOT NULL
		,intFlightAttendantID		INTEGER			NOT NULL	
		, CONSTRAINT TFlightFlightAttendants_PK PRIMARY KEY( intFlightID,intFlightAttendantID )
)
CREATE TABLE TFlightAttendants
(

		intFlightAttendantID		INTEGER			NOT NULL
		, strFirstName				VARCHAR(50)		NOT NULL
		, strLastName				VARCHAR(50)		NOT NULL
		, strPhoneNumber			VARCHAR(50)		NOT NULL    
		, CONSTRAINT TFlightAttendants_PK PRIMARY KEY( intFlightAttendantID )
)
	
-- --------------------------------------------------------------------------------
-- Step #4.2: Identify and Create Foreign Key
-- --------------------------------------------------------------------------------
--
--#		Child					Parent					Column
--		-----					------					------
--		TFlights				TAirplanes				intAirplaneID
--		TFlightPilots			TFlights				intFlightID
--		TFlightPilots			TPilots					intPilotID
--		TFlightPassengers		TPassengers				intPassengerID
--		TFlightPassengers		TFlights				intFlightID
--		TFlightFlightAttendants	TFlightAttendants		intFlightAttendantID
--		TFlightFlightAttendants	TFlights				intFlightID

ALTER TABLE TFlights ADD CONSTRAINT TFlights_TAirplanes_FK
FOREIGN KEY ( intAirplaneID ) REFERENCES TAirplanes ( intAirplaneID )
ALTER TABLE TFlightPilots ADD CONSTRAINT TFlightPilots_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )
ALTER TABLE TFlightPilots ADD CONSTRAINT TFlightPilots_TPilots_FK
FOREIGN KEY ( intPilotID ) REFERENCES TPilots ( intPilotID )
ALTER TABLE TFlightPassengers ADD CONSTRAINT TFlightPassengers_TPassengers_FK
FOREIGN KEY ( intPassengerID ) REFERENCES TPassengers ( intPassengerID )
ALTER TABLE TFlightPassengers ADD CONSTRAINT TFlightPassengers_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )
ALTER TABLE TFlightFlightAttendants ADD CONSTRAINT TFlightFlightAttendants_TFlightAttendants_FK
FOREIGN KEY ( intFlightAttendantID ) REFERENCES TFlightAttendants ( intFlightAttendantID )
ALTER TABLE TFlightFlightAttendants ADD CONSTRAINT TFlightFlightAttendants_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )
-- --------------------------------------------------------------------------------
-- Step #4.3: Add sample data (at least two inserts per table).
-- --------------------------------------------------------------------------------
INSERT INTO TAirplanes (intAirplaneID,strAirplaneNumber, strAirplaneType, intAirplaneCapacity)
VALUES		(1,'111','HUGE', 100)
			, (2,'222','HUGER', 200)
INSERT INTO TFlights (intFlightID,strFlight,strDescription,intAirplaneID)
VALUES		(1,'123','CVG to ATL',1)
			,(2,'223','CVG to ATL',2)
INSERT INTO TPilots (intPilotID, strFirstName, strLastName,strPhoneNumber)
VALUES		(1,'John','Doe','(111)111-1111')
			, (2,'Mark','Doe','(111)121-1111')
INSERT INTO TFlightPilots(intFlightID,intPilotID,strPilotRole)
VALUES		(1,1,'Pilot')
			, (2,2,'Pilot')
INSERT INTO TFlightAttendants (intFlightAttendantID,strFirstName,strLastName,strPhoneNumber)
VALUES		(1,'Ron','Miller','(222)222-2222')
			, (2,'Terri',' Miller','(222)122-2222')
INSERT INTO TFlightFlightAttendants (intFlightID,intFlightAttendantID)
VALUES		(1,1)
			, (2,2)
INSERT INTO TPassengers (intPassengerID,strFirstName,strLastName,strPhoneNumber)
VALUES		(1,'Matt','Schlager','(111)123-4567')
			, (2,'Matt','Schlager II','(211)123-4567')
INSERT INTO TFlightPassengers (intFlightID,intPassengerIndex,intPassengerID,strSeatNumber)
VALUES		(1,1,1,'A1')
			, (2,2,2,'B1')
-- --------------------------------------------------------------------------------
-- Step #4.4: Write the join that will show all the flight information and all pilots (not co-pilots).  
--            Display the airplane information, too.    Be sure to include an ORDER BY clause.
-- --------------------------------------------------------------------------------
SELECT 
	TF.intFlightID
	,TF.strFlight
	,TF.strDescription
	,TFP.intPilotID
	,TP.strFirstName + ' ' + TP.strLastName AS strPilotName
	,TA.intAirplaneID
	,TA.strAirplaneNumber
	,TA.strAirplaneType
	,TA.intAirplaneCapacity
FROM
	TFlights AS TF
			JOIN TFlightPilots AS TFP
			ON (TF.intFlightID = TFP.intFlightID)
	
			JOIN TPilots AS TP	
			ON (TFP.intPilotID = TP.intPilotID AND TFP.strPilotRole = 'Pilot')
			
			JOIN TAirplanes AS TA
			ON (TF.intAirplaneID = TA.intAirplaneID)
ORDER BY
	TF.strFlight
-- --------------------------------------------------------------------------------
-- Step #4.4: Write the join that will show all passengers on all flights.  Be sure to include an ORDER BY clause.
-- --------------------------------------------------------------------------------
SELECT
	TF.intFlightID
	,TF.strFlight
	,TFP.intPassengerIndex
	,TFP.strSeatNumber
	,TP.strFirstName
	,TP.strLastname
FROM
	TFlights AS TF
			JOIN TFlightPassengers AS TFP
			ON (TF.intFlightID = TFP.intFlightID)

			JOIN TPassengers AS TP
			ON (TFP.intPassengerID = TP.intPassengerID)
ORDER BY
	TF.strFlight