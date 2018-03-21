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
-- Step #5.3: Write the SQL that will add at least 3 customers.
-- --------------------------------------------------------------------------------
INSERT INTO TCustomers (intCustomerID,strFirstName,strLastName)
VALUES		(1,'Sean','Kilpatrick')
			,(2,'Bogan','Borgdanivitch')
			,(3,'Marcules','Huertas')

-- --------------------------------------------------------------------------------
-- Step #5.4: Write the SQL that will add at least 3 orders for each customer.
-- --------------------------------------------------------------------------------
INSERT INTO TCustomerOrders(intCustomerID,intOrderIndex,dtmOrder)
VALUES		(1,1,'2016/01/01 1:00 pm')
			,(1,2,'2016/01/02 1:00 pm')
			,(1,3,'2016/01/03 1:00 pm')

			,(2,1,'2016/01/04 1:00 pm')
			,(2,2,'2016/01/05 1:00 pm')
			,(2,3,'2016/01/06 1:00 pm')

			,(3,1,'2016/01/07 1:00 pm')
			,(3,2,'2016/01/08 1:00 pm')
			,(3,3,'2016/01/09 1:00 pm')
-- --------------------------------------------------------------------------------
-- Step #5.5: Write the SQL that will add at least 2 items for each order.
-- --------------------------------------------------------------------------------
INSERT INTO TItems (intItemID,strItemName,monItemPrice)
VALUES		(1,'Item 1',10)
			,(2,'Item 2',100)
			,(3,'Item 3',1000)
			,(4,'Item 4',10000)
			,(5,'Item 5',100000)
			,(6,'Item 6',1000000)

INSERT INTO TCustomerOrderItems (intCustomerID,intOrderIndex, intItemID,intQuantity)
VALUES		(1,1,1,1)
			,(1,1,2,2)
			,(1,2,3,1)
			,(1,2,4,1)
			,(1,3,5,1)
			,(1,3,6,1)

			,(2,1,1,1)
			,(2,1,2,2)
			,(2,2,3,1)
			,(2,2,4,1)
			,(2,3,5,1)
			,(2,3,6,1)

			,(3,1,1,1)
			,(3,1,2,2)
			,(3,2,3,1)
			,(3,2,4,1)
			,(3,3,5,1)
			,(3,3,6,1)
