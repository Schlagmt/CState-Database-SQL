---------------------------------------------------------------------------------
-- Name: Matthew Schlager
-- --------------------------------------------------------------------------------

-- --------------------------------------------------------------------------------
-- Options
-- --------------------------------------------------------------------------------
USE dbSQL1;     -- Get out of the master database
SET NOCOUNT ON; -- Report only errors

-- --------------------------------------------------------------------------------
-- Drop Tables
-- --------------------------------------------------------------------------------

DROP TABLE TTicketPrices
DROP TABLE TTicketSales
DROP TABLE TShowings
DROP TABLE TTheaters
DROP TABLE TMovies
DROP TABLE TTicketTypes
DROP TABLE TScreenTypes

-- --------------------------------------------------------------------------------
-- Step #1.1: Create Tables
-- --------------------------------------------------------------------------------

CREATE TABLE TTheaters
(
	 intTheaterID		INTEGER			NOT NULL
	,strTheater			VARCHAR(50)		NOT NULL
	,strTheaterAddress	VARCHAR(50)		NOT NULL
	,strTheaterCity		VARCHAR(50)		NOT NULL
	,strTheaterState	VARCHAR(50)		NOT NULL
	,CONSTRAINT TTheaters_PK PRIMARY KEY ( intTheaterID )
)

CREATE TABLE TScreenTypes
(
	 intScreenTypeID	INTEGER			NOT NULL
	,strScreenType		VARCHAR(50)		NOT NULL
	,CONSTRAINT TScreenTypes_PK PRIMARY KEY ( intScreenTypeID )
)

CREATE TABLE TMovies
(
	 intMovieID			INTEGER			NOT NULL
	,strMovieName		VARCHAR(50)		NOT NULL
	,strDescription		VARCHAR(2000)	NOT NULL
	,intRunningTime		INTEGER			NOT NULL
	,CONSTRAINT TMovies_PK PRIMARY KEY ( intMovieID )
)

CREATE TABLE TShowings
(
	 intShowingID		INTEGER			NOT NULL
	,intTheaterID		INTEGER			NOT NULL
	,intScreenTypeID	INTEGER			NOT NULL
	,intMovieID			INTEGER			NOT NULL
	,dteShowDate		DATE			NOT NULL
	,tmeShowTime		TIME			NOT NULL
	,CONSTRAINT TMovieShowings_PK PRIMARY KEY ( intShowingID )
)

CREATE TABLE TTicketPrices
(
	 intTheaterID		INTEGER			NOT NULL
	,intScreenTypeID	INTEGER			NOT NULL
	,intTicketTypeID	INTEGER			NOT NULL
	,monTicketPrice		MONEY			NOT NULL
	,CONSTRAINT TTicketPrices_PK PRIMARY KEY ( intTheaterID, intScreenTypeID, intTicketTypeID )
)

CREATE TABLE TTicketTypes
(
	 intTicketTypeID	INTEGER			NOT NULL
	,strTicketType		VARCHAR(50)		NOT NULL	--- Adult, Student, Child
	,CONSTRAINT TTicketTypes_PK PRIMARY KEY ( intTicketTypeID )
)
	
CREATE TABLE TTicketSales
(
	 intTicketSaleID	INTEGER			NOT NULL
	,intShowingID		INTEGER			NOT NULL
	,intTicketTypeID	INTEGER			NOT NULL
	,monTicketPrice		MONEY			NOT NULL
	,CONSTRAINT TTicketSales_PK PRIMARY KEY ( intTicketSaleID )
)



-- --------------------------------------------------------------------------------
-- Step #1.2: Identify and Create Foreign Keys
-- --------------------------------------------------------------------------------
--
-- #	Child								Parent						Column(s)
-- -	-----								------						---------
-- 1	TShowings							TTheaters					intTheaterID
-- 2	TShowings							TScreenTypess				intScreenTypeID
-- 3	TShowings							TMovies						intMovieID
-- 4	TTicketPrices						TTheaters					intTheaterID
-- 5	TTicketPrices						TScreenTypes				intScreenTypeID
-- 6	TTicketPrices						TTicketTypes				intTicketTypeID
-- 7	TTicketSales						TShowings					intShowingID
-- 8	TTicketSales						TTicketTypes				intTicketTypeID	

