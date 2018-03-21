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
DROP TABLE TUserFavoriteSongs
DROP TABLE TSongs
DROP TABLE TUsers
-- --------------------------------------------------------------------------------
-- Step #2.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TUsers
(
	intUserID			INTEGER		NOT NULL
	,strFirstName		VARCHAR(50)	NOT NULL
	,strLastName		VARCHAR(50)	NOT NULL
	,CONSTRAINT	TUsers_PK PRIMARY KEY( intUserID )
)
CREATE TABLE TSongs
(
	intSongID			INTEGER		NOT NULL
	,strSong			VARCHAR(50)	NOT NULL
	,strArtist			VARCHAR(50)	NOT NULL
	,CONSTRAINT	TSongs_PK PRIMARY KEY( intSongID )
)
CREATE TABLE TUserFavoriteSongs
(
	intUserID			INTEGER		NOT NULL
	,intSongID			INTEGER		NOT NULL
	,intSortOrder		INTEGER		NOT NULL
	,CONSTRAINT	TUserFavoriteSongs_PK PRIMARY KEY( intUserID,intSongID )
)
-- --------------------------------------------------------------------------------
-- Step #2.2: Identify and Create Foreign Key 
-- --------------------------------------------------------------------------------
ALTER TABLE TUserFavoriteSongs ADD CONSTRAINT TUserFavoriteSongs_TUsers_FK
FOREIGN KEY ( intUserID ) REFERENCES TUsers ( intUserID )
ALTER TABLE TUserFavoriteSongs ADD CONSTRAINT TUserFavoriteSongs_TSongs_FK
FOREIGN KEY ( intSongID ) REFERENCES TSongs ( intSongID )
-- --------------------------------------------------------------------------------
-- Step #2.3: Simple Data
-- --------------------------------------------------------------------------------
INSERT INTO TUsers (intUserID,strFirstName,strLastName)
VALUES		(1,'Matt','King')
			,(2,'Mark','Kong')
			,(3,'Manny','Kang')
			,(4,'Molly','Kung')
			,(5,'Holly','Tung')
INSERT INTO TSongs (intSongID,strSong,strArtist)
VALUES		(1,'Love','Lil Wayne')
			,(2,'Hate','Taylor Swift')
			,(3,'Cold','JayZ')
			,(4,'Warm','Eminem')
			,(5,'Dry','Eminem')
			,(6,'Wet','21 Pilots')
			,(7,'Fast','Eminem')
			,(8,'Slow','Michael Jackson')
			,(9,'Big','2Pac')
INSERT INTO TUserFavoriteSongs (intUserID,intSongID,intSortOrder)
VALUES		( 1 , 1 , 1 )
			,( 2 , 2 , 2 )
			,( 3 , 3 , 3 )
			,( 4 , 4 , 4 )
			,( 1 , 5 , 5 )
			,( 2 , 6 , 6 )
			,( 3 , 7 , 7 )
			,( 4 , 8 , 8 )
			,( 1 , 9 , 9 )
			,( 2 , 3 , 2 )
			,( 3 , 4 , 3 )
			,( 4 , 5 , 4 )
			,( 1 , 6 , 5 )
			,( 2 , 7 , 6 )
			,( 3 , 9 , 7 )
			,( 4 , 7 , 8 )
			,( 1 , 2 , 9 )
-- --------------------------------------------------------------------------------
-- Step #2.4: Write the query that will show the ID and name for every user along with a count of how many favorite songs each user has.
-- --------------------------------------------------------------------------------
SELECT
	TUFS.intUserID AS 'User ID'
	,TU.strFirstName + ' ' + TU.strLastName AS 'User Name'
	,COUNT( TUFS.intUserID ) AS 'Number Of Favorite Songs Per Person'
FROM
	TUsers AS TU
	,TUserFavoriteSongs AS TUFS
WHERE
	TU.intUserID = TUFS.intUserID
GROUP BY 
	TUFS.intUserID 
	,TU.strFirstName
	,TU.strLastName
ORDER BY
	TU.strLastName
	,TU.strFirstName 
-- --------------------------------------------------------------------------------
-- Step #2.5: Write the query that will show all the users that have at least 3 favorite songs by <your favorite band>
-- --------------------------------------------------------------------------------
SELECT
	TU.intUserID AS 'User ID'
	,TU.strFirstName + ' ' + TU.strLastName AS 'User Name'
	,COUNT( * ) AS 'Favorite Band Song Count'
FROM
	TUsers AS TU
	,TUserFavoriteSongs AS TUFS
	,TSongs AS TS
WHERE
	TU.intUserID = TUFS.intUserID
AND TUFS.intSongID = TS.intSongID 
AND	TS.strArtist = 'Eminem'
GROUP BY
	TU.intUserID
	,TU.strFirstName
	,TU.strLastName
HAVING 
	COUNT( * ) >= 3
ORDER BY
	TU.strLastName
	,TU.strFirstName