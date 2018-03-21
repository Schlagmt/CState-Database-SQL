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

DROP TABLE TOrderDetails
DROP TABLE TOrder
DROP TABLE TCustomers

-- --------------------------------------------------------------------------------
-- Step #4.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TCustomers
(
	intCustomerID			INTEGER			NOT NULL
	,strFirstName			VARCHAR(50)		NOT NULL
	,strLastName			VARCHAR(50)		NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY( intCustomerID )
)

CREATE TABLE TOrder
(
	intCustomerID			INTEGER			NOT NULL
	,intOrderID				INTEGER			NOT NULL
	,dtmOrder				DATETIME		NOT NULL
	,CONSTRAINT TOrder_PK PRIMARY KEY( intCustomerID, intOrderID )
)

CREATE TABLE TOrderDetails
(
	intCustomerID			INTEGER			NOT NULL
	,intOrderID				INTEGER			NOT NULL
	,strItem				VARCHAR(50)		NOT NULL
	,intQuantity			INTEGER			NOT NULL
	,monPrice				MONEY			NOT NULL
	,CONSTRAINT TOrderDetails_PK PRIMARY KEY( intCustomerID, intOrderID, strItem )
)

-- --------------------------------------------------------------------------------
-- Step #4.2: 	Examine the table names
-- --------------------------------------------------------------------------------
--did it!!!!
-- --------------------------------------------------------------------------------
-- Step #4.3: Foreign Keys
-- --------------------------------------------------------------------------------
--
--#		Child					Parent					Column
--		-----					------					------
--		TOrder					TCustomers				intCustomerID
--		TOrderDetails			TCustomers				intCustomerID

ALTER TABLE TOrder ADD CONSTRAINT TOrder_TCustomers_FK
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )

ALTER TABLE TOrderDetails ADD CONSTRAINT TFlightAttendant_TCustomers_FK
FOREIGN KEY ( intCustomerID ) REFERENCES TCustomers ( intCustomerID )

-- --------------------------------------------------------------------------------
-- Step #4.4: Add three customers
-- --------------------------------------------------------------------------------

INSERT INTO TCustomers (intCustomerID,strFirstName,strLastName)
VALUES		(1,'Steph','Curry')
			,(2,'Steve','Curry')
			,(3,'Dell','Curry')

SELECT * FROM TCustomers

-- --------------------------------------------------------------------------------
-- Step #4.5: add at least 3 orders for each customer
-- --------------------------------------------------------------------------------

INSERT INTO TOrder(intCustomerID,intOrderID,dtmOrder)
VALUES		(1,1,'01/01/2016') 
			,(2,2,'02/01/2016')
			,(3,3,'03/01/2016')
			,(1,4,'04/01/2016')
			,(2,5,'05/01/2016')
			,(3,6,'06/01/2016')
			,(1,7,'07/01/2016')
			,(2,8,'08/01/2016')
			,(3,9,'09/01/2016')
			
SELECT * FROM TOrder

-- --------------------------------------------------------------------------------
-- Step #4.6: add at least 2 items for each order.
-- --------------------------------------------------------------------------------

INSERT INTO TOrderDetails (intCustomerID,intOrderID,strItem,intQuantity,monPrice)
VALUES		(1,1,'01', 1,'$10.00')
			,(1,1,'02', 1,'$10.00')
			,(1,2,'03', 1,'$10.00')
			,(1,2,'04', 1,'$10.00')
			,(2,3,'05', 1,'$10.00')
			,(2,3,'06', 1,'$10.00')
			,(2,4,'07', 1,'$10.00')
			,(2,4,'08', 1,'$10.00')
			,(3,5,'09', 1,'$10.00')
			,(3,5,'10', 1,'$10.00')
			,(3,6,'11', 1,'$10.00')
			,(3,6,'12', 1,'$10.00')

SELECT * FROM TOrderDetails
			