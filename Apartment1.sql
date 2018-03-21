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
DROP TABLE TApartmentTenantContactInfo
DROP TABLE TApartmentUnit
DROP TABLE TApartmentBuildings
-- --------------------------------------------------------------------------------
-- Create Table
-- --------------------------------------------------------------------------------
CREATE TABLE TApartmentBuildings
(
	intBuildingID					INTEGER			NOT NULL
	,strAddress						VARCHAR(50)		NOT NULL
	,strOwnerName					VARCHAR(50)		NOT NULL
	,CONSTRAINT TApartmentBuildings_PK PRIMARY KEY( intBuildingID )
)
CREATE TABLE TApartmentUnit
(
	intBuildingID					INTEGER			NOT NULL
	,intUnitID						INTEGER			NOT NULL
	,strUnitDescription				VARCHAR(50)		NOT NULL
	,monUnitRentAmount				MONEY			NOT NULL
	,CONSTRAINT TApartmentUnit_PK PRIMARY KEY( intBuildingID, intUnitID )
)
CREATE TABLE TApartmentTenantContactInfo
(
	intBuildingID					INTEGER			NOT NULL
	,intTenantID					INTEGER			NOT NULL
	,strUnitTenantName				VARCHAR(50)		NOT NULL
	,strUnitTenantPhone				VARCHAR(50)		NOT NULL
	,strUnitTenantHomePhone			VARCHAR(50)		NOT NULL
	,strUnitTenantWorkPhone			VARCHAR(50)		NOT NULL
	,CONSTRAINT TApartmentTenantContactInfo_PK PRIMARY KEY( intBuildingID, intTenantID )
)
-- --------------------------------------------------------------------------------
-- Step #2: Create foreign keys for your tables.
-- --------------------------------------------------------------------------------
--
--#		Child							Parent					Column
--		-----							------					------
--		TApartmentTenantContactInfo		TApartmentBuildings		intBuildingID
--		TApartmentUnit					TApartmentBuildings		intBuildingID

ALTER TABLE TApartmentTenantContactInfo ADD CONSTRAINT TApartmentTenantContactInfo_TApartmentBuildings_FK
FOREIGN KEY ( intBuildingID ) REFERENCES TApartmentBuildings ( intBuildingID )

ALTER TABLE TApartmentUnit ADD CONSTRAINT TApartmentUnit_TApartmentBuildings_FK
FOREIGN KEY ( intBuildingID ) REFERENCES TApartmentBuildings ( intBuildingID )

-- --------------------------------------------------------------------------------
-- Step #3: Write 2 inserts for each table
-- --------------------------------------------------------------------------------

INSERT INTO TApartmentBuildings(intBuildingID,strAddress, strOwnerName)
VALUES		(1, 'Address 1', 'Mark Doe')
			, (2, 'Address 2', 'Mary Doe')
SELECT * FROM TApartmentBuildings

INSERT INTO TApartmentUnit(intBuildingID, intUnitID, strUnitDescription, monUnitRentAmount)
VALUES		(1, 1, 'Large Home', '10000000')
			, (2, 2, 'Larger Home', '10000000000')
SELECT * FROM TApartmentUnit

INSERT INTO TApartmentTenantContactInfo(intBuildingID, intTenantID, strUnitTenantName, strUnitTenantPhone,strUnitTenantHomePhone, strUnitTenantWorkPhone)
VALUES		(1,1,'Matthew Schlager', '(555)555-5555', '(555)565-5555', '(555)555-5755')
			, (2,2,'Mark Anthony', '(555)655-5555', '(555)565-5655', '(555)555-5765')
SELECT * FROM TApartmentTenantContactInfo
