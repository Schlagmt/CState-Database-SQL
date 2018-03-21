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
IF OBJECT_ID( 'TJobWorkers' ) IS NOT NULL DROP TABLE TJobWorkers
IF OBJECT_ID( 'TWorkerSkills' ) IS NOT NULL DROP TABLE TWorkerSkills

IF OBJECT_ID( 'TJobMaterials' ) IS NOT NULL DROP TABLE TJobMaterials
IF OBJECT_ID( 'TJobs' ) IS NOT NULL DROP TABLE TJobs
IF OBJECT_ID( 'TMaterials' ) IS NOT NULL DROP TABLE TMaterials
IF OBJECT_ID( 'TSkills' ) IS NOT NULL DROP TABLE TSkills
IF OBJECT_ID( 'TStatus' ) IS NOT NULL DROP TABLE TStatus
IF OBJECT_ID( 'TWorkers' ) IS NOT NULL DROP TABLE TWorkers
IF OBJECT_ID( 'TCustomers' ) IS NOT NULL DROP TABLE TCustomers
IF OBJECT_ID( 'VLaborCosts' )  IS NOT NULL DROP VIEW  VLaborCosts
-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TWorkers
(
	intWorkerID												INTEGER			NOT NULL
	,strFirstName											VARCHAR(50)		NOT NULL
	,strLastName											VARCHAR(50)		NOT NULL
	,dteHireDate											DATE			NOT NULL
	,monHourlyRate											MONEY			NOT NULL
	,CONSTRAINT TWorkers_PK PRIMARY KEY( intWorkerID )
)
CREATE TABLE TStatus
(
	intJobStatusID											INTEGER			NOT NULL
	,strJobStatus											VARCHAR(50)		NOT NULL
	,CONSTRAINT TStatus_PK PRIMARY KEY( intJobStatusID )
)
CREATE TABLE TSkills
(
	intSkillID												INTEGER			NOT NULL
	,strSkillDescription									VARCHAR(50)		NOT NULL
	,CONSTRAINT TSkills_PK PRIMARY KEY( intSkillID )
)
CREATE TABLE TMaterials
(
	intMaterialID											INTEGER			NOT NULL
	,strMaterialName										VARCHAR(50)		NOT NULL
	,monMatieralCost										MONEY			NOT NULL
	,CONSTRAINT TMaterials_PK PRIMARY KEY( intMaterialID )
)
CREATE TABLE TJobs
(
	intJobID												INTEGER			NOT NULL
	,intJobStatusID											INTEGER			NOT NULL	
	,strJobDescription										VARCHAR(2000)	NOT NULL
	,dteStartDate											DATE			NOT NULL
	,dteEndDate												DATE			NOT NULL
	,CONSTRAINT TJobs_PK PRIMARY KEY( intJobID,intJobStatusID )
)
CREATE TABLE TJobMaterials
(
	intMaterialID											INTEGER			NOT NULL
	,intJobID												INTEGER			NOT NULL
	,intMaterialQuantity									INTEGER			NOT NULL
	,CONSTRAINT TJobMaterials_PK PRIMARY KEY(intMaterialID, intJobID)
)
CREATE TABLE TCustomers
(
	intCustomerID											INTEGER			NOT NULL
	,intJobID												INTEGER			NOT NULL
	,strFirstName											VARCHAR(50)		NOT NULL
	,strLastName											VARCHAR(50)		NOT NULL
	,strAddress												VARCHAR(50)		NOT NULL
	,strCity												VARCHAR(50)		NOT NULL
	,strState												VARCHAR(50)		NOT NULL
	,strZipCode												VARCHAR(50)		NOT NULL
	,CONSTRAINT TCustomers_PK PRIMARY KEY( intJobID )
)
CREATE TABLE TWorkerSkills
(
	intWorkerID												INTEGER			NOT NULL
	,intSkillID												INTEGER			NOT NULL
	,CONSTRAINT TWorkerSkills_PK PRIMARY KEY( intWorkerID , intSkillID)
)
CREATE TABLE TJobWorkers
(
	intJobID												INTEGER			NOT NULL
	,intWorkerID											INTEGER			NOT NULL
	,intTotalHoursWorkedByWorker							INTEGER			NOT NULL
	,CONSTRAINT TJobWorkers_PK PRIMARY KEY( intJobID , intWorkerID )
)
-- --------------------------------------------------------------------------------
-- Step #1.2: Create foreign key constraints to enforce referential integrity for all relationships.
--			  (Just to give you a heads up, I could not get the foriegn keys to work. 
--             I commented them out and the program worked fine)
-- --------------------------------------------------------------------------------
--		Parent			Child				Column

