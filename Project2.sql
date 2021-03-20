/****************************************************************************/
/* Date         Programmer       Description			            */
/* 03/05/21	Aaron Carr       Initial Deployment of disk_inventory       */
/* 03/12/21     Aaron Carr       Moved project three to project 2           */
/* 03/19/21	Aaron Carr     	 Project 4 Reports                          */
/*                                                                          */

--create db
USE master;
GO
DROP DATABASE IF EXISTS disk_inventoryAC;
Go
CREATE DATABASE disk_inventoryAC;
Go
use disk_inventoryAC;
Go


IF SUSER_ID('diskUserAC') IS NULL CREATE LOGIN diskUserAC WITH PASSWORD = 'Pa$$w0rd', DEFAULT_DATABASE = disk_inventoryAC;

CREATE USER diskUserAC;
ALTER ROLE db_datareader ADD MEMBER diskUserAC;
Go

CREATE TABLE artist_type
	(
	artist_type_id			INT NOT NULL PRIMARY KEY IDENTITY,
	description				NVARCHAR(60) NOT NULL	-- char/varchar works
	);
CREATE TABLE disc_type
	(
	disc_type_id			INT NOT NULL PRIMARY KEY IDENTITY,
	description				NVARCHAR(60) NOT NULL
	);
CREATE TABLE genre
	(
	genre_id				INT NOT NULL PRIMARY KEY IDENTITY,
	description				NVARCHAR(60) NOT NULL
	);
CREATE TABLE status
	(
	status_id				INT NOT NULL PRIMARY KEY IDENTITY,
	description				NVARCHAR(60) NOT NULL
	);



CREATE TABLE artist
	(
	artist_id			INT NOT NULL PRIMARY KEY IDENTITY,
	fname				NVARCHAR(60) NOT NULL,
	lname				NVARCHAR(60) NULL,
	artist_type_id		INT NOT NULL REFERENCES artist_type(artist_type_id)
	);

CREATE TABLE disc
	(
	disc_id					INT NOT NULL PRIMARY KEY IDENTITY,
	disc_name				NVARCHAR(60) NOT NULL,
	release_date			DATE NOT NULL,
	genre_id				INT NOT NULL REFERENCES genre(genre_id),
	status_id				INT NOT NULL REFERENCES status(status_id),
	disc_type_id			INT NOT NULL REFERENCES disc_type(disc_type_id)
	);

CREATE TABLE borrower
	(
	borrower_id				INT NOT NULL PRIMARY KEY IDENTITY,
	fname					NVARCHAR(60) NOT NULL,
	lname					NVARCHAR(60) NOT NULL,
	phone_num				VARCHAR(15) NOT NULL
	);


CREATE TABLE disc_has_borrower
	(
	disc_has_borrower_id	INT NOT NULL PRIMARY KEY IDENTITY,
	borrowed_date			DATETIME2 NOT NULL,
	due_date				DATETIME2 NOT NULL DEFAULT (GETDATE() + 30),
	returned_date			DATETIME2 NULL,
	borrower_id				INT NOT NULL REFERENCES borrower(borrower_id),
	disc_id					INT NOT NULL REFERENCES disc(disc_id)		
	);


CREATE TABLE disc_has_artist
	(
	disc_has_artist_id	INT NOT NULL PRIMARY KEY IDENTITY,
	disc_id				INT NOT NULL REFERENCES disc(disc_id),
	artist_id			INT NOT NULL REFERENCES artist(artist_id)
	UNIQUE (disc_id, artist_id)
	);








INSERT INTO [dbo].[artist_type]
           ([description])
     VALUES
           ('Solo'),
		   ('Group')
GO



INSERT INTO [dbo].[disc_type]
           ([description])
     VALUES
           ('Cassette'),
		   ('CD'),
		   ('DVD'),
		   ('Vinyl')
GO



INSERT INTO [dbo].[genre]
           ([description])
     VALUES
		('Rock'),
		   ('Hip-Hop'),
		   ('R&B'),
		   ('Jazz'),
		   ('Country'),
		   ('Pop'),
		   ('Metal')
GO


INSERT status
	VALUES ('Available');
	INSERT status
	VALUES ('Borrowed');
	INSERT status
	VALUES ('Unavailable');
	INSERT status
	VALUES ('Lost');
	INSERT status
	VALUES ('Damaged');

SELECT *
FROM disc

