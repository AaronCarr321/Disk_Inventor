/****************************************************************************/
/* Date         Programmer       Description			                    */
/* 03/05/21		Aaron Carr       Initial Deployment of disk_inventory       */
/*                                                                          */
/*                                                                          */
/*                                                                          */

--create db
use master;
go
Drop DATABASE IF EXISTS disk_inventoryAC;
go
CREATE DATABASE disk_inventoryAC;
go
use disk_inventoryAC;
go
IF SUSER_ID('diskUserAC') IS NULL
	CREATE LOGIN diskUserAC
	WITH PASSWORD = 'Sesame_123',
	DEFAULT_DATABASE = disk_inventoryAC;
	CREATE USER diskUserAC;
	ALTER ROLE db_datareader	
		ADD MEMBER diskUserAC
go



--Create look up tables
CREATE TABLE artist_type
(
artist_type_id		INT NOT NULL PRIMARY KEY IDENTITY,
description			NVARCHAR(60) NOT NULL
);

CREATE TABLE genre
(
genre_id		INT NOT NULL PRIMARY KEY IDENTITY,
description		NVARCHAR(60) NOT NULL
);
CREATE TABLE status
(
status_id		INT NOT NULL PRIMARY KEY IDENTITY,
description		NVARCHAR(60) NOT NULL
);
CREATE TABLE borrower
(
borrower_id		INT NOT NULL PRIMARY KEY IDENTITY,
fname           NVARCHAR(60) NOT NULL,
lname			NVARCHAR(60) NOT NULL,
phone_num		NVARCHAR(15) NOT NULL
);
CREATE TABLE disk
(
disk_id		INT NOT NULL PRIMARY KEY IDENTITY,	
disk_name			NVARCHAR(60) NOT NULL,
release_date		DATE NOT NULL,
genre_id			INT NOT NULL REFERENCES genre(genre_id),
status_id			INT NOT NULL REFERENCES status(status_id),
disk_type_id		INT NOT NULL REFERENCES disk_type(disk_type_id)
);
CREATE TABLE artist
(
artist_id		INT NOT NULL PRIMARY KEY IDENTITY,
fname           NVARCHAR(60) NOT NULL,
lname			NVARCHAR(60) NULL,
artist_type		INT NOT NULL REFERENCES artist_type(artist_type_id)
);

CREATE TABLE disk_has_borrower
(
disk_has_borrower_id	INT NOT NULL PRIMARY KEY IDENTITY,
borrowed_date			DATETIME2 NOT NULL,
due_date				DATETIME2 NOT NULL DEFAULT (GETDATE() + 30),
returned_date			DATETIME2 NOT NULL,
borrower_id				INT NOT NULL REFERENCES borrowed(borrower_id),
disk_id					INT NOT NULL REFERENCES disk(disk_id),
);
CREATE TABLE disk_has_artist
(
 disk_has_artist_id		INT NOT NULL PRIMARY KEY IDENTITY,
 disk_id				INT NOT NULL REFERENCES disk(disk_id),
 artist_id				INT NOT NULL REFERENCES artist(artist_id)
 UNIQUE (disk_id, artist_id)
);