--		TWorkers		TWorkerSkills		intWorkerID
--		TWorkers		TJobWorkers			intWorkerID
--		TMaterials		TJobMaterials		intMaterialID
--		TStatus			TJobs				intJobStatusID
--		TJobs			TCustomers			intCustomerID
--		TJobs			TJobMaterials		intJobID
--		TJobs			TJobWorkers			intJobID	
--		TSkills			TWorkerSkills		intSkillID
--ALTER TABLE TWorkerSkills ADD CONSTRAINT TWorkers_TWorkerSkills_FK
--FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )
--ALTER TABLE TJobWorkers ADD CONSTRAINT TWorkers_TJobWorkers_FK
--FOREIGN KEY ( intWorkerID ) REFERENCES TWorkers ( intWorkerID )
--ALTER TABLE TJobMaterials ADD CONSTRAINT TMaterials_TJobMaterials_FK
--FOREIGN KEY ( intMaterialID ) REFERENCES TMaterials ( intMaterialID )
--ALTER TABLE TJobs ADD CONSTRAINT TStatus_TJobs_FK
--FOREIGN KEY ( intJobStatusID ) REFERENCES TStatus ( intJobStatusID )
--ALTER TABLE TJobs ADD CONSTRAINT TJobs_TCustomers_FK
--FOREIGN KEY ( intJobID ) REFERENCES TCustomers ( intJobID )
--ALTER TABLE TJobMaterials ADD CONSTRAINT TJobs_TJobMaterials_FK
--FOREIGN KEY ( intJobID ) REFERENCES TJobs ( intJobID )
--ALTER TABLE TJobs ADD CONSTRAINT TJobs_TJobWorkers_FK
--FOREIGN KEY ( intJobID ) REFERENCES TJobWorkers ( intJobID )
--ALTER TABLE TSkills ADD CONSTRAINT TSkills_TWorkerSkills_FK
--FOREIGN KEY ( intSkillID ) REFERENCES TWorkerSkills ( intSkillID )
-- --------------------------------------------------------------------------------
-- Step #2.1: Populate each table with test data. Make sure that you have sufficient 
--            data to test all indicated Updates, Deletes, and Queries.
-- --------------------------------------------------------------------------------
INSERT INTO TWorkers (intWorkerID,strFirstName,strLastName,dteHireDate,monHourlyRate)
VALUES		(1,'Mark','Anthony','01/01/2016',15.00)
			,(2,'Sam','Bradford','02/01/2016',25.00)
			,(3,'Tam','Kim','03/01/2015',10.00)
			,(4,'Bill','Tull','04/01/2016',17.00)
			,(5,'Mill','Patty','05/01/2016',18.00)
			,(6,'Sill','Hill','06/01/2015',13.00)
			,(7,'Cam','Newton','07/01/2016',12.00)
			,(8,'Pam','Van','08/01/2016',30.00)
			,(9,'Fam','Cham','09/01/2015',19.00)
			,(10,'Kam','Kimer','10/01/2016',15.00)

INSERT INTO TStatus (intJobStatusID,strJobStatus)
VALUES		(1,'Open')
			,(2,'In Progress')
			,(3,'Complete')

INSERT INTO TSkills (intSkillID,strSkillDescription)
VALUES		(1,'Planner')
			,(2,'Sander')
			,(3,'Painting')
			,(4,'Drawing')
			,(5,'Hammering')
			,(6,'Climbing')
			,(8,'Gaming')
			,(9,'Talking')
			,(10,'Eating')
			,(11,'Sleeping')
			,(12,'Hitting')
			,(13,'Fighting')
			,(14,'Rapping')
			,(15,'Singing')
			,(16,'Learning')
			,(17,'Running')
			,(18,'Walking')
			,(19,'Standing')
			,(20,'Nailing')

