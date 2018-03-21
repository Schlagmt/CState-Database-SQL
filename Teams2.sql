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
DROP TABLE TPlayers
DROP TABLE TTeams

-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TTeams
(
	intTeamID			INTEGER		NOT NULL
	,strTeam			VARCHAR(50)	NOT NULL
	,strMascot			VARCHAR(50)	NOT NULL
	,CONSTRAINT	TTeams_PK PRIMARY KEY( intTeamID )
)
CREATE TABLE TPlayers
(
	intPlayerID			INTEGER		NOT NULL
	,strFirstName		VARCHAR(50)	NOT NULL
	,strLastName		VARCHAR(50)	NOT NULL
	,CONSTRAINT	TPlayers_PK PRIMARY KEY( intPlayerID )
)
CREATE TABLE TTeamPlayers
(
	intPlayerID			INTEGER		NOT NULL
	,intTeamID			INTEGER		NOT NULL
	,CONSTRAINT	TTeamPlayers_PK PRIMARY KEY( intPlayerID,intTeamID )
)
-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Key 
-- --------------------------------------------------------------------------------
ALTER TABLE TTeamPlayers ADD CONSTRAINT TTeamPlayers_TTeams_FK
FOREIGN KEY ( intTeamID ) REFERENCES TTeams ( intTeamID )
ALTER TABLE TTeamPlayers ADD CONSTRAINT TTeamPlayers_TPlayers_FK
FOREIGN KEY ( intPlayerID ) REFERENCES TPlayers ( intPlayerID )
-- --------------------------------------------------------------------------------
-- Step #1.3: Simple Data
-- --------------------------------------------------------------------------------
INSERT INTO TTeams (intTeamID,strTeam,strMascot)
VALUES		(1,'Cross Country','Runner')
			,(2,'Football','Ball')
			,(3,'Basketball','Basket')
INSERT INTO TPlayers (intPlayerID,strFirstName,strLastName)
VALUES		(1,'Mark','Top')
			,(2,'John','Bottom')
			,(3,'Bill','Breazy')
			,(4,'Matt','Easy')
			,(5,'Tim','Soft')
			,(6,'Jim','Hard')
			,(7,'Tim','OHard')
			,(8,'Howard','OHard')
INSERT INTO TTeamPlayers (intTeamID,intPlayerID)
VALUES		( 1 , 6 )
			,( 1 , 5 )
			,( 1 , 4 )
			,( 3 , 3 )
			,( 3 , 2 )
			,( 3 , 1 )
			,( 2 , 1 )
			,( 2 , 5 )
			,( 3 , 6 )
-- --------------------------------------------------------------------------------
-- Step #1.4: Write the query that will show the ID and name for every team along with a count of how many players are on each team
-- --------------------------------------------------------------------------------
SELECT
	TTP.intTeamID AS 'Team ID'
	,TT.strTeam AS 'Team Name'
	,COUNT( intPlayerID ) AS 'Number Of Players Per Team'
FROM
	TTeams AS TT
	,TTeamPlayers AS TTP
WHERE
	TT.intTeamID = TTP.intTeamID
GROUP BY 
	TTP.intTeamID 
	,TT.strTeam 
ORDER BY 
	TT.strTeam
-- --------------------------------------------------------------------------------
-- Step #1.5: Write the query that will show all the players ON a specific team.  You pick the team.  Order by last name and first name.
-- --------------------------------------------------------------------------------
SELECT
	TP.intPlayerID AS 'Player ID'
	,TT.strTeam AS 'Sport'
	,TP.strFirstName + ' ' + TP.strLastName AS 'Player Name'
FROM
	TPlayers AS TP
	,TTeams AS TT
	,TTeamPlayers AS TTP
WHERE
	TT.intTeamID = TTP.intTeamID
AND	TTP.intPlayerID = TP.intPlayerID
AND	TT.intTeamID = 3
ORDER BY
	TP.strLastName
	,TP.strFirstName
-- --------------------------------------------------------------------------------
-- Step #1.6: Write the query that will show all the players NOT ON a specific team
-- --------------------------------------------------------------------------------
SELECT
	TP.intPlayerID AS 'Player ID'
	,TP.strFirstName + ' ' + TP.strLastName AS 'Player Name'
FROM
	TPlayers AS TP
WHERE
	TP.intPlayerID NOT IN
	( 
		SELECT
			TTP.intPlayerID
		FROM
			TTeamPlayers AS TTP
		WHERE
			TTP.intTeamID = 1
	)
ORDER BY
	TP.strLastName
	,TP.strFirstName