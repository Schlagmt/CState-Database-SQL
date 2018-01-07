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

DROP TABLE TInsurancePolicyClaimPayments
DROP TABLE TPaymentRecipients
DROP TABLE TInsurancePolicyClaims
DROP TABLE TInsurancePolicies
DROP TABLE TClientPolicyTypes
DROP TABLE TPaymentStatues
DROP TABLE TSellingAgents
DROP TABLE TClients
-- --------------------------------------------------------------------------------
-- Step #3.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TInsurancePolicies
(
	intInsurancePolicyID				INTEGER			NOT NULL
	,strInsurancePolicyNumber			VARCHAR(50)		NOT NULL
	,intInsurancePolicyTypeID			INTEGER			NOT NULL
	,dtmStartDate						DATETIME		NOT NULL
	,monAnnualPayment					MONEY			NOT NULL	--(e.g. $800/year)
	,intPaymentStatusID					INTEGER			NOT NULL	--(e.g. Due, Late, Paid)
	,intSellingAgentID					INTEGER			NOT NULL
	,intClientID						INTEGER			NOT NULL	
	,CONSTRAINT TInsurancePolicies_PK PRIMARY KEY ( intInsurancePolicyID )
)
CREATE TABLE TClientPolicyTypes
(
	intInsurancePolicyTypeID			INTEGER			NOT NULL
	,strInsurancePolicyType				VARCHAR(50)		NOT NULL
	,CONSTRAINT TClientPolicyTypes_PK PRIMARY KEY ( intInsurancePolicyTypeID )
)
CREATE TABLE TPaymentStatues
(
	intPaymentStatusID					INTEGER			NOT NULL
	,strPaymentStatus					VARCHAR(50)		NOT NULL
	,CONSTRAINT TPaymentStatues_PK PRIMARY KEY ( intPaymentStatusID )
)
CREATE TABLE TSellingAgents
(
	intSellingAgentID					INTEGER			NOT NULL
	,strFirstName						VARCHAR(50)		NOT NULL
	,strLastName						VARCHAR(50)		NOT NULL
	,strPhone							VARCHAR(50)		NOT NULL
	,strAddress							VARCHAR(50)		NOT NULL
	,CONSTRAINT TSellingAgents_PK PRIMARY KEY ( intSellingAgentID )
)
CREATE TABLE TClients
(
	intClientID							INTEGER			NOT NULL
	,strFirstName						VARCHAR(50)		NOT NULL
	,strLastName						VARCHAR(50)		NOT NULL
	,strPhone							VARCHAR(50)		NOT NULL
	,strAddress							VARCHAR(50)		NOT NULL
	,CONSTRAINT TClients_PK PRIMARY KEY ( intClientID )
)
CREATE TABLE TInsurancePolicyClaims
(
	intInsurancePolicyID				INTEGER			NOT NULL
	,intClaimIndex						INTEGER			NOT NULL
	,dtmClaimDate						DATETIME		NOT NULL
	,strClaimDescription				VARCHAR(50)		NOT NULL
	,CONSTRAINT TClaims_PK PRIMARY KEY ( intInsurancePolicyID,intClaimIndex )
)
CREATE TABLE TInsurancePolicyClaimPayments
(
	intInsurancePolicyID				INTEGER			NOT NULL
	,intClaimIndex						INTEGER			NOT NULL
	,intPaymentIndex					INTEGER			NOT NULL
	,strPaymentDate						VARCHAR(50)		NOT NULL
	,intPaymentRecipientID				INTEGER			NOT NULL
	,monPaymentAmount					MONEY			NOT NULL
	,CONSTRAINT TClaimPayments_PK PRIMARY KEY ( intInsurancePolicyID,intClaimIndex,intPaymentIndex )
)

CREATE TABLE TPaymentRecipients
(
	intPaymentRecipientID				INTEGER			NOT NULL
	,strFirstName						VARCHAR(50)		NOT NULL
	,strLastName						VARCHAR(50)		NOT NULL
	,strPhone							VARCHAR(50)		NOT NULL	
	,strAddress							VARCHAR(50)		NOT NULL
	,CONSTRAINT TClientClaimPayment_PK PRIMARY KEY ( intPaymentRecipientID )
)
-- --------------------------------------------------------------------------------
-- Step #2.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
--#		Child							Parent					Column
--		-----							------					------
--		TInsurancePolicies				TClientPolicyTypes		intInsurancePolicyTypeID
--		TInsurancePolicies				TPaymentStatues			intPaymentStatusID
--		TInsurancePolicies				TSellingAgents			intSellingAgentID
--		TInsurancePolicies				TClients				intClientID
--		TInsurancePolicyClaims			TInsurancePolicies		intInsurancePolicyID
--		TInsurancePolicyClaimPayments	TInsurancePolicy		intInsurancePolicyID,intClaimIndex
--		TInsurancePolicyClaimPayments	TPaymentRecipients		intPaymentRecipientID

