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
DROP TABLE TPatientVisitLabTestResults
DROP TABLE TPatientVisitLabTests
DROP TABLE TLabTests
DROP TABLE TPatientVisitMedications
DROP TABLE TMedications
DROP TABLE TPatientVisitProcedures
DROP TABLE TProcedures
DROP TABLE TPatientVisits
DROP TABLE TPatients
-- --------------------------------------------------------------------------------
-- Step #2.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TPatients
(
	intPatientID						INTEGER			NOT NULL
	,strFirstName						VARCHAR(50)		NOT NULL
	,strLastName						VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatients_PK PRIMARY KEY ( intPatientID )
)
CREATE TABLE TPatientVisits
(
	intPatientID						INTEGER			NOT NULL
	,intVisitIndex						INTEGER			NOT NULL
	,dtmVisitDate						DATETIME		NOT NULL
	,strVisitNotes						VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatientVisits_PK PRIMARY KEY ( intPatientID,intVisitIndex )
)
CREATE TABLE TPatientVisitProcedures
(
	intPatientID						INTEGER			NOT NULL
	,intVisitIndex						INTEGER			NOT NULL
	,intProceduresIndex					INTEGER			NOT NULL
	,intProcedureID						INTEGER			NOT NULL
	,strNotes							VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatientVisitProcedures_PK PRIMARY KEY ( intPatientID,intVisitIndex,intProceduresIndex )
)
CREATE TABLE TProcedures
(
	intProcedureID						INTEGER			NOT NULL
	,strProcedureName					VARCHAR(50)		NOT NULL
	,strBillingCode						VARCHAR(50)		NOT NULL
	,CONSTRAINT TProcedures_PK PRIMARY KEY ( intProcedureID )
)
CREATE TABLE TPatientVisitMedications
(
	intPatientID						INTEGER			NOT NULL
	,intVisitIndex						INTEGER			NOT NULL
	,intMedicationID					INTEGER			NOT NULL
	,strDosage							VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatientVisitMedications_PK PRIMARY KEY ( intPatientID,intVisitIndex,intMedicationID )
)
CREATE TABLE TMedications
(
	intMedicationID						INTEGER			NOT NULL
	,strMedicationName					VARCHAR(50)		NOT NULL
	,strBillingCode						VARCHAR(50)		NOT NULL
	,CONSTRAINT TMedications_PK PRIMARY KEY ( intMedicationID )
)
CREATE TABLE TPatientVisitLabTests
(
	intPatientID						INTEGER			NOT NULL
	,intVisitIndex						INTEGER			NOT NULL
	,intLabTestIndex					INTEGER			NOT NULL
	,intLabTestID						INTEGER			NOT NULL
	,CONSTRAINT TPatientVisitLabTests_PK PRIMARY KEY ( intPatientID,intVisitIndex,intLabTestIndex )
)
CREATE TABLE TLabTests
(
	intLabTestID						INTEGER			NOT NULL
	,strLabTestName						VARCHAR(50)		NOT NULL
	,strBillingCode						VARCHAR(50)		NOT NULL
	,CONSTRAINT TLabTests_PK PRIMARY KEY ( intLabTestID )
)	
CREATE TABLE TPatientVisitLabTestResults
(
	intPatientID						INTEGER			NOT NULL
	,intVisitIndex						INTEGER			NOT NULL
	,intLabTestIndex					INTEGER			NOT NULL
	,intResultsIndex					INTEGER			NOT NULL
	,strResult							VARCHAR(50)		NOT NULL
	,CONSTRAINT TPatientVisitLabTestResult_PK PRIMARY KEY ( intPatientID,intVisitIndex,intLabTestIndex,intResultsIndex )
)
-- --------------------------------------------------------------------------------
-- Step #2.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
--#		Child							Parent					Column
--		-----							------					------
--		TPatientVisits					TPatients				intPatientID
--		TPatientVisitProcedures			TPatientVisits			intPatientID,intVisitIndex
--		TPatientVisitProcedures			TProcedures				intProcedureID
--		TPatientVisitMedications		TPatientVisits			intPatientID,intVisitIndex
--		TPatientVisitMedications		TMedications			intMedicationID
--		TPatientVisitLabTests			TPatientVisits			intPatientID,intVisitIndex
--		TPatientVisitLabTests			TLabTests				intLabTestID
--		TPatientVisitLabTestResults		TPatientVisitLabTests	intPatientID,intVisitIndex,intLabTestIndex
ALTER TABLE TPatientVisits ADD CONSTRAINT TPatientVisits_TPatients_FK
FOREIGN KEY ( intPatientID ) REFERENCES TPatients ( intPatientID )
ALTER TABLE TPatientVisitProcedures ADD CONSTRAINT TPatientVisitProcedures_TPatientVisits_FK
FOREIGN KEY ( intPatientID,intVisitIndex ) REFERENCES TPatientVisits ( intPatientID,intVisitIndex )
ALTER TABLE TPatientVisitProcedures ADD CONSTRAINT TPatientVisitProcedures_TProcedures_FK
FOREIGN KEY ( intProcedureID ) REFERENCES TProcedures ( intProcedureID )
ALTER TABLE TPatientVisitMedications ADD CONSTRAINT TPatientVisitMedications_TPatientVisits_FK
FOREIGN KEY ( intPatientID,intVisitIndex ) REFERENCES TPatientVisits ( intPatientID,intVisitIndex )
ALTER TABLE TPatientVisitMedications ADD CONSTRAINT TPatientVisitMedications_TMedications_FK
FOREIGN KEY ( intMedicationID ) REFERENCES TMedications ( intMedicationID )
ALTER TABLE TPatientVisitLabTests ADD CONSTRAINT TPatientVisitLabTests_TPatientVisits_FK
FOREIGN KEY ( intPatientID,intVisitIndex ) REFERENCES TPatientVisits ( intPatientID,intVisitIndex )
ALTER TABLE TPatientVisitLabTests ADD CONSTRAINT TPatientVisitLabTests_TLabTests_FK
FOREIGN KEY ( intLabTestID ) REFERENCES TLabTests ( intLabTestID )
ALTER TABLE TPatientVisitLabTestResults ADD CONSTRAINT TPatientVisitLabTestResults_TPatientVisitLabTests_FK
FOREIGN KEY ( intPatientID,intVisitIndex,intLabTestIndex ) REFERENCES TPatientVisitLabTests ( intPatientID,intVisitIndex,intLabTestIndex )
-- --------------------------------------------------------------------------------
-- Step #2.3: Write the SQL that will add 2 patients.
-- --------------------------------------------------------------------------------
INSERT INTO TPatients (intPatientID,strFirstName,strLastName)
VALUES		(1,'Joe','Johnson')
			,(2,'John','Wall')
