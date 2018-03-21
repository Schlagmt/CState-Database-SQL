-- --------------------------------------------------------------------------------
-- Name: Matthew Schlager
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL4; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors
-- --------------------------------------------------------------------------------
-- Drop Table
-- --------------------------------------------------------------------------------

DROP TABLE TFlightsAttendants
DROP TABLE TFlightPassengers
DROP TABLE TFlightsPilots
DROP TABLE TFlights

-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TFlights
(
		intFlightID					INTEGER			NOT NULL
		, strFlightNumber			VARCHAR(50)		NOT NULL
		, strDescription			VARCHAR(50)		NOT NULL	--(e.g. CVG to ATL)
		, strAirplaneNumber			VARCHAR(50)		NOT NULL
		, strAirplaneType			VARCHAR(50)		NOT NULL
		, intAirplaneCapacity		INTEGER			NOT NULL
		, CONSTRAINT TFlights_PK PRIMARY KEY( intFlightID )
)
CREATE TABLE TFlightsPilots
(
		intFlightID					INTEGER			NOT NULL
		, intFlightPilotsIndex		INTEGER			NOT NULL	
		, strPilotName				VARCHAR(50)		NOT NULL
		, strPilotPhoneNumber		VARCHAR(50)		NOT NULL
		, strCoPilotName			VARCHAR(50)		NOT NULL
		, strCoPilotPhoneNumber		VARCHAR(50)		NOT NULL
		, strBackupPilotName		VARCHAR(50)		NOT NULL	
		, strBackupPilotPhoneNumber	VARCHAR(50)		NOT NULL
		, CONSTRAINT TFlightsPilots_PK PRIMARY KEY( intFlightID, intFlightPilotsIndex )
)
CREATE TABLE TFlightsPassengers	
(
		intFlightID					INTEGER			NOT NULL
		, intFlightPassangersIndex	INTEGER			NOT NULL
		, strPassengerName			VARCHAR(50)		NOT NULL
		, strPassengerPhoneNumber   VARCHAR(50)		NOT NULL   --200
		, strPassengerSeatNumber	VARCHAR(50)		NOT NULL
		, CONSTRAINT TFlightsPassengers_PK PRIMARY KEY( intFlightID, intFlightPassangersIndex )
)
CREATE TABLE TFlightsAttendants
(
		intFlightID								INTEGER			NOT NULL
		, intFlightAttendantsIndex				INTEGER			NOT NULL
		, strChiefFlightAttendantName			VARCHAR(50)		NOT NULL
		, strChiefFlightAttendantPhoneNumber	VARCHAR(50)		NOT NULL
		, strFlightAttendantName				VARCHAR(50)		NOT NULL
		, strFlightAttendantPhoneNumber			VARCHAR(50)		NOT NULL    --5
		, CONSTRAINT TFlightsAttendants_PK PRIMARY KEY( intFlightID, intFlightAttendantsIndex )
)

-- --------------------------------------------------------------------------------
-- Step #1.2: Foreign Keys
-- --------------------------------------------------------------------------------
--
--#		Child					Parent					Column
--		-----					------					------
--		TFlightsPilots			TFlights				intFlightID
--		TFlightsPassengers		TFlights				intFlightID
--		TFlightsAttendants		TFlights				intFlightID

ALTER TABLE TFlightsPilots ADD CONSTRAINT TFlightsPilots_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

ALTER TABLE TFlightsPassengers ADD CONSTRAINT TFlightsPassengers_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

ALTER TABLE TFlightsAttendants ADD CONSTRAINT TFlightsAttendants_TFlights_FK
FOREIGN KEY ( intFlightID ) REFERENCES TFlights ( intFlightID )

-- --------------------------------------------------------------------------------
-- Step #1.3: Write the SQL that will add at least 3 flights.
-- --------------------------------------------------------------------------------

INSERT INTO TFlights (intFlightID, strFlightNumber, strDescription, strAirplaneNumber, strAirplaneType, intAirplaneCapacity)
VALUES		(1,'1','CVG to ATL','111','HUGE', 100)
			, (2,'2','CVG to ATL','222','HUGER', 200)
			, (3,'3','CVG to ATL','333','HUGEST', 300)
SELECT * FROM TFlights

-- --------------------------------------------------------------------------------
-- Step #1.4: Write the SQL that will add at least 2 pilots to each flight.
-- --------------------------------------------------------------------------------

INSERT INTO TFlightsPilots (intFlightID, intFlightPilotsIndex, strPilotName, strPilotPhoneNumber, strCoPilotName,strCoPilotPhoneNumber,strBackupPilotName,strBackupPilotPhoneNumber)
VALUES		(1,1,'John Doe','(111)111-1111','John Doe II','(111)211-1111','John Doe III','(111)311-1111')
			, (1,2,'Mark Doe','(111)121-1111','Mark Doe II','(111)221-1111','Mark Doe III','(111)321-1111')
			, (2,3,'Ham Doe','(111)111-9111','Ham Doe II','(111)211-9111','Ham Doe III','(111)311-9111')
			, (2,4,'Sam Doe','(111)111-1911','Sam Doe II','(111)211-1911','Sam Doe III','(111)311-1911')
			, (3,5,'Tam Doe','(111)181-1111','Tam Doe II','(111)281-1111','Tam Doe III','(111)381-1111')
			, (3,6,'Sara Doe','(131)111-1111','Sara Doe II','(211)211-1111','Sara Doe III','(111)301-1111')
SELECT * FROM TFlightsPilots

-- --------------------------------------------------------------------------------
-- Step #1.5: Write the SQL that will add at least 2 flight attendants to each flight.
-- --------------------------------------------------------------------------------

INSERT INTO TFlightsAttendants (intFlightID, intFlightAttendantsIndex,strChiefFlightAttendantName,strChiefFlightAttendantPhoneNumber,strFlightAttendantName,strFlightAttendantPhoneNumber)
VALUES		(1,1,'Ron Miller','(222)222-2222','Ron Miller II','(222)222-2222')
			, (1,2,'Terri Miller','(222)122-2222','Terri Miller II','(222)322-2222')
			, (2,3,'Jerri Miller','(222)222-0222','Jerri Miller II','(222)222-1222')
			, (2,4,'DaVonne Miller','(122)222-2222','DaVonne Miller II','(212)222-2222')
			, (3,5,'Jake Miller','(222)292-2222','Jake Miller II','(222)922-2222')
			, (3,6,'Shannon Miller','(222)222-2232','Shannon Miller II','(222)222-2202')
SELECT * FROM TFlightsAttendants

-- --------------------------------------------------------------------------------
-- Step #1.6: Write the SQL that will add at least 2 passengers to each flight.
-- --------------------------------------------------------------------------------

INSERT INTO TFlightsPassengers (intFlightID, intFlightPassangersIndex, strPassengerName,strPassengerPhoneNumber,strPassengerSeatNumber)
VALUES		(1,1,'Matt Schlager','(111)123-4567','1')
			, (1,2,'Matt Schlager II','(211)123-4567','2')
			, (2,3,'Matt Schlager III','(311)123-4567','3')
			, (2,4,'Matt Schlager IV','(141)123-4567','4')
			, (3,5,'Matt Schlager V','(115)123-4567','5')
			, (3,6,'Matt Schlager VI','(161)123-4567','6')
SELECT * FROM TFlightsPassengers