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
DROP TABLE TTeamPlayers
DROP TABLE TPlayer
DROP TABLE TTeams
-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TTeams
(
	intTeamID		INTEGER		NOT NULL
	,strTeam		VARCHAR(50)	NOT NULL
	,strMascot		VARCHAR(50)	NOT NULL
	,CONSTRAINT TTeams_PK PRIMARY KEY ( intTeamID )
)
CREATE TABLE TTeamPlayers
(
	intTeamID		INTEGER		NOT NULL
	,intPlayerID	INTEGER		NOT NULL
	,CONSTRAINT TTeamPlayers_PK PRIMARY KEY ( intTeamID , intPlayerID )
)
CREATE TABLE TPlayer
(
	intPlayerID		INTEGER		NOT NULL
	,strFirstName	VARCHAR(50)	NOT NULL
	,strLastName	VARCHAR(50)	NOT NULL
	,CONSTRAINT TPlayer_PK PRIMARY KEY ( intPlayerID )
)
-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
--#		Child					Parent					Column
--		-----					------					------
--		TTeamPlayers			TTeams					intTeamID
--		TTeamPlayers			TPlayer					intPlayerID

ALTER TABLE TTeamPlayers ADD CONSTRAINT TTeamPlayers_TTeams_FK
FOREIGN KEY ( intTeamID ) REFERENCES TTeams ( intTeamID )

ALTER TABLE TTeamPlayers ADD CONSTRAINT TTeamPlayers_TPlayer_FK
FOREIGN KEY ( intPlayerID ) REFERENCES TPlayer ( intPlayerID )
-- --------------------------------------------------------------------------------
-- Step #1.3: Write the SQL that will add 3 teams to the TTeams table
-- --------------------------------------------------------------------------------
INSERT INTO TTeams (intTeamID,strTeam,strMascot)
VALUES		(1,'Cross Country','Runner')
			,(2,'Swimming','Swimmer')
			,(3,'Ultimate','Disc')
SELECT * FROM TTeams

-- --------------------------------------------------------------------------------
-- Step #1.3: Write the SQL that will add 3 players to the TPlayers table.
-- --------------------------------------------------------------------------------
INSERT INTO TPlayer(intPlayerID,strFirstName,strLastName)
VALUES		(1,'Matt','Schlager')
			,(2,'John','Oliver')
			,(3,'Mary','Betty')
SELECT * FROM TPlayer

-- --------------------------------------------------------------------------------
-- Step #1.3: Write the SQL that will make at least 6 team-player assignments in the TTeamPlayers table.
-- --------------------------------------------------------------------------------
INSERT INTO TTeamPlayers(intTeamID,intPlayerID)
VALUES		(1,1)
			,(2,1)
			,(2,2)
			,(3,2)
			,(1,3)
			,(3,3)
SELECT * FROM TTeamPlayers








