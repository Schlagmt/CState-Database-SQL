-- --------------------------------------------------------------------------------
-- Name: Matthew Schlager
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL2; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors
-- --------------------------------------------------------------------------------
-- Drop Table
-- --------------------------------------------------------------------------------

IF OBJECT_ID( 'TCustomerOrderItems' ) IS NOT NULL DROP TABLE TCustomerOrderItems
IF OBJECT_ID( 'TItems' ) IS NOT NULL DROP TABLE TItems
IF OBJECT_ID( 'TCustomerOrders' ) IS NOT NULL DROP TABLE TCustomerOrders
IF OBJECT_ID( 'TCustomers' ) IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID( 'TSalesRepresentatives' ) IS NOT NULL DROP TABLE TSalesRepresentatives

IF OBJECT_ID( 'VCustomerOrderItems' )  IS NOT NULL DROP VIEW  VCustomerOrderItems

-- --------------------------------------------------------------------------------
-- Step #5.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TCustomers
(
	intCustomerID						INTEGER			NOT NULL
	,strFirstName						VARCHAR(50)		NOT NULL
	,strLastName						VARCHAR(50)		NOT NULL			
	,CONSTRAINT TCustomers_PK PRIMARY KEY( intCustomerID )
)
CREATE TABLE TCustomerOrders
(
	intCustomerID						INTEGER			NOT NULL
	,intOrderIndex						INTEGER			NOT NULL
	,dtmOrder							DATETIME		NOT NULL
	,intSalesRepresentativeID			INTEGER			NOT NULL	
	,CONSTRAINT TCustomerOrders_PK PRIMARY KEY( intCustomerID, intOrderIndex )
)
CREATE TABLE TCustomerOrderItems
(
	intCustomerID						INTEGER			NOT NULL
	,intOrderIndex						INTEGER			NOT NULL	
	,intItemID							INTEGER			NOT NULL
	,intQuantity						INTEGER			NOT NULL	
	,CONSTRAINT TCustomerOrderItems_PK PRIMARY KEY( intCustomerID,intOrderIndex,intItemID )
)
CREATE TABLE TItems
(
	intItemID							INTEGER			NOT NULL
	,strItemName						VARCHAR(50)		NOT NULL
	,monItemPrice						MONEY			NOT NULL
	,CONSTRAINT TItems_PK PRIMARY KEY ( intItemID )	
)
CREATE TABLE TSalesRepresentatives
(
	intSalesRepresentativesID			INTEGER			NOT NULL
	,strFirstName						VARCHAR(50)		NOT NULL
	,strLastName						VARCHAR(50)		NOT NULL
	,CONSTRAINT TSalesRepresentatives_PK PRIMARY KEY ( intSalesRepresentativesID )
)
-- --------------------------------------------------------------------------------
-- Step #5.2: Identify and Create Foreign Key
-- --------------------------------------------------------------------------------
--
--#		Child					Parent					Column
--		-----					------					------
--		TCustomerOrder			TCustomers				intCustomerID
--		TCustomerOrderItems		TCustomerOrders			intCustomerID, intOrderIndex
--		TCustomerOrderItems		TItems					intItemID
ALTER TABLE TCustomerOrders ADD CONSTRAINT TCustomerOrders_TCustomers_FK
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )
ALTER TABLE TCustomerOrderItems ADD CONSTRAINT TCustomerOrderItems_TCustomerOrders_FK
FOREIGN KEY ( intCustomerID,intOrderIndex ) REFERENCES TCustomerOrders ( intCustomerID,intOrderIndex )
ALTER TABLE TCustomerOrderItems ADD CONSTRAINT TCustomerOrderItems_TItems_FK
FOREIGN KEY ( intItemID ) REFERENCES TItems ( intItemID )
-- --------------------------------------------------------------------------------
-- Step #5.3: Add sample data (at least two inserts per table).
-- --------------------------------------------------------------------------------
INSERT INTO TCustomers (intCustomerID,strFirstName,strLastName)
VALUES		(1,'Sean','Kilpatrick')
			,(2,'Bogan','Borgdanivitch')
			,(3,'Brady','Tom')
			,(4,'Hady','Haudy')
			,(5,'Mady','Mad')
INSERT INTO TSalesRepresentatives (intSalesRepresentativesID,strFirstName,strLastName)
VALUES		(1,'Matt','Dong')
			,(2,'Tam','Tong')
			,(3,'Nam','Bong')
INSERT INTO TCustomerOrders(intCustomerID,intOrderIndex,dtmOrder,intSalesRepresentativeID)
VALUES		(1,1,'2016-03-01',1)
			,(2,2,'2014-03-01',2)
			,(3,3,'2014-04-01',3)
			,(4,4,'2014-05-01',1)
			,(5,5,'2015-06-01',2)
			,(3,6,'2015-03-01',3)
			,(5,7,'2015-02-01',1)
			,(1,8,'2016-01-01',2)
			,(4,9,'2016-01-01',3)
INSERT INTO TItems (intItemID,strItemName,monItemPrice)
VALUES		(1,'Item 5',10)
			,(2,'Item 4',10000)
			,(3,'Item 3',100000)
			,(4,'Item 2',1000000)
			,(5,'Item 1',10000000)
INSERT INTO TCustomerOrderItems (intCustomerID,intOrderIndex, intItemID,intQuantity)
VALUES		(1,1,1,1)
			,(2,2,2,2)
			,(3,3,3,1)
			,(4,4,4,5)
			,(5,5,5,1)
			,(3,6,1,2)
			,(5,7,2,1)
			,(1,8,3,4)
-- --------------------------------------------------------------------------------
-- Step #5.4: Create the view VCustomerOrderItems.  Write few test SELECT commands to make sure it works correctly.
-- --------------------------------------------------------------------------------
GO

CREATE VIEW VCustomerOrderItems
AS
SELECT
	TC.intCustomerID
	,TC.strFirstName + ' ' + TC.strLastName AS strFullName
	,TCOI.intOrderIndex
	,TI.intItemID
	,TI.strItemName
FROM
	TCustomers AS TC
	,TCustomerOrderItems AS TCOI
	,TItems AS TI
WHERE
	TC.intCustomerID = TCOI.intCustomerID
AND TCOI.intItemID = TI.intItemID

GO

