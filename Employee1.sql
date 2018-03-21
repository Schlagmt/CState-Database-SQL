-- --------------------------------------------------------------------------------
-- Name: Matthew Schlager
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1		-- Get out of the master database
SET NOCOUNT ON	-- Report only errors

-- --------------------------------------------------------------------------------
-- Step #1: Create Tables
-- --------------------------------------------------------------------------------
Drop Table TEmployees
Create table TEmployees
(
	  intEmployeeID	INTEGER		NOT NULL
	, strFirstName	Varchar(50)	NOT NULL
	, strLastName	Varchar(50)	NOT NULL
	, dtmDateofHire	Date		NOT NULL
	, monSalary		Money		NOT NULL
	, Constraint TEmployees_PK Primary Key (intEmployeeID)
)

-- --------------------------------------------------------------------------------
-- Step #2: Insert statements
-- --------------------------------------------------------------------------------

Insert into TEmployees (intEmployeeID, strFirstName, strLastName, dtmDateofHire, monSalary)
Values (1, 'Luke', 'Skywalker', '2013/01/01', 30000)

Insert into TEmployees (intEmployeeID, strFirstName, strLastName, dtmDateofHire, monSalary)
Values (2, 'Obi-Wan', 'Kenobi', '2012/02/02', 75000)

Insert into TEmployees (intEmployeeID, strFirstName, strLastName, dtmDateofHire, monSalary)
Values (3, 'John', 'Starks', '2011/03/03', 100000)

Insert into TEmployees (intEmployeeID, strFirstName, strLastName, dtmDateofHire, monSalary)
Values (4, 'Reggie', 'Miller', '2010/04/04', 65000)

Insert into TEmployees (intEmployeeID, strFirstName, strLastName, dtmDateofHire, monSalary)
Values (5, 'Karl', 'Malone', '2009/05/05', 95000)

-- --------------------------------------------------------------------------------
-- Step #3: Select statements
-- --------------------------------------------------------------------------------
Select
	intEmployeeID
	,strLastName
From
	TEmployees

Select
	strFirstName
	,strLastName
From
	TEmployees
Where
	monSalary	> 55000
or	strLastName LIKE 'M%'

Select
	strFirstName
	,strLastName
From
	TEmployees
Where
	intEmployeeID	> 3

Select
	strFirstName
	,strLastName
From
	TEmployees
Where
	strFirstName LIKE 'J%'


Select
	strFirstName
	,strLastName
From
	TEmployees
Where
	monSalary	= 100000

-- --------------------------------------------------------------------------------
-- Step #4: Update statements
-- --------------------------------------------------------------------------------

Update 
	TEmployees
Set
	monSalary	= monSalary * 1.1

Update 
	TEmployees
Set
	monSalary	= monSalary * 8
Where
	monSalary	= 100000

Update 
	TEmployees
Set
	strLastName		= 'The Mail Man'
Where
	intEmployeeID	= 5

Update 
	TEmployees
Set
	dtmDateofHire	= '2015/06/06'
Where
	intEmployeeID	= 4

Update
	TEmployees
Set
	strFirstName	= 'Lucas'
Where
	strFirstName	= 'Luke'
or	strLastName		= 'Skywalker'
or	intEmployeeID	= 1

-- --------------------------------------------------------------------------------
-- Step #5: Delete statements
-- --------------------------------------------------------------------------------
Delete from TEmployees
Where
	monSalary > 100000000000

Delete from TEmployees
Where
	strFirstName = 'Mark'

Delete from TEmployees
Where
	intEmployeeID > 7

Delete from TEmployees
Where
	monSalary <	10

Delete from TEmployees
Where
	strLastName = 'Manny'