INSERT borrower (fname, lname, phone_num)
VALUES ('Demi', 'Sampson', '502-275-0299') --1
	  ,('Aubrey', 'Harrell', '920-524-9880') --2
	  ,('Maci', 'Orr', '517-581-7362')--3
	  ,('Billie-Jo', 'Giles', '614-735-3911')--4
	  ,('Jennie', 'Goldsmith', '302-325-1317')--5
	  ,('Harper', 'Bass', '205-460-3457')--6
	  ,('Hafsah', 'Keller', '208-429-4349')--7
	  ,('Carole', 'Rocha', '512-693-5757')--8
	  ,('Amiyah', 'Nelson', '319-269-5248')--9
	  ,('Lynn', 'Shaw', '212-282-4058')--10
	  ,('Kya', 'Pace', '941-725-4715')--11
	  ,('Makayla', 'Moss', '787-719-1942')--12
	  ,('Arnav', 'Summers', '603-666-5565')--13
	  ,('Kingsley', 'Strickland', '706-264-4162')--14
	  ,('Serenity', 'Eastwood', '413-251-0654')--15
	  ,('Lottie', 'Wolfe', '256-682-6098')--16
	  ,('Beauden', 'Haley', '517-526-6249')--17
	  ,('Gethin', 'Jeffery', '909-812-1436')--18
	  ,('Omer', 'Nolan', '325-748-5120')--19
	  ,('Marcus', 'Conway', '224-238-7741')--20
	  ;

Select*
from status