-- 1
ALTER TABLE TShowings ADD CONSTRAINT TShowings_TTheaters_FK
FOREIGN KEY ( intTheaterID ) REFERENCES TTheaters ( intTheaterID )
-- 2
ALTER TABLE TShowings ADD CONSTRAINT TShowings_TScreenTypes_FK
FOREIGN KEY ( intScreenTypeID ) REFERENCES TScreenTypes ( intScreenTypeID )
-- 3
ALTER TABLE TShowings ADD CONSTRAINT TShowings_TMovies_FK
FOREIGN KEY ( intMovieID ) REFERENCES TMovies ( intMovieID )
-- 4
ALTER TABLE TTicketPrices ADD CONSTRAINT TTicketPrices_TTheaters_FK
FOREIGN KEY ( intTheaterID ) REFERENCES TTheaters ( intTheaterID )
-- 5
ALTER TABLE TTicketPrices ADD CONSTRAINT TTicketPrices_TScreenTypes_FK
FOREIGN KEY ( intScreenTypeID ) REFERENCES TScreenTypes ( intScreenTypeID )
-- 6
ALTER TABLE TTicketPrices ADD CONSTRAINT TTicketPrices_TTicketTypes_FK
FOREIGN KEY ( intTicketTypeID ) REFERENCES TTicketTypes ( intTicketTypeID )
-- 7
ALTER TABLE TTicketSales ADD CONSTRAINT TTicketSales_TShowings_FK
FOREIGN KEY ( intShowingID ) REFERENCES TShowings ( intShowingID )
-- 8
ALTER TABLE TTicketSales ADD CONSTRAINT TTicketSale_TTicketTypes_FK
FOREIGN KEY ( intTicketTypeID ) REFERENCES TTicketTypes ( intTicketTypeID )
-- --------------------------------------------------------------------------------
-- Step #1.3: Add data
-- --------------------------------------------------------------------------------
INSERT INTO TTicketTypes ( intTicketTypeID, strTicketType )
VALUES	 ( 1, 'Adult' )
		,( 2, 'Student')
		,( 3, 'Child' )
		,( 4, 'Senior')	-- No sales for this ticket type.
	
INSERT INTO TScreenTypes ( intScreenTypeID, strScreenType )
VALUES	 ( 1, 'Standard' )
		,( 2, 'Imax')
		,( 3, '3D' )
		,( 4, '4D' )	-- No showings for this screen type

INSERT INTO TTheaters ( intTheaterID, strTheater, strTheaterAddress, strTheaterCity, strTheaterState )
VALUES	 ( 1, 'Old Time Theater', '100 Main Street', 'Covington', 'KY' )
		,( 2, 'Super 8 Theater', '8 Your Street ', 'Your Town', 'OH' )
		,( 3, 'Main Street Theater', '203 High Road ', 'New Town', 'OH' )
		,( 4, 'Fun Time Theater', '20 New Avenue ', 'My Town', 'IN' ) -- No showings for this theater

INSERT INTO TMovies ( intMovieID, strMovieName, strDescription, intRunningTime )
VALUES	 ( 1, 'Long Journey Home' , 'Heartfeld movie ... ', 165)
		,( 2, 'Antartica', 'Educational movie ....', 205)
		,( 3, 'Drama on the High Seas', 'Dramatic movie ....', 175)
		,( 4, 'Aliens vs. Zombies', 'Scary movie about.....', 105)
		,( 5, 'All About Penguins', 'Educational movie.....', 135) -- No showings for this movie