INSERT INTO TMaterials (intMaterialID,strMaterialName,monMatieralCost)
VALUES		(1,'Wood',100)
			,(2,'Stone',100)
			,(3,'Concrete',50)
			,(4,'Diamond',10000)
			,(5,'Silver',1000)
			,(6,'Iron',1050)
			,(7,'Gold',3000)
			,(8,'Titanium',400)
			,(9,'Tritanium',200)
			,(10,'Paint',20)
			,(11,'Morter',20)
			,(12,'Unobtainium',100000)

INSERT INTO TJobs (intJobID,intJobStatusID,strJobDescription,dteStartDate,dteEndDate)
VALUES		(1,1,'Adding a modern Kitchen','01/01/2016','12/01/2016')
			,(2,2,'Demolishing old barn','02/01/2016','12/01/2016')
			,(3,3,'Adding on a Master closet','03/01/2016','03/30/2016')
			,(4,1,'Remodeling bedrooms','04/01/2016','12/01/2016')
			,(5,2,'Repaving driveway','05/01/2016','12/01/2016')
			,(6,1,'Painting hallway','06/01/2016','09/01/2016')
			,(7,2,'Repaving street','05/01/2015','12/01/2015')
			,(8,3,'Painting bedroom','06/01/2015','09/01/2015')

INSERT INTO TJobMaterials (intJobID,intMaterialID,intMaterialQuantity)
VALUES		( 1 , 1 , 1 )
			,( 2 , 2 , 2 )
			,( 3 , 3 , 2 )
			,( 4 , 4 , 1 )
			,( 5 , 5 , 1 )
			,( 6 , 6 , 2 )
			,( 7 , 7 , 2 )
			,( 8 , 8 , 1 )
			,( 1 , 9 , 3 )
			,( 2 , 10 , 3 )
			,( 3 , 11 , 3 )
			,( 4 , 5 , 1 )
			,( 5 , 9 , 4 )
			,( 6 , 9 , 5 )
			,( 7 , 1 , 6 )
			,( 8 , 9 , 3 )
			,( 1 , 7 , 1 )
			,( 2 , 8 , 1 )
			,( 3 , 5 , 1 )
			,( 4 , 11 , 1 )
			,( 5 , 1 , 2 )
			,( 1 , 2 , 2 )
			,( 2 , 3 , 2 )
			,( 3 , 4 , 2 )

INSERT INTO TCustomers(intCustomerID,intJobID,strFirstName,strLastName,strAddress,strCity,strState,strZipCode)
VALUES		(1,1,'Emily','Bruns','1111 Main Street','West Chester','Ohio','45242')	
			,(2,2,'Maylen','Jahn','2222 Main Street','Montgomery','Ohio','45243')
			,(3,3,'Brenna','Schlager','3333 Main Street','Indian Hill','Ohio','45244')
			,(4,4,'Cara','Roach','4444 Four Rd','Sharonville','Ohio','45245')
			,(5,5,'Ryan','Roach','5555 Main Street','Cincinnati','Ohio','45246')
			,(6,6,'Tom','Miller','6666 Orleans Ct','Blue Ash','Ohio','45247')
			,(6,7,'Tom','Miller','6666 Orleans Ct','Blue Ash','Ohio','45247')
			,(6,8,'Tom','Miller','6666 Orleans Ct','Blue Ash','Ohio','45247')										

INSERT INTO TWorkerSkills (intWorkerID,intSkillID)
VALUES		( 1 , 1 )
			,( 2 , 2 )
			,( 3 , 3 )
			,( 4 , 4 )
			,( 5 , 5 )
			,( 6 , 5 )
			,( 7 , 1 )
			,( 8 , 7 )
			,( 8 , 8 )
			,( 10 , 9 )
			,( 1 , 10 )
			,( 2 , 11 )
			,( 3 , 12 )
			,( 4 , 1 )
			,( 5 , 14 )
			,( 6 , 15 )
			,( 1 , 16 )
			,( 2 , 17 )
			,( 3 , 18 )
			,( 1 , 19 )
			,( 2 , 20 )

