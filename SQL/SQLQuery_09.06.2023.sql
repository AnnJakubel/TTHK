CREATE TABLE EmployeePhantomRead 
(
Id int PRIMARY KEY,
Name NVARCHAR(25)
)

INSERT INTO EmployeePhantomRead VALUES
(1, 'Mark'),
(3, 'Sara'),
(100, 'Mary')

SELECT * FROM EmployeePhantomRead

--- 1. k2sklus
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

BEGIN TRANSACTION
SELECT * FROM Employee WHERE Id BETWEEN 1 AND 3

WAITFOR DELAY '00:00:10'
SELECT * FROM EmployeePhantomRead WHERE Id BETWEEN 1 AND 3
COMMIT TRANSACTION

--- 2.serveri aknas k2sklus

INSERT INTO EmployeePhantomRead
VALUES(2, 'Marcus')
GO
SELECT * FROM  EmployeePhantomRead

--- erinevus korduvlugemise ja serialiseerimisega 
-- korduv lugemine hoiab �ra ainult kordumatud lugemised
-- serialiseerimine hoiab �ra kordumatud lugemised ja 
-- phantom read probleemid
-- isolatsioonitase tagab, et �he tehingu loetud andmed ei
-- takistaks muid transactioneid


---DEADLOCK
-- kui andmebaasi tekib ummikseis

CREATE TABLE TableA
(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50)
)
GO
INSERT INTO TableA VALUES('Mark')
GO 
CREATE TABLE TableB 
(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50)
)
GO
INSERT INTO TableB VALUES('Mary')

--- Transaction 1
-- 1.k'sklus
BEGIN TRAN 
UPDATE TableA SET Name = 'Mark Transaction 1' WHERE Id = 1

-- 3.k'sklus
UPDATE TableB SET Name = 'Mary Transaction 1'  WHERE Id = 1
COMMIT TRAN

-- 2.k2sklus (2.aken)
BEGIN TRAN 
UPDATE TableA SET Name = 'Mark Transaction 2' WHERE Id = 1

-- 4.k'sklus (2.aken)
UPDATE TableB SET Name = 'Mary Transaction 2'  WHERE Id = 1
COMMIT TRAN

SELECT * FROM TableA
SELECT * FROM TableB

--- Kuidas SQL server tuvastab deadlocki
-- lukustatakse serveri l�im, mis t��tab avikimisi iga 5 sek j�rel
-- et tuvastada ummikuid. Kui leiab deadlocki, siis langeb 
-- deadlocki intervall 5 sek-ilt 100 millisekundini.

--. Mis juuhtub deadlocki tuvastamisel?
-- Tuvastamisel l�petab DB-mootor deadlocki ja valib �he l�ime
-- ohvriks. Seej�rel keeratakse deadlocki ohvri tehing tagasi ja
-- ja tagastatakse rakendusele viga 1206. Ohvri tehingu tagasit�mbamine
-- vabastab k�ik selle transactioni valduses olevad lukud.
-- See v�imaldab teistel transactionitel bokeeringut t�histada ja
-- edasi liikuda.

---Mis on DEADLOCK_PRIORITY
-- Vaikimisi valib SQL server deadlocki ohvri tehingu, mille
-- tagasiv�tmine on k�ige odavam (v�tab k�ige v�hem ressurssi). Seansside
-- prioriteeti saab muuta SET DEADLOCK_PRIORTY

---DEADLOCK_PRIORITY
-- 1. Vaikimisi on see Normal peal
-- 2. Saab seadistada LOW, NORMAL ja HIGH peale
-- 3. Saab seadistada ka nr v��rtusena -10-st kuni 10-ni

--- Ohvri valimise kriteeriumid
-- 1. Kui prioriteedid on erinevad, siis k�ige madalama t�htsusega valitakse ohvriks
-- 2. Kui m�lemal sessioonil on sama prioriteet, siis valitakse ohvriks transaction,
-- mille tagasi viimine on k�ige v�hem ressursi n�udev.
-- 3. Kui m�lemal sessioonil on sama prioriteer ja sama ressurssi kulutamine,
-- siis ohver valitakse juhuslikkuse alusel. 

TRUNCATE TABLE TableA
TRUNCATE TABLE TableB

SET DEADLOCK_PRIORITY NORMAL

INSERT INTO TableA VALUES 
('Mark'),
('Ben'),
('Todd'),
('Pam'),
('Sara')
GO 
INSERT INTO TableB VALUES
('Mary')


-- transaction 1
-- 1.k'sklus