INSERT INTO TShowings ( intShowingID, intTheaterID,  intMovieID, intScreenTypeID, dteShowDate, tmeShowTime )
VALUES	 
		 ( 1, 1, 1, 1, '07/1/2015', '12:30')
		,( 2, 1, 1, 1, '07/1/2015', '17:15')
		,( 3, 1, 2, 1, '07/1/2015', '22:00')

		,( 4, 1, 2, 1, '07/1/2015', '11:00')
		,( 5, 1, 2, 1, '07/1/2015', '15:15')
		,( 6, 1, 2, 3, '07/1/2015', '20:50')
		,( 7, 1, 3, 1, '07/1/2015', '11:15')
		,( 8, 1, 3, 1, '07/1/2015', '16:15')
		,( 9, 1, 3, 1, '07/1/2015', '22:45')
		,( 10, 2, 1, 2, '07/2/2015', '11:30')
		,( 11, 2, 1, 2, '07/2/2015', '17:15')
		,( 12, 2, 1, 2, '07/2/2015', '23:00')
		,( 13, 2, 2, 2, '07/2/2015', '11:00')
		,( 14, 2, 2, 1, '07/2/2015', '16:15')
		,( 15, 2, 2, 3, '07/2/2015', '20:50')
		,( 16, 2, 3, 1, '07/2/2015', '12:15')
		,( 17, 2, 3, 1, '07/2/2015', '17:15')
		,( 18, 2, 3, 1, '07/2/2015', '23:45')
		,( 19, 2, 1, 1, '07/1/2015', '12:00')
		,( 20, 3, 3, 3, '07/1/2015', '17:45')
		,( 21, 3, 3, 1, '07/1/2015', '22:10')
		,( 22, 3, 2, 1, '07/1/2015', '12:00')
		,( 23, 3, 2, 1, '07/1/2015', '16:15')
		,( 24, 3, 2, 1, '07/1/2015', '22:50')
		,( 25, 3, 2, 1, '07/1/2015', '11:45')
		,( 26, 3, 3, 2, '07/1/2015', '16:25')
		,( 27, 3, 3, 1, '07/1/2015', '23:45')
		,( 28, 3, 3, 1, '07/1/2015', '12:00')
		,( 29, 1, 2, 3, '07/1/2015', '17:45')
		,( 30, 1, 4, 1, '07/1/2015', '22:10')
		,( 31, 1, 3, 1, '07/1/2015', '12:00')
		,( 32, 2, 3, 1, '07/1/2015', '16:15')
		,( 33, 2, 4, 1, '07/1/2015', '22:50')
		,( 34, 2, 1, 1, '07/1/2015', '11:45')
		,( 35, 3, 2, 3, '07/1/2015', '16:25')
		,( 36, 3, 3, 1, '07/1/2015', '23:45')
		,( 37, 1, 1, 3, '07/3/2015', '22:10')
		,( 38, 1, 3, 1, '07/3/2015', '12:00')
		,( 39, 2, 3, 1, '07/3/2015', '16:15')
		,( 40, 2, 3, 2, '07/3/2015', '22:50')
		,( 41, 2, 1, 1, '07/3/2015', '11:45')
		,( 42, 3, 2, 3, '07/3/2015', '16:25')
		,( 43, 3, 3, 1, '07/3/2015', '23:45')

INSERT INTO TTicketPrices ( intTheaterID, intScreenTypeID, intTicketTypeID, monTicketPrice )
VALUES	 ( 1, 1, 1, 11.00)  -- Standard Screen, Adult
		,( 1, 1, 2, 8.00)	-- Standard Screen, Student
		,( 1, 1, 3, 6.50)	-- Standard Screen, Child
		,( 1, 1, 4, 7.50)	-- Standard Screen, Senior
		,( 1, 2, 1, 12.00)	-- Imax Screen, Adult
		,( 1, 2, 2, 9.00)	-- Imax Screen, Student
		,( 1, 2, 3, 7.00)	-- Imax Screen, Child
		,( 1, 2, 4, 7.25)	-- IMax Screen, Senior
		,( 1, 3, 1, 15.00)	-- 3D, Adult
		,( 1, 3, 2, 12.00)	-- 3D, Student
		,( 1, 3, 3, 10.00)	-- 3D, Child
		,( 1, 3, 4, 10.50)	-- 3D Screen, Senior
-- Theater 2
		,( 2, 1, 1, 11.50)  -- Standard Screen, Adult
		,( 2, 1, 2, 8.50)	-- Standard Screen, Student
		,( 2, 1, 3, 6.50)	-- Standard Screen, Child
		,( 2, 2, 1, 12.50)	-- Imax Screen, Adult
		,( 2, 2, 2, 9.50)	-- Imax Screen, Student
		,( 2, 2, 3, 7.50)	-- Imax Screen, Child
		,( 2, 3, 1, 15.50)	-- 3D, Adult
		,( 2, 3, 2, 12.50)	-- 3D, Student
		,( 2, 3, 3, 10.50)	-- 3D, Child
		,( 2, 4, 1, 15.50)	-- 4D, Adult
		,( 2, 4, 2, 12.50)	-- 4D, Student
		,( 2, 4, 3, 10.50)	-- 4D, Child