-- Insert Data for Disc table
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--1 One word name
	VALUES ('Skyfall', '10/05/2012', 2, 2, 1);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--2 Two word name
	VALUES ('Growing Pains', '6/15/2018', 3, 1, 1);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--3
	VALUES ('Baby Boy', '8/03/2003', 2, 1, 1);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--4 More than two words name
	VALUES ('Pray You Catch Me', '9/10/2015', 2, 1, 1);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--5
	VALUES ('Ilomilo', '4/10/2020', 2, 2, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--6
	VALUES ('Listen Before I Go', '04/10/2020', 2, 1, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--7

	VALUES ('Havana', '10/08/2017', 3, 1, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--8
	VALUES ('Redbone', '11/17/2016', 1, 2, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--9
	VALUES ('Game', '3/30/2018', 1, 2, 1);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--10
	VALUES ('Jolene', '10/15/1973', 2, 1, 1);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--11
	VALUES ('Alive', '2/23/1999', 2, 1, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--12
	VALUES ('Reflection', '5/25/1998', 2, 1, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--13
	VALUES ('What Kind Of Men', '2/12/2015', 2, 1, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--14
	VALUES ('Rhiannon', '2/04/1976', 2, 1, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--15
	VALUES ('Once Apon a Dream', '1/29/1959', 1, 3, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--16
	VALUES ('Gone Away', '10/20/2017', 2, 4, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--17
	VALUES ('Crazy', '5/03/1994', 2, 3, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--18
	VALUES ('Barracuda', '5/10/1977', 4, 1, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--19
	VALUES ('Butterflies', '1/1/1980', 4, 1, 2);
	INSERT disc (disc_name, release_date, genre_id, status_id, disc_type_id)--20
	VALUES ('New Light', '2/08/2002', 3, 2, 1);


select *
From borrower


DELETE borrower
WHERE borrower_id = 20;



INSERT artist
	VALUES ('Justin', 'Bieber', 1);--1 
	INSERT artist
	VALUES ('Katy', 'Perry', 1);--2
	INSERT artist
	VALUES ('Adele', NULL, 1);--3
	INSERT artist
	VALUES ('Kesha', NULL, 1);--4 
	INSERT artist
	VALUES ('Lauryn', 'Hill', 1);--5
	INSERT artist
	VALUES ('Mariah', 'Carey', 1);--6
	INSERT artist
	VALUES ('Michael', 'Jackson', 1);--7
	INSERT artist
	VALUES ('Post', 'Malone', 1);--8
	INSERT artist
	VALUES ('Florence Welch', NULL, 2);--9 
	INSERT artist
	VALUES ('Florence + the Machine', NULL, 2);--10 
	INSERT artist
	VALUES ('Whitney', 'Houston', 1);--11
	INSERT artist
	VALUES ('Beyonce', NULL, 1);--12
	INSERT artist
	VALUES ('WILLOW', NULL, 1);--13
	INSERT artist
	VALUES ('Selena Gomez', NULL, 1);--14
	INSERT artist
	VALUES ('The ', '1975', 2);--15 
	INSERT artist
	VALUES ('Lorde', NULL, 1);--16
	INSERT artist
	VALUES ('Ne-yo', NULL, 2);--17 
	INSERT artist
	VALUES ('Mabel', NULL, 1);--18
	INSERT artist
	VALUES ('P!nk', NULL, 2);--19
	INSERT artist
	VALUES ('Rihanna', NULL, 1);--20



SELECT *
FROM artist




INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (2, 4, '1-10-2021', '2-10-2021', '2-05-2021');--1
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (3, 5, '2-05-2021', '3-05-2021','2-10-2021');--2
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (3, 6, '3-24-2021', '4-30-2021', '8-10-2021');--3
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (2, 7, '4-21-2021', '5-21-2021', '4-29-2021');--4
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (5, 2, '5-21-2021', '6-24-2021', '7-24-2021');--5
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (5, 7, '6-27-2021', '7-02-2021', '6-28-2021');--6
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (5, 8, '7-01-2021', '8-02-2021', '7-20-2021');--7
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (6, 3, '8-28-2021', '2-28-2021', '2-20-2021');--8
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (11, 14, '9-17-2021', '10-15-2021', NULL);--9
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
		   (12, 15, '10-10-2021', '11-10-2021', '10-13-2021');--10
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
		   (13, 15, '11-20-2021', '12-20-2021', '11-26-2021');--11
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
		   (14, 11, '12-15-2021', '1-15-2021', '1-14-2021');--12
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
		   (15, 11, '1-02-2021', '2-02-2021', '2-2-2021');--13
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
		   (15, 12, '2-03-2021', '3-03-2021', NULL);--14
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (8, 8, '3-04-2020', '4-04-2020', '3-20-2020');--15
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (9, 4, '4-06-2020', '5-06-2020', '4-20-2020');--16
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (10, 9, '5-07-2020', '6-07-2020', '6-10-2020');--17
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (4, 3, '6-21-2020', '7-21-2020', '6-28-2020');--18
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (5, 7, '7-14-2020', '8-14-2020', '7-22-2008');--19
INSERT INTO disc_has_borrower
	(disc_id, borrower_id, borrowed_date, due_date, returned_date)
     VALUES
           (7, 4, '8-01-2010', '9-01-2008', NULL);--20

SELECT * 
FROM disc_has_borrower


INSERT INTO [dbo].[disc_has_artist]
           ([disc_id]
           ,[artist_id])
VALUES
	(1,1),
			(2,2),
			(3,3),
			(4,4),
			(5,5),
			(6,6),
			(7,7),
			(8,8),
			(9,9),
			(10,10),
			(11,11),
			(12,12),
			(13,13),
			(14,14),
			(15,15),
			(16,16),
			(17,17),
			(18,18),
			(19,19),
			(20,20),
			(21,14), 
			(22,21), 
			(22,22);


SELECT *
FROM disc_has_artist


select borrower_id as Borrower_id, disc_id as Disc_id, convert(varchar, borrowed_date, 101) AS Borrowed_date, returned_date as Return_date
from disc_has_borrower
where returned_date IS NULL;
go


--Project 4

--3.
SELECT disc_name AS 'Disc Name',
CONVERT(VARCHAR, release_date, 101) AS 'Release Date',
fname as 'Artist first name', lname AS 'Artist last name'
FROM disc JOIN disc_has_artist ON disc.disc_id = disc_has_artist.disc_id
JOIN artist ON disc_has_artist.artist_id = artist.artist_id
WHERE artist_type_id = 1
ORDER BY lname, fname ASC;
GO


--4.
CREATE VIEW View_Individual_Artist 
AS
SELECT artist_id, fname, lname
FROM artist
WHERE artist_type_id =1;
GO

SELECT fname, lname
FROM View_Individual_Artist
ORDER BY lname, fname;


--5.
SELECT disc_name AS 'Disk Name', CONVERT(VARCHAR, release_date, 101) 
as 'Release Date', fname as 'Group Name'
FROM disc JOIN disc_has_artist ON disc.disc_id = disc_has_artist.disc_id
JOIN artist ON disc_has_artist.artist_id = artist.artist_id
WHERE artist_type_id = 2
ORDER BY fname, disc_name;


--6.
SELECT disc_name AS 'Disk Name', CONVERT(VARCHAR, release_date, 101) 
as 'Release Date', fname as 'Group Name'
FROM disc JOIN disc_has_artist ON disc.disc_id = disc_has_artist.disc_id
JOIN artist ON disc_has_artist.artist_id = artist.artist_id
WHERE artist.artist_id NOT IN (SELECT artist_id FROM View_Individual_Artist)
ORDER BY fname, disc_name;


--7.
SELECT fname AS First, lname AS Last, disc_name AS 'Disc Name',
CAST(borrowed_date AS DATE) AS 'Borrowed Date',CAST(returned_date AS DATE) AS 'Returned Date'
FROM borrower JOIN disc_has_borrower ON borrower.borrower_id = disc_has_borrower.borrower_id
JOIN disc ON disc_has_borrower.disc_id = disc.disc_id
ORDER BY lname, fname, disc_name, borrowed_date;


--8.
SELECT disc.disc_id AS 'Disc ID', disc_name AS 'Disc Name'
FROM disc JOIN disc_has_borrower ON disc.disc_id = disc_has_borrower.disc_id
ORDER BY disc.disc_id;


--9.
SELECT disc_name as 'Disk Name', CAST(borrowed_date AS DATE) as 'Borrowed Date', 
CAST(returned_date AS DATE) as 'Returned Date', lname AS 'Last Name'
FROM disc JOIN disc_has_borrower ON disc.disc_id = disc_has_borrower.disc_id
JOIN borrower ON borrower.borrower_id = disc_has_borrower.borrower_id
