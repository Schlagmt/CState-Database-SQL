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
DROP TABLE TSalesRepresentatives

-- --------------------------------------------------------------------------------
-- Step #4.1: Create Tables
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
-- Step #4.2: Identify and Create Foreign Key
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
-- Step #4.3: Add sample data (at least two inserts per table).
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
-- Step #4.4: Write the query that will show the following information for every order: 
-- the customer ID and name, the order index, the order date, the total cost of the order, 
-- the total number of items in the order, the average price of each item in the order.
-- --------------------------------------------------------------------------------
SELECT
	TC.intCustomerID AS 'Customer ID'
	,TC.strFirstName + ' ' + TC.strLastName AS 'Customer Name'
	,TCO.intOrderIndex AS 'Order Index'
	,CONVERT (VARCHAR, TCO.dtmOrder, 111) AS 'Order Date'
	,SUM(TI.monItemPrice * TCOI.intQuantity) AS 'Order Total Price'
	,SUM(TCOI.intQuantity) AS 'Total Item Count'
	,SUM(TI.monItemPrice * TCOI.intQuantity) / SUM(TCOI.intQuantity) AS 'Order Average Item Price'
FROM
	TCustomers AS TC
	,TCustomerOrders AS TCO	
	,TCustomerOrderItems AS TCOI
	,TItems AS TI
WHERE
	TC.intCustomerID = TCO.intCustomerID
AND	TCO.intCustomerID = TCOI.intCustomerID
AND TCO.intOrderIndex = TCOI.intOrderIndex
AND TCOI.intItemID = TI.intItemID
GROUP BY
	TC.intCustomerID 
	,TC.strFirstName
	,TC.strLastName 
	,TCO.intOrderIndex 
	,TCO.dtmOrder  	 
ORDER BY
	TC.strLastName
	,TC.strFirstName
	,TCO.dtmOrder
-- --------------------------------------------------------------------------------
-- Step #4.5: Write the query that will show the ID and name for every sales representative 
-- and the total sales for each sales representative for each of the last three years .  The query 
-- should return a row/record for each year for the last three years for each sales representative.  
-- --------------------------------------------------------------------------------
SELECT
	TSR.intSalesRepresentativesID AS 'Sales Representatives ID'
	,TSR.strFirstName + ' ' + TSR.strLastName 'Representatives Name'
	,DATEPART (YEAR,TCO.dtmOrder) AS 'Order Year'
	,SUM(TCOI.intQuantity * TI.monItemPrice) AS 'Order Total Price'
FROM	
	TSalesRepresentatives AS TSR
	,TCustomerOrders AS TCO	
	,TCustomerOrderItems AS TCOI
	,TItems AS TI
WHERE
	TSR.intSalesRepresentativesID = TCO.intSalesRepresentativeID
AND TCO.intCustomerID = TCOI.intCustomerID
AND TCOI.intOrderIndex = TCOI.intOrderIndex
AND TCOI.intItemID = TI.intItemID
GROUP BY
	TSR.intSalesRepresentativesID
	,TSR.strFirstName 
	,TSR.strLastName 
	,TCO.dtmOrder
ORDER BY
	TSR.strLastName
	,TSR.strFirstName
	,TCO.dtmOrder