INSERT INTO TJobWorkers (intJobID,intWorkerID,intTotalHoursWorkedByWorker)
VALUES		( 1 , 1 , 0)
			,( 2 , 2 , 60)
			,( 3 , 3 , 80)
			,( 4 , 4 , 10)
			,( 5 , 5 , 100)
			,( 6 , 6 , 50)
			,( 7 , 7 , 150)
			,( 8 , 8 , 10)
			,( 3 , 9 , 70)
			,( 4 , 10 , 75)
			,( 5 , 7 , 120)
			,( 6 , 8 , 200)
			,( 7 , 9 , 19)
			,( 8 , 10 , 199)
			,( 7 , 10 , 19)
			,( 6 , 10 , 193)
-- --------------------------------------------------------------------------------
-- Step #3.1: Create SQL to update the address for a specific customer. 
--            Include a select statement before and after the update.
-- --------------------------------------------------------------------------------
SELECT * FROM TCustomers
UPDATE
	TCustomers
SET
	strAddress = '6668 French Rd'
WHERE
	intCustomerID = 6
SELECT * FROM TCustomers
-- --------------------------------------------------------------------------------
-- Step #3.2. Create SQL to increase the hourly rate by $2 for each worker that has 
--            been an employee for at least 1 year. Include a select before and after 
--            the update. Make sure that you have data so that some rows are updated 
--            and others are not.
-- --------------------------------------------------------------------------------
SELECT * FROM TWorkers
UPDATE
	TWorkers
SET
	monHourlyRate = monHourlyRate + 2
WHERE
	dteHireDate < DATEADD(year, -1, GetDate())
SELECT * FROM TWorkers
-- --------------------------------------------------------------------------------
-- Step #3.3. Create SQL to delete a specific job that has associated work hours and 
--            materials assigned to it. Include a select before and after the statement(s).
-- --------------------------------------------------------------------------------
SELECT * FROM TJobs
DELETE FROM TJobs
WHERE
	intJobID = 4
SELECT * FROM TJobs
-- --------------------------------------------------------------------------------
-- Step #4.1. Write a query to list all jobs that are in process. Include the Job ID 
--            and Description, Customer ID and name, and the start date. Order by the Job ID.
-- --------------------------------------------------------------------------------
SELECT
	TC.intCustomerID
	,TC.strFirstName + ' ' + TC.strLastName AS strFullName
	,TJ.intJobID
	,TJ.strJobDescription
	,TJ.dteStartDate
FROM
	TJobs AS TJ
	,TCustomers AS TC
WHERE
	TJ.intJobID = TC.intJobID
AND TJ.intJobStatusID = 2
ORDER BY
	TJ.intJobID
-- --------------------------------------------------------------------------------
-- Step #4.2. Write a query to list all complete jobs for a specific customer and the 
--            materials used on each job. Include the quantity, unit cost, and total 
--            cost for each material on each job. Order by Job ID and material ID. 
--            Note: Select a customer that has at least 3 complete jobs and at least 1 
--            open job and 1 in process job. At least one of the complete jobs should 
--            have multiple materials. If needed, go back to your inserts and add data.
-- --------------------------------------------------------------------------------
SELECT
	TC.intCustomerID
	,TC.strFirstName + ' ' + TC.strLastName AS strFullName
	,TC.intJobID
	,TJ.strJobDescription
	,TS.strJobStatus
	,TM.intMaterialID
	,TM.strMaterialName
	,TJM.intMaterialQuantity
	,TM.monMatieralCost
	,(TM.monMatieralCost * TJM.intMaterialQuantity) AS strTotalCostPerMaterial
FROM
	TJobs AS TJ
	,TCustomers AS TC
	,TMaterials AS TM
	,TJobMaterials AS TJM
	,TStatus AS TS
WHERE
	TJ.intJobID = TC.intJobID
