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

DROP TABLE TUserFavoriteSong
DROP TABLE TUsers

-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------
CREATE TABLE TUsers
(
	intUserID					INTEGER			NOT NULL
	,strUserName				VARCHAR(50)		NOT NULL
	,strEmailAddress			VARCHAR(50)		NOT NULL
	,CONSTRAINT TUsers_PK PRIMARY KEY( intUserID )
)

CREATE TABLE TUserFavoriteSong
(
	intUserID					INTEGER			NOT NULL
	,intFavoriteSongIndex		INTEGER			NOT NULL
	,strFavoriteSongName		VARCHAR(50)		NOT NULL
	,strFavoriteSongArtist		VARCHAR(50)		NOT NULL
	,CONSTRAINT TUsersFavoriteSongs_PK PRIMARY KEY( intUserID, intFavoriteSongIndex )
)

-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Key
-- --------------------------------------------------------------------------------
--
--#		Child					Parent					Column
--		-----					------					------
--		TUserFavoriteSongs		TUsers					intUserID

ALTER TABLE TUserFavoriteSong ADD CONSTRAINT TUserFavoriteSongs_TUsers_FK
FOREIGN KEY ( intUserID ) REFERENCES TUsers ( intUserID )

-- --------------------------------------------------------------------------------
-- Step #1.3: Add at least three users
-- --------------------------------------------------------------------------------

INSERT INTO TUsers (intUserID, strUserName, strEmailAddress)
VALUES		( 1, 'Bill Ding', 'BillDing@downtown.com')
			, ( 2, 'Luke Skywalker', 'LSkywalker@Jedi.org')
			, ( 3, 'James T. Kirk', 'JTKirk@StarFleet.gov')

-- --------------------------------------------------------------------------------
-- Step #1.4: Add 2 songs per user
-- --------------------------------------------------------------------------------

INSERT INTO TUserFavoriteSong(intUserID, intFavoriteSongIndex, strFavoriteSongName, strFavoriteSongArtist)
VALUES		(1, 1, 'Song A', 'Artist 1')
			, (1, 2, 'Song B', 'Artist 2')
			, (1, 3, 'Song C', 'Artist 3')
			, (2, 1, 'Song D', 'Artist 4')
			, (2, 2, 'Song E', 'Artist 5')
			, (2, 3, 'Song F', 'Artist 6')
			, (3, 1, 'Song G', 'Artist 7')
			, (3, 2, 'Song H', 'Artist 8')
			, (3, 3, 'Song I', 'Artist 9')
