-- mySQL commands:
show databases;
quit;
-- From script to sql database:
mysql -v < Chinook_MySql_AutoIncrementPKs.sql
-- To use a database from root of mySQL
use Chinook;
-- To show tables within selected Database
show tables;
-- To obtain details of a specific table
desc Genre;
 
-- Log all commands and their output to text file:
tee file.txt;
-- Disable logging to file
notee;

-- Test Script:
select count(*) from Track;
select count(*) from Artist;

-- Running Test Script from mySQL:
mysql> source test.sql
 
-- Querying the Database:
mysql> select * from Album limit 5;
 

-- JOINING:
mysql> SELECT Title, Name FROM Album
    -> JOIN Artist ON Album.ArtistID = Artist.ArtistID
    -> LIMIT 5;

-- Select Field 1, Field 2 from FirstTable
-- JOIN SecondTable on FirtTable.ForeignKey = SecondTable.PrimaryKey
-- LIMIT X

-- Creating Records
INSERT INTO Genre (Name) VALUES (‘Trad’);
INSERT INTO Table (Field) VALUES (value);

-- Obtaining ID  of last inserted row:
SELECT LAST_INSERT_ID();
 
-- Searching for that record with the ID:
SELECT Name FROM Genre WHERE GenreId = 26;

-- Updating a record:
UPDATE Genre SET Name = ‘Traditional’ WHERE Name = ‘Trad’;

-- Deleting a record:
DELETE FROM Genre WHERE Name = ‘Trad’;

--------------------------------------------------------------------------------------

select Name from Artist;

select FirstName, LastName from Customer;

select * from Track;

select Name from MediaType;

--------------------------------------------------------------------------------------

select * from Track
WHERE Composer = 'U2';

select * from Album 
where AlbumId = 232;

--------------------------------------------------------------------------------------

select FirstName, LastName, Title from Employee WHERE Title = 'IT Staff';

--------------------------------------------------------------------------------------

select * from Track INNER JOIN Album on Track.AlbumID = Album.AlbumID;

select Name, Title, ArtistID from Track INNER JOIN Album on Track.AlbumId = Album.AlbumID;

select Name as Track, Title as Album, ArtistID from Track INNER JOIN Album on Track.AlbumID = Album.AlbumID;

select Track.Name as Track, Title as Album, Album.ArtistId, Artist.Name as Artist from Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId
    INNER JOIN Artist on Album.ArtistId = Artist.ArtistId;

select Track.Name as Track, Title as Album, Artist.Name as Artist from Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId
    INNER JOIN Artist on Album.ArtistId = Artist.ArtistId;

SELECT Track.Name as Track, Title as Album, Artist.Name as Artist from Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId
    INNER JOIN Artist on Album.ArtistId = Artist.ArtistId
    WHERE Artist.Name = 'U2';

SELECT Track.Name as Track, Title as Album, Artist.Name as Artist from Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId
    INNER JOIN Artist on Album.ArtistId = Artist.ArtistId
    Where Artist.Name = 'U2' AND Track.Name = 'Pride (In the Name of Love)';

Select Track.Name as Track, Title as Album, Artist.Name as Artist FROM Track
INNER Join Album on Track.AlbumId = Album.AlbumId
INNER Join Artist on Album.ArtistId = Artist.ArtistId
WHERE Track.Name = "Believe";

---------------------------------------------------------------------------------------

select Track.Name as Track, Genre.Name as Genre FROM Track 
    INNER Join Genre on Track.GenreID = Genre.GenreID WHERE Genre.Name  = 'Jazz';

SELECT Track.Name as Track, MediaType.Name as MediaType, Genre.Name as Genre FROM Track
    INNER Join Genre on Track.GenreId = Genre.GenreID
    INNER Join MediaType on Track.MediaTypeId = MediaType.MediaTypeId
    WHERE MediaType.Name = "Protected AAC audio file" AND Genre.Name = "Soundtrack";