AND TJ.intJobStatusID = TS.intJobStatusID
AND TJM.intJobID = TC.intJobID
AND TM.intMaterialID = TJM.intMaterialID
AND TC.intCustomerID = 6
AND TJ.intJobStatusID = 3
GROUP BY
	TC.intCustomerID
	,TC.strFirstName
	,TC.strLastName 
	,TC.intJobID
	,TJ.strJobDescription
	,TS.strJobStatus
	,TM.intMaterialID
	,TM.strMaterialName
	,TJM.intMaterialQuantity
	,TM.monMatieralCost
ORDER BY
	TC.intJobID
	,TM.intMaterialID
-- --------------------------------------------------------------------------------
-- Step #4.3. This step should use the same customer as in step 4.2. Write a query to 
--            list the total cost for all materials for each completed job for the customer. 
--            Use the data returned in step 4.2 to validate your results.
-- --------------------------------------------------------------------------------
SELECT
	TC.intCustomerID
	,TC.strFirstName + ' ' + TC.strLastName AS strFullName
	,TC.intJobID
	,TJ.intJobStatusID
	,TJ.strJobDescription
	,SUM(TJM.intMaterialQuantity * TM.monMatieralCost) AS monTotalCost
FROM
	TJobs AS TJ
	,TCustomers AS TC
	,TMaterials AS TM
	,TJobMaterials AS TJM
WHERE
	TJ.intJobID = TC.intJobID
AND TJM.intJobID = TC.intJobID
AND TM.intMaterialID = TJM.intMaterialID
AND TC.intCustomerID = 6
AND TJ.intJobStatusID = 3	
GROUP BY
	TC.intCustomerID
	,TC.strFirstName
	,TC.strLastName
	,TC.intJobID
	,TJ.strJobDescription
	,TJ.intJobStatusID
ORDER BY 
	TC.intJobID
-- --------------------------------------------------------------------------------
-- Step #4.4. Write a query to list all jobs that have work entered for them. Include the 
--            job ID, job description, and job status description. List the total hours worked 
--            for each job with the lowest, highest, and average hourly rate. The average hourly 
--            rate should be weighted based on the number of hours worked at that rate. Make sure 
--            that your data includes at least one job that does not have hours logged. This job 
--            should not be included in the query. Order by highest to lowest average hourly rate.
-- --------------------------------------------------------------------------------
SELECT
	TJ.intJobID
	,TJ.strJobDescription
	,TS.strJobStatus
	,SUM(TJW.intTotalHoursWorkedByWorker) AS intTotalHoursWorked
	,MIN(TW.monHourlyRate) AS monMaxHourlyRate
	,MAX(TW.monHourlyRate) AS monMinHourlyRate
	,AVG(TW.monHourlyRate ) AS monAverageHourlyRate
FROM
	TJobs AS TJ
	,TJobWorkers AS TJW
	,TWorkers AS TW
	,TStatus AS TS
WHERE
	TJ.intJobID = TJW.intJobID
AND TW.intWorkerID = TJW.intWorkerID
AND TS.intJobStatusID = TJ.intJobStatusID
GROUP BY
	TJ.intJobID
	,TJ.strJobDescription
	,TS.strJobStatus
HAVING
	SUM(TJW.intTotalHoursWorkedByWorker) > 0 
ORDER BY 
	monAverageHourlyRate DESC
-- --------------------------------------------------------------------------------
-- Step #4.5. Write a query that lists all materials that have not been used on any jobs. 
--            Include Material ID and Description. Order by Material ID.
-- --------------------------------------------------------------------------------
SELECT
	TM.intMaterialID
	,TM.strMaterialName
FROM
	TMaterials AS TM
WHERE
	NOT EXISTS
		(SELECT 
				TJM.intMaterialID 
		 FROM 
				TJobMaterials AS TJM 
		 WHERE 
				TM.intMaterialID = TJM.intMaterialID
		)
ORDER BY
	TM.intMaterialID	
