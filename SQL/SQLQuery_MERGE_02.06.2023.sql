-- 02.06.2023
-- MERGE
-- Tutvustati aastal 2008, mis lubab teha sisestamist, uuendamist ja kustutamist

merge [target] as T
using [source] as S
	on [join_conditions]
when matched then
	[update-statement]
when not matched by target then
	[insert_statement]
when not matched by source then
	[delete_statement]

CREATE TABLE StudentSource
(
Id int PRIMARY KEY,
Name nvarchar(20)
)
go
INSERT INTO StudentSource VALUES
(1, 'Mike'),
(2, 'Sara')
go

CREATE TABLE StudentTarget
(
Id int PRIMARY KEY,
Name nvarchar(20)
)
go
INSERT INTO StudentTarget VALUES
(1, 'Mike M'),
(3, 'John')
go

--- 1. Kui leitakse klappiv rida, siis StudentTarget tabel on uuendatud.
--- 2. Kui read on  StudentSource tabelis olemas, aga neid ei ole StudentTargetis,
--- siis puuduolevad read sisestatakse
--- 3. Kui read on olemas StudentTargetis, aga mitte StudentSources, siis
--- StudentTarget tabelis read kustutatakse. 

MERGE StudentTarget AS T
USING StudentSource AS S
ON T.Id = S.Id
WHEN matched THEN
	UPDATE SET T.Name = S.Name
WHEN not matched BY TARGET THEN
	INSERT (Id, Name) values(S.Id, S.Name)
WHEN not matched BY SOURCE THEN
	DELETE;

SELECT * FROM StudentTarget
SELECT * FROM StudentSource

--- Tabelid sisust tühjaks
TRUNCATE TABLE StudentSource
TRUNCATE TABLE StudentTarget

--- ...ja sisestame andmed uuesti.
INSERT INTO StudentSource VALUES
(1, 'Mike'),
(2, 'Sara')
go

INSERT INTO StudentTarget VALUES
(1, 'Mike M'),
(3, 'John')

MERGE StudentTarget as T
USING StudentSource as S
ON T.Id = S.Id
WHEN matched THEN
	UPDATE SET T.Name = S.Name
WHEN not matched BY TARGET THEN
	INSERT (Id, Name) values(S.Id, S.Name);

SELECT * FROM StudentTarget
SELECT * FROM StudentSource

--- TRANSACTION-id
--- ...on rühm käske, mis muudavad andmebaasis salvestatud 
--- andmeid. Tehingut käsitletakse ühe tööüksusena. Kas kõik
--- käsud õnnestuvad või mitte. Kui üks tehing sellest ebaõnnestub,
--- siis kõik juba muudetud andmed muudetakse tagasi. 

CREATE TABLE Account 
(
Id int PRIMARY KEY,
AccountName nvarchar(25),
Balance int
)
GO
INSERT INTO Account VALUES(1, 'Mark' , 1000)
INSERT INTO Account VALUES(2, 'Mary' , 1000)

BEGIN TRY
	BEGIN TRANSACTION
		UPDATE Account SET Balance = Balance - 100 WHERE Id = 1
		UPDATE Account SET Balance = Balance + 100 WHERE Id = 2
	COMMIT TRANSACTION
	PRINT 'Transaction Committed'
END TRY
BEGIN CATCH 
	ROLLBACK TRANSACTION 
	PRINT 'Transaction Rolled Back'
END CATCH 

SELECT * FROM Account

--- Mõned levinumad probleemid:
--- 1. Dirty read ehk must lugemine
--- 2. Lost updates ehk kadunud uuendused
--- 3. Nonrepeatable reads ehk kordumatud lugemised
--- 4. Phantom read ehk fantoomlugemine

--- Kõik eelnevad probleemid lahendaks ära, kui lubaksite igal ajal
--- korraga ühel kasutajal ühe tehingu teha. Selle tulemusel kõik tehingud
--- satuvad järjekorda ja neil võib tekkida vajadus kaua oodata, enne
--- kui võimalus tehingut teha saabub.

--- Kui lubada samaaegselt kõik tehingud ära teha, siis see omakorda tekitab probleeme.
--- Probleemi lahendamiseks pakub MSSQL server erinevaid tehinguisolatsiooni tasemeid,
--- et tasakaalustada samaaegsete andmete CRUD(Create, Read, Update, Delete) probleeme: 

--- 1. Read uncommitted ehk lugemine ei ole teostatud
--- 2. Read committed ehk lugemine tehtud
--- 3. Repeatable read ehk korduv lugemine
--- 4. Snapshot ehk kuvatõmmis
--- 5. Serializable ehk serialiseerimine

--- Igale juhtumile tuleb läheneda juhtumipõhiselt ja
--- mida vähem valet lugemist tuleb, seda aeglasem.

CREATE TABLE Inventory 
(
Id int IDENTITY PRIMARY KEY,
Product nvarchar(100),
ItemsInStock int
)
go
INSERT INTO Inventory VALUES('iPhone', 10)
SELECT * FROM Inventory

--- Dirty read näide
--- 1.käsklus
--- esimene transaction