BEGIN TRAN
UPDATE TableA set Name  = Name + 'Transaction 1' WHERE Id IN(1, 2, 3, 4, 5)

-- 3.k2sklus
UPDATE TableB SET Name = NAme + 'Transaction 1' WHERE Id = 1
COMMIT TRAN

----(2.aken)
-- 2.k'sklus
SET DEADLOCK_PRIORITY HIGH
BEGIN TRAN
UPDATE TableB SET Name = Name + 'Transaction 1' WHERE Id = 1

-- 4.k2sklus
UPDATE TableA SET Name = Name + 'Transaction 1' WHERE Id IN(1, 2, 3, 4, 5)
COMMIT TRAN

---Deadlocki logimine
dbcc Traceon(1222, -1)

dbcc TraceSTatus(1222, -1)

dbcc Traceoff(1222, -1)

-- Tabelid tyhjaks
TRUNCATE TABLE TableA
TRUNCATE TABLE TableB

CREATE PROCEDURE spTransaction1
AS 
BEGIN
	BEGIN TRANSACTION 
	UPDATE TableA SET Name = Name + 'Mark Transaction 1' WHERE Id = 1
	WAITFOR DELAY '00:00:05'
	UPDATE Tableb SET Name = Name + 'Mary Transaction 1' WHERE Id = 1
	COMMIT TRANSACTION
END 

CREATE PROCEDURE spTransaction2
AS 
BEGIN
	BEGIN TRANSACTION 
	UPDATE TableA SET Name = Name + 'Mark Transaction 2' WHERE Id = 1
	WAITFOR DELAY '00:00:05'
	UPDATE Tableb SET Name = Name + 'Mary Transaction 2' WHERE Id = 1
	COMMIT TRANSACTION
END 

-- Avame 2 SQLi editori ja [hes k'ivitame esimese sp ja teises teise sp
spTransaction1

-- 2.aken 
spTransaction2

EXECUTE sp_readerrorlog



--- Deadlocki vea k�sitlemine try catchiga
ALTER PROC spTransaction1 
AS BEGIN
	BEGIN TRAN
	BEGIN TRY 
		UPDATE TableA SET Name = 'Mark Transaction 1' WHERE Id = 1
		WAITFOR DELAY '00:00:05'
		UPDATE TableB SET Name = 'Mary Transaction 1' WHERE Id = 1
		COMMIT TRAN
		SELECT 'Transaction Successful'
	END TRY
	BEGIN CATCH
		--- vaatab, kas error on selle deadlocki oma
		IF (ERROR_NUMBER() = 1205)
		BEGIN 
			SELECT 'Deadlock. Transaction failed. Please retry'
		END
		ROLLBACK
	END CATCH
END

ALTER PROC spTransaction2 
AS BEGIN
	BEGIN TRAN
	BEGIN TRY 
		UPDATE TableA SET Name = 'Mark Transaction 2' WHERE Id = 1
		WAITFOR DELAY '00:00:05'
		UPDATE TableB SET Name = 'Mary Transaction 2' WHERE Id = 1
		COMMIT TRAN
		SELECT 'Transaction Successful'
	END TRY
	BEGIN CATCH
		--- vaatab, kas error on selle deadlocki oma
		IF (ERROR_NUMBER() = 1205)
		BEGIN 
			SELECT 'Deadlock. Transaction failed. Please retry'
		END
		ROLLBACK
	END CATCH
END

--K2ivitan esimeses aknas
spTransaction1

--K'ivitan 2.aknas
spTransaction2


--�LESANNE
--  1.Teha kaks kasutajat.
-- 2. Esimene saab vaadata andmebaasi X ja tabelit nimega Autod (tuleb luua 4 veergu)
-- 3. Teine saab vaadata andmebaasi x ja tabelir Autod. Tema saab tabelis ainult
-- vaadata andmeid ning kahte veergu (sinu valikul)

CREATE DATABASE S�idukid
USE S�idukid

CREATE TABLE Autod
(
Numbrim�rk NVARCHAR(6),
V�rv NVARCHAR(25),
VINKood NVARCHAR(17),
Omanik NVARCHAR(50)
)

INSERT INTO Autod VALUES
('123ABC', 'Punane', '1234567ASDFGHJ123', 'Artur Allikas'),
('321BCA', 'Sinine', '567ASDF1224GHJ567', 'Merje Meri'),
('768IJK', 'Must', '946EERGF1224GHJ12', 'Rita Ronk')


SELECT * FROM Autod

DROP TABLE Autod

GRANT SELECT ON Autod TO Kasutaja1
GRANT SELECT ON Autod(VINKood, Omanik) TO Kasutaja2