ALTER TABLE TInsurancePolicies ADD CONSTRAINT TInsurancePolicies_TClientPolicyTypes_FK
FOREIGN KEY ( intInsurancePolicyTypeID ) REFERENCES TClientPolicyTypes ( intInsurancePolicyTypeID )
ALTER TABLE TInsurancePolicies ADD CONSTRAINT TInsurancePolicies_TPaymentStatues_FK
FOREIGN KEY ( intPaymentStatusID ) REFERENCES TPaymentStatues ( intPaymentStatusID )
ALTER TABLE TInsurancePolicies ADD CONSTRAINT TInsurancePolicies_TSellingAgents_FK
FOREIGN KEY ( intSellingAgentID ) REFERENCES TSellingAgents ( intSellingAgentID )
ALTER TABLE TInsurancePolicies ADD CONSTRAINT TInsurancePolicies_TClients_FK
FOREIGN KEY ( intClientID ) REFERENCES TClients ( intClientID )
ALTER TABLE TInsurancePolicyClaims ADD CONSTRAINT TInsurancePolicyClaims_TInsurancePolicies_FK
FOREIGN KEY ( intInsurancePolicyID ) REFERENCES TInsurancePolicies ( intInsurancePolicyID )
ALTER TABLE TInsurancePolicyClaimPayments ADD CONSTRAINT TInsurancePolicyClaimPayments_TInsurancePolicies_FK
FOREIGN KEY ( intInsurancePolicyID ) REFERENCES TInsurancePolicies ( intInsurancePolicyID )
ALTER TABLE TInsurancePolicyClaimPayments ADD CONSTRAINT TInsurancePolicyClaimPayments_TPaymentRecipients_FK
FOREIGN KEY ( intpaymentRecipientID ) REFERENCES TPaymentRecipients ( intPaymentRecipientID )
-- --------------------------------------------------------------------------------
-- Step #3.3: Write the SQL that will add 2 insurance policies.
-- --------------------------------------------------------------------------------
INSERT INTO TClients (intClientID,strFirstName,strLastName,strPhone,strAddress)
VALUES		(1,'Russel','Westbrook','(666)777-8888','6789 Storybrook Lane')
INSERT INTO TSellingAgents(intSellingAgentID,strFirstName,strLastName,strPhone,strAddress)
VALUES		(1,'Mark','Agwier','(678)345-6789','2345 That one street')
			,(2,'Anthony','Rizzo','(678)346-6789','2398 That one street')
INSERT INTO TPaymentStatues(intPaymentStatusID,strPaymentStatus)
VALUES		(1,'Good')
			,(2,'Bad')
INSERT INTO TClientPolicyTypes (intInsurancePolicyTypeID,strInsurancePolicyType)
VALUES		(1,'Home')
			,(2,'Auto')
INSERT INTO TInsurancePolicies (intInsurancePolicyID,strInsurancePolicyNumber,intInsurancePolicyTypeID,dtmStartDate,monAnnualPayment,intPaymentStatusID,intSellingAgentID,intClientID)
VALUES		(1,'123',1,'01/01/2016',99.99,1,1,1)
			,(2,'456',2,'01/01/2015',49.99,2,2,1)
-- --------------------------------------------------------------------------------
-- Step #3.4: Write the SQL that will add at least 2 claims for each insurance policy.
-- --------------------------------------------------------------------------------
INSERT INTO TInsurancePolicyClaims(intInsurancePolicyID,intClaimIndex,dtmClaimDate,strClaimDescription)
VALUES		(2,1,'09/28/2016','Car Accidnet')
			,(1,2,'09/28/2015','Home Fire')
			,(2,3,'09/28/2014','Hit and Run')
			,(1,4,'09/28/2013','Tornato')
-- --------------------------------------------------------------------------------
-- Step #3.5: Write the SQL that will add at least 2 payments for each insurance policy claim
-- --------------------------------------------------------------------------------
INSERT INTO TPaymentRecipients (intPaymentRecipientID,strFirstName,strLastName,strPhone,strAddress)
VALUES		(1,'Derrick','Rose','(567)890-4567','5678 Street Street')
			,(2,'Klay','Thompson','(567)820-4567','5672 Street Street')
			,(3,'Draymond','Green','(567)290-4567','5628 Street Street')
			,(4,'Andre','Igudala','(567)893-4567','5673 Street Street')
INSERT INTO TInsurancePolicyClaimPayments(intInsurancePolicyID,intClaimIndex,intPaymentIndex,strPaymentDate,intPaymentRecipientID,monPaymentAmount)
VALUES		(1,1,1,'12/12/2016',1,100100)
			,(2,2,2,'12/12/2017',2,100010)
			,(1,3,3,'12/12/2018',3,10010)
			,(2,4,4,'12/12/2019',4,110000)