-- Theater 3
		,( 3, 1, 1, 11.50)  -- Standard Screen, Adult
		,( 3, 1, 2, 7.50)	-- Standard Screen, Student
		,( 3, 1, 3, 5.50)	-- Standard Screen, Child
		,( 3, 2, 1, 11.50)	-- Imax Screen, Adult
		,( 3, 2, 2, 9.00)	-- Imax Screen, Student
		,( 3, 2, 3, 7.00)	-- Imax Screen, Child
		,( 3, 3, 1, 15.00)	-- 3D, Adult
		,( 3, 3, 2, 13.00)	-- 3D, Student
		,( 3, 3, 3, 9.50)	-- 3D, Child

INSERT INTO TTicketSales ( intTicketSaleID, intShowingID, intTicketTypeID, monTicketPrice )
VALUES	 ( 1, 1, 1, 11 )
		,( 2, 26, 1, 11.5 )
		,( 3, 28, 1, 11.5 )
		,( 4, 5, 2, 8 )
		,( 5, 26, 3, 7 )	
		,( 6, 12, 1, 12.5 )
		,( 7, 13, 2, 9.5 )
		,( 8, 7, 1, 11 )
		,( 9, 2, 2, 8 )
		,( 10, 16, 3, 6.5 )
		,( 11, 8, 1, 11 )
		,( 12, 22, 2, 7.5 )
		,( 13, 19, 3, 6.5 )
		,( 14, 17, 3, 6.5 )
		,( 15, 9, 1, 11 )
		,( 16, 21, 2, 7.5 )
		,( 17, 27, 2, 7.5 )
		,( 18, 34, 3, 6.5 )
		,( 19, 13, 3, 7.5 )
		,( 20, 11, 1, 12.5 )
		,( 21, 19, 1, 11.5 )
		,( 22, 17, 1, 11.5 )
		,( 23, 1, 2, 8 )
		,( 24, 36, 3, 5.5 )
		,( 25, 11, 2, 9.5 )
		,( 26, 17, 2, 8.5 )
		,( 27, 20, 2, 13 )
		,( 28, 21, 1, 11.5 )
		,( 29, 22, 3, 5.5 )
		,( 30, 21, 3, 5.5 )
		,( 31, 9, 3, 6.5 )
		,( 32, 7, 2, 8 )
		,( 33, 2, 1, 11 )
		,( 34, 3, 1, 11 )
		,( 35, 14, 1, 11.5 )
		,( 36, 30, 1, 15 )
		,( 37, 15, 1, 15.5 )
		,( 38, 29, 1, 15 )
		,( 39, 6, 1, 15 )	
		,( 40, 27, 1, 11.5 )
		,( 41, 36, 1, 11.5 )
		,( 42, 6, 2, 12 )
		,( 43, 10, 3, 7.5 )
		,( 44, 27, 3, 5.5 )

				
---------------------------------------------------------------------------------------------------------
--  Problem #1:	Write a query that returns the total and average sales for each ticket type
--				Each calculation should be for all showings at all theaters.  
--				Your answer will only show theaters and ticket types that have sales.
--				Your answer should be three rows.  A total for Adult tickets, a total for 
--				Child Tickets, a total for Student tickets.   Note, there is a Ticket Type of 
--				'Senior', but there are no sales for this ticket type.
---------------------------------------------------------------------------------------------------------
SELECT
	TTT.intTicketTypeID AS 'Ticket ID'
	,TTT.strTicketType AS 'Ticket Type'
	,SUM(TTS.monTicketPrice) AS 'Total Ticket Sales per Type'
	,AVG(TTS.monTicketPrice) AS 'Average Ticket Price per Type'
FROM
	TTicketTypes AS TTT
	,TTicketSales AS TTS
WHERE
	TTS.intTicketTypeID = TTT.intTicketTypeID
GROUP BY
	TTT.intTicketTypeID 
	,TTT.strTicketType 
ORDER BY
	TTT.strTicketType
	,TTT.intTicketTypeID
---------------------------------------------------------------------------------------------------------
--  Problem #2:	Write a query that returns the total and average sales for each ticket type 
--				at each theater.  You can start with the query in Problem #1. 
--				Note that Theater 4 does not have sales and will not show up in the results.		
---------------------------------------------------------------------------------------------------------
SELECT
	TS.intTheaterID AS 'Theater ID'
	,TT.strTheater AS 'Theater'
	,TTT.intTicketTypeID AS 'Ticket ID'
	,SUM(TTS.monTicketPrice) AS 'Total Ticket Sales per Ticket'
	,AVG(TTS.monTicketPrice) AS 'Average Ticket Price per Type'
