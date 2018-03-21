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

DROP TABLE TCustomerOrderItems
DROP TABLE TItems
DROP TABLE TCustomerOrders
DROP TABLE TCustomers

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
INSERT INTO TCustomerOrders(intCustomerID,intOrderIndex,dtmOrder)
VALUES		(1,1,'2016/01/01 1:00 pm')
			,(2,1,'2016/01/04 1:00 pm')
INSERT INTO TItems (intItemID,strItemName,monItemPrice)
VALUES		(1,'Item 1',10)
			,(2,'Item 2',100)
INSERT INTO TCustomerOrderItems (intCustomerID,intOrderIndex, intItemID,intQuantity)
VALUES		(1,1,1,1)
			,(2,1,2,1)

-- --------------------------------------------------------------------------------
-- Step #5.3: Write the join that will show all customers, their orders and the items on their orders.  
--            Be sure to include an ORDER BY clause.
-- --------------------------------------------------------------------------------
SELECT
	TC.intCustomerID
	,TC.strFirstName + ' ' + TC.strLastName AS strCustomerName
	,TCO.intOrderIndex
	,TCO.dtmOrder
	,TI.intItemID	
	,TI.strItemName
	,TI.monItemPrice
	,TCOI.intQuantity
FROM
	TCustomerOrderItems AS TCOI
	,TCustomers AS TC
	,TCustomerOrders AS TCO
	,TItems AS TI
WHERE
	TC.intCustomerID = TCO.intCustomerID
AND TCO.intCustomerID = TCOI.intCustomerID
AND TCO.intOrderIndex = TCOI.intOrderIndex
ORDER BY
	TC.strLastName
	,TC.strFirstName
	,TCO.dtmOrder
	,TI.strItemName