SELECT Playlist.Name AS Playlist, Track.Name AS Track, Album.Title AS Album, Artist.Name AS Artist FROM Playlist
    INNER JOIN PlaylistTrack ON Playlist.PlaylistId = PlaylistTrack.PlaylistId
    JOIN Track ON PlaylistTrack.TrackId = Track.TrackId
    JOIN Album ON Track.AlbumId = Album.AlbumId
    JOIN Artist on Album.ArtistId = Artist.ArtistId
    WHERE Playlist.Name = 'Grunge';

SELECT Playlist.Name as Playlist, COUNT(*) From Playlist 
    INNER JOIN PlaylistTrack on Playlist.PlaylistId = PlaylistTrack.PlaylistId  
    GROUP BY Playlist HAVING count(*) = 1;

--------------------------------------------------------------------------------------

SELECT * From Album
    ORDER BY Title;

SELECT * From Album
    ORDER BY Title desc;

SELECT * FROM Album
    ORDER BY ArtistID, Title;

SELECT * FROM Album
    ORDER BY ArtistID, Title desc;

SELECT Track.Name, Album.Title FROM Track
    INNER JOIN Album on Track.AlbumId = Album.AlbumId
    ORDER BY Album.Title, Track.Name;

    --------------------------------------------------------------------------------------

SELECT InvoiceDate, BillingCity, Total FROM Invoice
    ORDER BY Total desc
    LIMIT 5;

------------------------------------------------------------------------------------------

SELECT COUNT(*) FROM Customer;
SELECT COUNT(FirstName) FROM Customer;

SELECT COUNT(FirstName) FROM Customer
    WHERE FirstNAme = "Frank";

SELECT MIN(LastName) FROM Customer; --First if Sorted Alphabetically
SELECT MIN(BirthDate) FROM Employee;

SELECT MAX(LastName) FROM Customer; --Last if Sorted Alphabetically
SELECT MAX(BirthDate) FROM Employee;
SELECT MAX(HireDate) FROM Employee;

SELECT AVG(Total) FROM Invoice;

SELECT ROUND (AVG(Total), 2) FROM Invoice;

SELECT Total From Invoice
    WHERE InvoiceID = 2;

SELECT SUM(UnitPrice * Quantity) FROM InvoiceLine
    WHERE InvoiceID = 2;

------------------------------------------------------------------------------------------

SELECT COUNT(*) FROM Track;

SELECT COUNT(*) FROM Track
    GROUP BY AlbumId;

SELECT AlbumId, COUNT(*) FROM Track
    GROUP BY AlbumId;

Select Album.Title, Count(*) From Track
    INNER JOIN Album ON Track.AlbumId = Album.AlbumId
    GROUP BY Track.AlbumId;

SELECT AlbumId, MIN(UnitPrice) FROM Track
    GROUP BY AlbumId;

SELECT AlbumId, MAX(UnitPrice) FROM Track
    GROUP BY AlbumId;

SELECT AlbumId, ROUND(SUM(UnitPrice), 2) FROM Track
    GROUP BY AlbumId;

SELECT Album.Title, ROUND(SUM(Track.UnitPrice), 2) FROM Track
    INNER JOIN Album ON Track.AlbumId = Album.AlbumId
    GROUP BY Track.AlbumId;

------------------------------------------------------------------------------------------

INSERT INTO MediaType (Name)
    VALUES ("Test Media Type 1");

INSERT INTO Album (Title, ArtistId)
    VALUES ("Boy", 150);

SELECT AlbumID From Album WHERE Title = "Boy"; --348

Select MediatypeId FROM MediaType WHERE Name = "Protected AAC audio file"; --2

SELECT GenreId From Genre WHERE Name = "Rock"; --1

INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
    VALUES ("I Will Follow", 348, 2, 1, "U2", 220000, 1234, 0.99);