-- --------------------------------------------------------------------------------
-- Step #4.6. Create a query that lists all workers with a specific skill, their hire 
--            date, and the total number of jobs that they worked on. List the Skill ID 
--            and description with each row. Order by Worker ID.
-- --------------------------------------------------------------------------------
SELECT
	TW.intWorkerID
	,TW.strFirstName + ' ' + TW.strLastName AS strFullName
	,TW.dteHireDate
	,COUNT(TJW.intWorkerID) AS intNumberOfJobsWorked
	,TS.intSkillID
	,TS.strSkillDescription
FROM
	TWorkers AS TW
	,TWorkerSkills AS TWS
	,TJobWorkers AS TJW
	,TSkills AS TS
WHERE
	TW.intWorkerID = TWS.intWorkerID
AND TWS.intSkillID = TS.intSkillID
AND TJW.intWorkerID = TW.intWorkerID
AND TS.intSkillID = 1
GROUP BY
	TW.intWorkerID
	,TW.strFirstName
	,TW.strLastName
	,TW.dteHireDate
	,TJW.intWorkerID
	,TS.intSkillID
	,TS.strSkillDescription	
ORDER BY
	TW.intWorkerID
-- --------------------------------------------------------------------------------
-- Step #4.7. Create a query that lists all workers that worked greater than 20 hours for 
--            all jobs that they worked on. Include the Worker ID and name, number of hours worked, 
--            and number of jobs that they worked on. Order by Worker ID.
-- --------------------------------------------------------------------------------
SELECT
	TJW.intWorkerID
	,TW.strFirstName + ' ' + TW.strLastName AS strFullName
	,SUM(TJW.intTotalHoursWorkedByWorker) AS intTotalHoursWork
	,COUNT(TJW.intWorkerID) AS intNumberOfJobs
FROM
	TWorkers AS TW
	,TJobWorkers AS TJW
WHERE
	TW.intWorkerID = TJW.intWorkerID
AND	TJW.intTotalHoursWorkedByWorker > 20
GROUP BY
	TJW.intWorkerID
	,TW.strFirstName
	,TW.strLastName
ORDER BY
	TJW.intWorkerID
-- --------------------------------------------------------------------------------
-- Step #4.8. Create a view that includes the labor costs associated with each job. 
--            Include Customer ID and Name.
-- --------------------------------------------------------------------------------
GO
CREATE VIEW VLaborCosts
AS
SELECT
	TC.intCustomerID
	,TC.strFirstName
	,TC.strLastName
	,TW.monHourlyRate
	,TJ.intJobID
FROM
	TCustomers AS TC
	,TWorkers AS TW
	,TJobs AS TJ

GO
-- --------------------------------------------------------------------------------
-- Step #4.9. Use the View from 4.8 to create a query that includes the total labor cost for 
--            each customer. Order by Customer ID.
-- --------------------------------------------------------------------------------
SELECT
	TC.intCustomerID
	,TC.strFirstName + ' ' + TC.strLastName AS strFullName
	,TJ.intJobID
	,TJ.strJobDescription
	,SUM (TJW.intTotalHoursWorkedByWorker * TW.monHourlyRate)  AS intTotalLaborCost
FROM	
	TCustomers AS TC
	,TJobs AS TJ
	,TJobWorkers AS TJW
	,TWorkers AS TW
WHERE
	TC.intJobID = TJ.intJobID
AND TJW.intWorkerID = TW.intWorkerID
AND TJW.intJobID = TC.intJobID
GROUP BY
	TC.intCustomerID
	,TC.strFirstName
	,TC.strLastName
	,TJ.intJobID
	,TJ.strJobDescription
ORDER BY
	TC.intCustomerID
-- --------------------------------------------------------------------------------
-- Step #4.10. Write a query that lists all customers who are located on 'Main Street'. 
--             Include the customer Id and full address. Order by Customer ID. Make sure 
--             that you have at least three customers on 'Main Street' each with different 
--             house numbers. Make sure that you also have customers that are not on 'Main Street'.
-- --------------------------------------------------------------------------------
SELECT
	TC.intCustomerID
	,TC.strFirstName + ' ' + TC.strLastName AS strFullName
	,TC.strAddress + ', ' + TC.strCity + ', ' + TC.strState + '; ' + TC.strZipCode AS strFullAddress
