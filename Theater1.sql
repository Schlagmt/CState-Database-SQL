-- --------------------------------------------------------------------------------
-- Name: Matthew Schlager
-- --------------------------------------------------------------------------------
-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL4; -- Get out of the master database
SET NOCOUNT ON; -- Report only errors
-- --------------------------------------------------------------------------------
-- Drop Table
-- --------------------------------------------------------------------------------
DROP TABLE TTheathersWriter
DROP TABLE TTheatersActors
DROP TABLE TTheatersPlay
DROP TABLE TTheaters
-- --------------------------------------------------------------------------------
-- Create Table
-- --------------------------------------------------------------------------------
CREATE TABLE TTheaters
(
	intTheaterID					INTEGER			NOT NULL
	,strTheaterName					VARCHAR(50)		NOT NULL
	,strTheaterAddress				VARCHAR(50)		NOT NULL
	,CONSTRAINT TTheaters_PK PRIMARY KEY( intTheaterID )
)
CREATE TABLE TTheatersPlay
(
	intTheaterID					INTEGER			NOT NULL
	,intPlayID						INTEGER			NOT NULL
	,strPlayName					VARCHAR(50)		NOT NULL
	,dtePlayDate					DATE			NOT NULL
	,tmePlayTime					TIME			NOT NULL
	,CONSTRAINT TTheatersPlay_PK PRIMARY KEY( intTheaterID, intPlayID )
)
CREATE TABLE TTheatersActors
(
	intTheaterID					INTEGER			NOT NULL
	,intActorID						INTEGER			NOT NULL
	,strPlayActorName				VARCHAR(50)		NOT NULL
	,strPlayActorRole				VARCHAR(50)		NOT NULL
	,CONSTRAINT TTheatersActors_PK PRIMARY KEY( intTheaterID, intActorID )
)
CREATE TABLE TTheathersWriter
(
	intTheaterID					INTEGER			NOT NULL
	,intWritersID					INTEGER			NOT NULL
	,strPlayWriterName				VARCHAR(50)		NOT NULL
	,CONSTRAINT TTheathersWriter_PK PRIMARY KEY( intTheaterID, intWritersID )
)
-- --------------------------------------------------------------------------------
-- Step #2: Create foreign keys for your tables.
-- --------------------------------------------------------------------------------
--
--#		Child					Parent					Column
--		-----					------					------
--		TTheathersWriter		TTheaters				intTheaterID
--		TTheatersActors			TTheaters				intTheaterID
--		TTheatersPlay			TTheaters				intTheaterID

ALTER TABLE TTheathersWriter ADD CONSTRAINT TTheathersWriter_TTheaters_FK
FOREIGN KEY ( intTheaterID ) REFERENCES TTheaters ( intTheaterID )

ALTER TABLE TTheatersActors ADD CONSTRAINT TTheatersActors_TTheaters_FK
FOREIGN KEY ( intTheaterID ) REFERENCES TTheaters ( intTheaterID )

ALTER TABLE TTheatersPlay ADD CONSTRAINT TTheatersPlay_TTheaters_FK
FOREIGN KEY ( intTheaterID ) REFERENCES TTheaters ( intTheaterID )

-- --------------------------------------------------------------------------------
-- Step #3: Write 2 inserts for each table
-- --------------------------------------------------------------------------------

INSERT INTO TTheaters (intTheaterID, strTheaterName, strTheaterAddress)
VALUES		(1, 'Theater 1', '1 Street')
			, (2, 'Theater 2', '2 Street')
SELECT * FROM TTheaters

INSERT INTO TTheatersPlay (intTheaterID, intPlayID, strPlayName, dtePlayDate, tmePlayTime)
VALUES		(1, 1, 'Play Name 1', '1/1/2000', '23:59:59.9999999'  )
			, (2, 2, 'Play Name 2', '1/2/2000',  '23:59:59.9999999' )
SELECT * FROM TTheatersPlay

INSERT INTO TTheatersActors (intTheaterID, intActorID, strPlayActorName, strPlayActorRole)
VALUES		(1,1, 'John Doe', 'Peter')
			, (2,2, 'Mary Doe', 'Jane')
SELECT * FROM TTheatersActors

INSERT INTO TTheathersWriter (intTheaterID, intWritersID, strPlayWriterName)
VALUES		(1,1, 'Mark Smith')
			, (2,2, 'Jane Smith')
SELECT * FROM TTheathersWriter