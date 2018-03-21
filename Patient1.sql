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

DROP TABLE TPatientLabTest			
DROP TABLE TPatientMedication
DROP TABLE TPatientProcedure
DROP TABLE TPatientVisits
DROP TABLE TPatients

-- --------------------------------------------------------------------------------
-- Step #2.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TPatients
(
	intPatientID			INTEGER			NOT NULL
	, strFirstName			VARCHAR(50)		NOT NULL
	, strLastName			VARCHAR(50)		NOT NULL
	, CONSTRAINT TPatients_PK PRIMARY KEY( intPatientID )
)
CREATE TABLE TPatientVisits
(
	intPatientID				INTEGER			NOT NULL
	, intPatientVisitIndex		INTEGER			NOT NULL
	, dtmVisitDate				DATETIME		NOT NULL
	, strVisitNotes				VARCHAR(50)		NOT NULL
	, CONSTRAINT TPatientVisits_PK PRIMARY KEY( intPatientID, intPatientVisitIndex )
)
CREATE TABLE TPatientProcedure
(
	intPatientID						INTEGER			NOT NULL
	, intPatientProcedureIndex			INTEGER			NOT NULL
	, strVisitProcedure					VARCHAR(50)		NOT NULL
	, CONSTRAINT TPatientProcedure_PK PRIMARY KEY( intPatientID, intPatientProcedureIndex )
)
CREATE TABLE TPatientMedication
(
	intPatientID						INTEGER			NOT NULL
	, intPatientMedicationIndex			INTEGER			NOT NULL
	, strVisitMedication				VARCHAR(50)		NOT NULL
	, CONSTRAINT TPatientMedication_PK PRIMARY KEY( intPatientID, intPatientMedicationIndex )
)
CREATE TABLE TPatientLabTest
(
	intPatientID						INTEGER			NOT NULL
	, intPatientLabTestIndex			INTEGER			NOT NULL
	, strVisitLabTest					VARCHAR(50)		NOT NULL
	, strVisitLabTestResult				VARCHAR(50)		NOT NULL
	, CONSTRAINT TPatientLabTest_PK PRIMARY KEY( intPatientID, intPatientLabTestIndex )
)

-- --------------------------------------------------------------------------------
-- Step #2.2: Foreign Keys
-- --------------------------------------------------------------------------------
--
--#		Child					Parent					Column
--		-----					------					------
--		TPatientLabTest			TPatients				intPatientID
--		TPatientVisits			TPatients				intPatientID
--		TPatientMedication		TPatients				intPatientID
--		TPatientVisits			TPatients				intPatientID

ALTER TABLE TPatientVisits ADD CONSTRAINT TPatientVisits_TPatients_FK
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID )

ALTER TABLE TPatientProcedure ADD CONSTRAINT TPatientProcedure_TPatients_FK
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID )

ALTER TABLE TPatientMedication ADD CONSTRAINT TPatientMedication_TPatients_FK
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID )

ALTER TABLE TPatientLabTest ADD CONSTRAINT TPatientLabTest_TPatients_FK
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID )

-- --------------------------------------------------------------------------------
-- Step #2.3: Write the SQL that will add 2 patients
-- --------------------------------------------------------------------------------

INSERT INTO TPatients(intPatientID,strFirstName, strLastName)
VALUES		(1,'Maylen','Brewbaker')
			, (2,'Karl','Brewbaker')
SELECT * FROM TPatients

-- --------------------------------------------------------------------------------
-- Step #3.4: Write the SQL that will add at least 2 visits for each patient
-- --------------------------------------------------------------------------------

INSERT INTO TPatientVisits (intPatientID, intPatientVisitIndex, dtmVisitDate, strVisitNotes)
VALUES		(1,1,'1/1/2016','Father and Mother')
			, (2,2,'1/2/2016','Brother and Sister')
			, (1,3,'1/3/2016','Father and Mother')
			, (2,4,'1/4/2016','Brother and Sister')
SELECT * FROM TPatientVisits

-- --------------------------------------------------------------------------------
-- Step #3.5: Write the SQL that will add at least 2 procedures for each patient visit
-- --------------------------------------------------------------------------------

INSERT INTO TPatientProcedure (intPatientID, intPatientProcedureIndex, strVisitProcedure)
VALUES		(1,1,'Tommy John Surgery')
			, (1,2,'ACL Surgery')
			, (2,3,'MCL Surgery')
			, (2,4,'Foot Surgery')
SELECT * FROM TPatientProcedure
-- --------------------------------------------------------------------------------
-- Step #3.6: Write the SQL that will add at least 2 medications for each patient visit
-- --------------------------------------------------------------------------------

INSERT INTO TPatientMedication (intPatientID, intPatientMedicationIndex, strVisitMedication)
VALUES		(1,1,'Medicine D')
			, (1,2,'Medicine C')
			, (2,3,'Medicine B')
			, (2,4,'Medicine A')
SELECT * FROM TPatientMedication

-- --------------------------------------------------------------------------------
-- Step #3.7 and 3.8: Write the SQL that will add at least 2 lab tests + results for each patient visit
-- --------------------------------------------------------------------------------

INSERT INTO TPatientLabTest (intPatientID, intPatientLabTestIndex, strVisitLabTest, strVisitLabTestResult)
VALUES		(1,1,'Test A', 'Positive')
			, (1,2,'Test B', 'Positive')
			, (2,3,'Test C', 'Negative')
			, (2,4,'Test D', 'Positive')
SELECT * FROM TPatientLabTest


	
	
	