FROM	
	TCustomers AS TC
WHERE
	TC.strAddress LIKE '%Main%' 
AND	TC.strAddress LIKE '%Street%'
ORDER BY
	TC.intCustomerID
-- --------------------------------------------------------------------------------
-- Step #5.1. Write a query to list completed jobs that started and ended in the same month. List Job, Job
--            Status, Start Date and End Date.
-- --------------------------------------------------------------------------------
SELECT
	TJ.intJobID
	,TJ.strJobDescription
	,TS.strJobStatus
	,TJ.dteStartDate
	,TJ.dteEndDate
FROM	
	TJobs AS TJ
	,TStatus AS TS
WHERE
	TJ.intJobStatusID = TS.intJobStatusID
AND TJ.intJobStatusID = 3
AND MONTH(TJ.dteStartDate) = MONTH(TJ.dteEndDate) 
AND YEAR(TJ.dteStartDate) = YEAR(TJ.dteEndDate)
-- --------------------------------------------------------------------------------
-- Step #5.2. Create a query to list workers that worked on three or more jobs for the same customer.
-- --------------------------------------------------------------------------------
SELECT
	TJW.intWorkerID
	,TW.strFirstName + ' ' + TW.strLastName AS strFullName
FROM
	TWorkers AS TW
	,TJobWorkers AS TJW
	,TCustomers AS TC
	,TJobs AS TJ
WHERE
	TW.intWorkerID = TJW.intWorkerID
AND TJW.intJobID = TJ.intJobID
AND TJ.intJobID = TC.intJobID
GROUP BY 
	TJW.intWorkerID
	,TC.intCustomerID
	,TW.strFirstName
	,TW.strLastName
	,TW.intWorkerID
HAVING
	COUNT(TJW.intWorkerID) >= 3
AND TC.intCustomerID = TC.intCustomerID
ORDER BY
	TW.intWorkerID
-- --------------------------------------------------------------------------------
-- Step #5.3. Create a query to list all workers and their total # of skills. Make sure that you have workers
--            that have multiple skills and that you have at least 1 worker with no skills. The worker with no
--            skills should be included with a total number of skills = 0. Order by Worker ID.
-- --------------------------------------------------------------------------------
SELECT
	TW.intWorkerID
	,TW.strFirstName + ' ' + TW.strLastName AS strFullName
	,CASE WHEN COUNT(*) = NULL THEN 0 ELSE COUNT(TWS.intWorkerID) END AS intNumberOfSkills
FROM
	TWorkers AS TW
	,TWorkerSkills AS TWS
WHERE
	TW.intWorkerID = TWS.intWorkerID
GROUP BY
	TW.intWorkerID
	,TW.strFirstName
	,TW.strLastName 
	,TWS.intWorkerID
ORDER BY
	TW.intWorkerID
-- --------------------------------------------------------------------------------
-- Step #5.4. Write a query to list the total Charge to the customer for each job. Calculate the total charge to
--            the customer as the total cost of materials + total Labor costs + 30% Profit.
-- --------------------------------------------------------------------------------
SELECT
	TC.intCustomerID
	,TC.strFirstName + ' ' + TC.strLastName AS strFullName
	,TJ.intJobID
	,TJ.strJobDescription
	,(SUM(TJM.intMaterialQuantity * TM.monMatieralCost) + SUM(TJW.intTotalHoursWorkedByWorker * TW.monHourlyRate))*1.3 AS intTotalMoneySpent
FROM	
	TCustomers AS TC
	,TJobs AS TJ
	,TJobMaterials AS TJM
	,TJobWorkers AS TJW
	,TWorkers AS TW
	,TMaterials AS TM
WHERE
	TC.intJobID = TJ.intJobID
AND TJ.intJobID = TJM.intJobID
AND TJW.intWorkerID = TW.intWorkerID
AND TM.intMaterialID = TJM.intMaterialID
AND TJW.intJobID = TC.intJobID
GROUP BY
	TC.intCustomerID
	,TC.strFirstName
	,TC.strLastName
	,TJ.intJobID
	,TJ.strJobDescription
ORDER BY
	TC.intCustomerID