-- --------------------------------------------------------------------------------
-- Step #2.4: Write the SQL that will add at least 2 visits for each patient.
-- --------------------------------------------------------------------------------
INSERT INTO TPatientVisits (intPatientID,intVisitIndex,dtmVisitDate,strVisitNotes)
VALUES		(1,1,'2016/01/01','CheckUp')
			,(1,2,'2016/01/02','Flu')
			,(2,3,'2016/01/03','Stomach problem')
			,(2,4,'2016/01/04','Dizzy')
-- --------------------------------------------------------------------------------
-- Step #2.5: Write the SQL that will add at least 2 procedures for each patient visit.
-- --------------------------------------------------------------------------------
INSERT INTO TProcedures (intProcedureID,strProcedureName,strBillingCode)
VALUES		(1,'Procedure 1','ASD')
			,(2,'Procedure 2','DFG')
			,(3,'Procedure 3','GHJ')
			,(4,'Procedure 4','HJK')
INSERT INTO TPatientVisitProcedures (intPatientID,intVisitIndex,intProceduresIndex,intProcedureID,strNotes)
VALUES		(1,1,1,1,'Well')
			,(1,2,2,2,'Could have been better')
			,(2,3,3,3,'Awsome')
			,(2,4,4,4,'Bad')
-- --------------------------------------------------------------------------------
-- Step #2.6: Write the SQL that will add at least 2 medications for each patient visit.
-- --------------------------------------------------------------------------------
INSERT INTO TMedications (intMedicationID,strMedicationName,strBillingCode)
VALUES		(1,'Medication A','WER')
			,(2,'Medication B','RTY')
INSERT INTO TPatientVisitMedications (intPatientID,intVisitIndex,intMedicationID,strDosage)
VALUES		(1,1,1,'As needed')
			,(1,2,2,'Once a month')
			,(2,3,1,'Whenever')
			,(2,4,2,'As needed')
-- --------------------------------------------------------------------------------
-- Step #2.7: Write the SQL that will add at least 2 lab tests for each patient visit.
-- --------------------------------------------------------------------------------
INSERT INTO TLabTests(intLabTestID,strLabTestName,strBillingCode)
VALUES		(1,'Test A','ZXC')
			,(2,'Test B','CVB')
			,(3,'Test C','BNM')
			,(4,'Test D','VBN')
INSERT INTO TPatientVisitLabTests (intPatientID,intVisitIndex,intLabTestIndex,intLabTestID)
VALUES		(1,1,1,1)
			,(1,2,2,2)
			,(2,3,3,3)
			,(2,4,4,4)