FROM
	TTicketTypes AS TTT
	,TTicketSales AS TTS
	,TTheaters AS TT
	,TShowings AS TS
WHERE
	TTS.intTicketTypeID = TTT.intTicketTypeID
AND	TT.intTheaterID = TS.intTheaterID
AND TTT.intTicketTypeID = TTS.intTicketTypeID
GROUP BY
	TS.intTheaterID
	,TTT.intTicketTypeID 
	,TT.strTheater
ORDER BY
	TT.strTheater
	,TTT.intTicketTypeID
---------------------------------------------------------------------------------------------------------
--  Problem #3:	Write a query that provides the total number of showings of each movie 
--              at each theater. Extra Credit for a query that hows movies that are not at 
--              any Theater with a count = 0
---------------------------------------------------------------------------------------------------------
SELECT
	TS.intTheaterID AS 'Theater ID'
	,TT.strTheater AS 'Theater'
	,TM.intMovieID AS 'Movie ID'
	,TM.strMovieName AS 'Movie'
	,COUNT(TS.intMovieID) AS 'Showings per Movie per Theater'
FROM
	TMovies AS TM
	,TShowings AS TS
	,TTheaters AS TT
WHERE
	TM.intMovieID = TS.intMovieID
AND	TT.intTheaterID = TS.intTheaterID
GROUP BY
	TS.intTheaterID 
	,TT.strTheater
	,TM.intMovieID 
	,TM.strMovieName 
	,TS.intMovieID
ORDER BY
	TS.intTheaterID
	,TM.intMovieID
---------------------------------------------------------------------------------------------------------
--  Problem #4: Create a copy of Query #3 and modify it to only show movies with more than 3 showings.
---------------------------------------------------------------------------------------------------------
SELECT
	TS.intTheaterID AS 'Theater ID'
	,TM.intMovieID AS 'Movie ID'
	,TM.strMovieName AS 'Movie'
	,COUNT(*) AS 'Showings per Movie per Theater'
FROM
	TMovies AS TM
	,TShowings AS TS
WHERE
	TM.intMovieID = TS.intMovieID
GROUP BY
	TS.intTheaterID 
	,TM.intMovieID 
	,TM.strMovieName 
	,TS.intMovieID
HAVING
	COUNT(*) > 3
ORDER BY
	TM.intMovieID
	,TS.intTheaterID
---------------------------------------------------------------------------------------------------------
--  Problem #5: Write a query that shows the earliest and latest movie times in each
--				Theater on each date that has a showing.  
---------------------------------------------------------------------------------------------------------
SELECT
	TT.intTheaterID
	,TT.strTheater
	,TT.strTheaterAddress + '; ' + TT.strTheaterCity + ' ' + TT.strTheaterState AS 'Theater Address'
	,MIN(CONVERT(VARCHAR, TS.dteShowDate, 111) + ' ' + CONVERT(VARCHAR, TS.tmeShowTime)) AS 'First Showing'
	,MAX(CONVERT(VARCHAR, TS.dteShowDate, 111) + ' ' + CONVERT(VARCHAR, TS.tmeShowTime)) AS 'Last Showing'
FROM
	TTheaters AS TT
	,TShowings AS TS
	,TMovies AS TM
WHERE
	TT.intTheaterID = TS.intTheaterID
AND	TM.intMovieID = TS.intMovieID
GROUP BY
	TT.intTheaterID
	,TT.strTheater
	,TT.strTheaterAddress
	,TT.strTheaterCity
	,TT.strTheaterState 
ORDER BY
	TT.strTheater
	,TT.intTheaterID
---------------------------------------------------------------------------------------------------------
--  Problem #6: Write a query to list all movies that do not have a showings on 
--				July 3rd.  This query should return movies #4 and #5.
---------------------------------------------------------------------------------------------------------
SELECT
	TM.intMovieID
	,TM.strMovieName
	,TM.strDescription
FROM
	TMovies AS TM
	,TShowings AS TS
WHERE
	TM.intMovieID = TS.intMovieID
AND	TM.intMovieID NOT IN
	(
		SELECT	
			TS.intMovieID
		FROM
			TShowings AS TS
		WHERE
			CONVERT(VARCHAR, TS.dteShowDate, 111) = '07/3/2015'
	)
ORDER BY
	TM.strMovieName
	,TM.intMovieID

