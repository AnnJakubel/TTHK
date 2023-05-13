--- Korduv CTE
--- CTE mis iseendale viitab, kutsutakse korduvaks CTE-ks
--- kii tahad andmeid n'idata hierarhiliselt

select * from Employee

-- tabel andmeteest tyhjaks
truncate table Employees

alter table Employee
add Gender nvarchar(10)

insert into Employees values
(1, 'Tom', 'm', 2),
(2, 'Josh', 'm', NULL),
(3, 'Mike', 'm', 2),
(4, 'John', 'm', 3),
(5, 'Pam', 'f', 1),
(6, 'Mary', 'f', 3),
(7, 'James', 'm', 1),
(8, 'Sam', 'f', 5),
(9, 'Simon', 'm', 1)

-- yks v6imalus on teha self joiniga
-- ja kuvada NULL veeru asemele Super Boss

select Emp.Firstname as [Employee Name],
ISNULL(Manager.FirstName, 'Super Boss') as [Manager Name]
from dbo.Employees Emp
left join Employee Manager
on Emp.DepartmentId = Manager.Id
go
select * from Employee

---
with EmployeeCTE(Id, FirstName, Gender, ManagerId, [Level])
as
(
	select Employees.Id, FirstName, Gender, ManagerId, 1
	from Employees
	Where ManagerId is null

	union all
	select Employees.Id, Employees.FirstName,
	Employees.Gender,
	Employees.ManagerId, EmplyeeCTE.[Level] + 1
	from Employees
	join EmployeeCTE on Employees.ManagerId = EmployeeCTE.Id
)
select EmpCTE.FirstName as Employee, 
ISNULL(MrgCTE.FirstName, 'Super Boss') as Manager,
EmpCTE.[Level]
from EmployeeCTE EmpCTE
left join EmployeeCTE MrgCTE
on EmpCTE.ManagerId = MrgCTE.Id


--- PIVOT


create table ProductSales2
(
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

insert into ProductSales2 values
('Tom', 'UK', 200),
('John', 'US', 180),
('John', 'UK', 260),
('David', 'India', 450),
('Tom', 'India', 350),

('David', 'US', 200),
('Tom', 'US', 130),
('John', 'India', 540),
('John', 'UK', 120),
('David', 'UK', 220),

('John', 'UK', 420),
('David', 'US', 320),
('Tom', 'US', 340),
('Tom', 'UK', 660),
('John', 'India', 430),

('David', 'India', 230),
('David', 'India', 280),
('Tom', 'UK', 480),
('John', 'UK', 360),
('David', 'UK', 140)

--

select SalesCountry, SalesAgent, SUM(SalesAmount) as Total
from ProductSales2
group by SalesCountry, SalesAgent
order by SalesCountry, SalesAgent

-- pivot n'ide
select SalesAgent, India, US, UK 
from ProductSales2
pivot
(
sum(SalesAmount) for SalesCountry in ([India], [US], [UK])
)
as PivotTable

--p2ring muudab unikaalsete veergude v22rtust (India, US, UK)
--SalesCountry veerus omaette veergueks koos veerfude SalesAmount liitmisega.

create table ProductsWithId
(
Id int primary key,
SalesAgent nvarchar(50),
SalesCountry nvarchar(50),
SalesAmount int
)

insert into ProductsWithId values
(1, 'Tom', 'UK', 200),
(2,'John', 'US', 180),
(3, 'John', 'UK', 260),
(4, 'David', 'India', 450),
(5, 'Tom', 'India', 350),

(6, 'David', 'US', 200),
(7, 'Tom', 'US', 130),
(8,'John', 'India', 540),
(9, 'John', 'UK', 120),
(10, 'David', 'UK', 220),

(11, 'John', 'UK', 420),
(12, 'David', 'US', 320),
(13, 'Tom', 'US', 340),
(14, 'Tom', 'UK', 660),
(15, 'John', 'India', 430),

(16, 'David', 'India', 230),
(17, 'David', 'India', 280),
(18, 'Tom', 'UK', 480),
(19, 'John', 'UK', 360),
(20, 'David', 'UK', 140)

--
select SalesAgent, India, US, UK
from ProductsWithId
pivot
(
sum(SalesAmount) for SalesCountry in ([India], [US], [UK])
)
as PivotTable
--tulemuse p6hjuseks on Id veeru olemasoli ProductsWithId, 
--mida v6etakse arvesse

select SalesAgent, India, US, UK
from 
(
	select SalesAgent, SalesCountry, SalesAmount 
	from  ProductsWithId
)
as SourceTable
pivot 
(
	sum(SalesAmount) for SalesCountry in (India, US, UK)
)
as PivotTable

--UNPIVOT
select Id, FromAgentOrCountry, CountryOrAgent
from
(
	select Id, SalesAgent, SalesCountry, SalesAmount
	from ProductsWithId
) as SourceTable
unpivot
(
	CountryOrAgent for FromAgentOrCountry in 
	(SalesAgent, SalesCountry)
)
as PivotTable

---Transction
-- j2lgib j2rgmisi samme:
-- 1.selle algus
-- 2. k2ivitab DB k2ske
-- 3. kontrollib vigu. Kui on viga, siis taastab algse oleku

create table MailingAddress
(
id int not null primary key,
EmployeeNumber int,
HouseNumber nvarchar(50),
StreetAddress nvarchar(50),
City nvarchar(10),
PostalCode nvarchar(20)
)

insert into MailingAddress
values (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')

create table PhysicalAddress
(
id int not null primary key,
EmployeeNumber int,
HouseNumber nvarchar(50),
StreetAddress nvarchar(50),
City nvarchar(10),
PostalCode nvarchar(20)
)

insert into PhysicalAddress
values (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW')

-- loome sp
create proc spUpdateAddress
as begin
	begin try
		begin transaction
			update MailingAddress set City = 'LONDON'
			where MailingAddress.Id = 1 and EmployeeNumber = 101

			update PhysicalAddress set City = 'LONDON'
			where PhysicalAddress.Id = 1 and EmployeeNumber = 101
		commit transaction
	end try
	begin catch
		rollback tran
	end catch
end

--k2ivitame sp
spUpdateAddress
go
select * from MailingAddress
go
select * from PhysicalAddress

alter proc spUpdateAddress
as begin
	begin try
		begin transaction
			update MailingAddress set City = 'LONDON 12'
			where MailingAddress.Id = 1 and EmployeeNumber = 101

			update PhysicalAddress set City = 'LONDON LONDON'
			where PhysicalAddress.Id = 1 and EmployeeNumber = 101
		commit transaction
	end try
	begin catch
		rollback tran
	end catch
end

spUpdateAddress
go
select * from MailingAddress
go
select * from PhysicalAddress

--kui teine uuendsu ei l2he l2bi, siis esimene ei l2he ka l2bi
-- k6ik uuendused peavad l2bi minema

--- transaction ACID test
--edukas transaction peab l2bima ACID testi:
--A - atomic ehk aatomlikus
--C - consistend ehk j2rjepidevus
--I - isolated ehk isoleeritus
--D - durable ehk vastupidav

---Atomic - k6ik tehingud transactionis on kas edukalt t2idetud v6i need lykatakse tagasi. 
--Nt, m6lemk2sud peaksid alati 6nnestuma. Andmebaa teeb sellisel juhul: v6tab esimese update 
--tagasi ja veeretab selle algasendissse ehk taastab algsed andmed.

---Consistent - k6ik transactioni puudutavad andmed j2takse loogiliselt j2rjepidevasse olekusse.
--Nt kui laos saadaval olevaid esemete hulka v2hendatakse, siis tabelis peab olema vastav kanne. 
--Inventuur ei saa lihtsalt kaduda.

---Isolated - transaction peab andmeid m6jutama, sekkumata teistesse samaaegsetesse transactionitesse.
--See takistab andmete muutmist, mis p6hinevad sidumata tabelitel. Nt muudatused kirjas, mis hiljem tagasi
--muudetakse. Enamik DB-d kasutab tehingute isoleerimise s2ilitamiseks lukustamist.

---Durable - kui muudatus on tehtud, siis see on pysiv. Kui systeemiviga v6i voolukatkestus
--ilmneb enne k2skude komplekti valmimist, siis tyhistatakse need k2sud ja andmed taastatakse
--algsesse olekusse. Taastamine toimub peale systeemi taask2ivitamist.


---Subqueries
--
create table Product2
(
Id int identity primary key,
Name nvarchar(50),
Description nvarchar(250)
)

create table ProductSales4
(
id int primary key identity,
ProductId int foreign key references Product(Id),
UnitPrice int,
QuantitySold int
)

insert into Product2 values
('TV', '52 inch black color LCD TV'),
('Laptop', 'Very thin black color laptop'),
('Desktop', 'HP high performance dekstop')

insert into ProductSales4 values
(3, 450, 5),
(2, 250, 7),
(3, 450, 4),
(3, 450, 9)

--kirjutame p2ringu, mis annab infot myymata toodetest
select Id, Name, Description
from Product2
where ID not in (select distinct ProductId from ProductSales4)


--enamsu juhtudel saab subqueryt asendada JOIN-iga
--teeme sama p2ringu JOIN-iga
select Product2.Id, Name, Description
from Product2 left join ProductSales on Product2.Id = ProductSales4.ProductId
where ProductSales4.ProductId is null

--teeme subquery, kus kasutame select-i. Kirjutame p2ringu, kus
--saame teada NAME ja TotalQuantity veeru andmeid.

select Name,
(select sum(QuantitySold) from ProductSales4 where ProductId = Product2.Id)
as [TotalQuantity]
from Product2
order by Name

--sama tulemusJOIN-iga
select Name, SUM(QuantitySold) as TotalQuantity
from Product2 left join ProductSales4
on Product2.Id = ProductSales4.ProductId
group by Name
order by Name

--subqueryt dssb dubquery sisse panna
--subquerid on alati sulgudes ja neid nimetatakse sisemisteks p2ringuteks


---Rohkete andmetega  testimise tabel

truncate table Product2
truncate table ProductSales4

select * from Product2
select * from ProductSales4


--sisestame n2idisandmed Product2 tabelisse:
declare @Id int
set @Id = 1
while(@Id <= 300)
begin
	insert into Product2 values
	('Product - ' + CAST(@Id as nvarchar(20)),
	'Product - ' + CAST(@Id as nvarchar(20)) + ' Description')

	print @Id
	set @Id = @Id + 1
end


declare @RandomProductId int
declare @RandomUnitPrice int
declare @RandomQuantitySold int


--ProductId 
declare @LowerLimitForProductId int
declare @UpperLimitForProductId int

set @LowerLimitForProductId = 1
set @UpperLimitForProductId = 1000

--UnitPrice
declare @LowerLimitForUnitPrice int
declare @UpperLimitForUnitPrice int

set @LowerLimitForUnitPrice = 1
set @UpperLimitForUnitPrice = 100

--Quantity Sold
declare @LowerLimitForQuantitySold int
declare @UpperLimitForQuantitySold int

set @LowerLimitForQuantitySold = 1
set @UpperLimitForQuantitySold = 10

declare @Counter int
set @Counter = 1

while(@Counter <= 450)
begin
	select @RandomProductId = ROUND(((@UpperLimitForProductId - 
	@LowerLimitForProductId) * Rand() + @LowerLimitForProductId), 0)

	select @RandomUnitPrice = ROUND(((@UpperLimitForUnitPrice - 
	@LowerLimitForUnitPrice) * Rand() + @LowerLimitForUnitPrice), 0)

	select @RandomQuantitySold = ROUND(((@UpperLimitForQuantitySold - 
	@LowerLimitForQuantitySold) * Rand() + @LowerLimitForQuantitySold), 0)

	insert into ProductSales4
	values (@RandomProductId, @RandomUnitPrice, @RandomQuantitySold)

	print @Counter
	set @Counter = @Counter + 1
end
go

select * from Product2
select * from ProductSales4

truncate table Product2
truncate table ProductSales4

select Id, Name, Description
from Produc2
where Id in
(
	select Product2.Id from ProductSales2
)

-- teeme cache puhtaks, et uut p2ringut ei ole kuskile vahem2llu salvestatud.
checkpoint;
go
dbcc DROPCLEANBUFFERS; --puhastab p2ringu cache-i
go
dbcc FREEPROCCACHE; --puhastab t2itva planeeritud cache-i
go

-- teeme sama tabeli peale inner join p2ringu
select distinct Product2.Id, Name, Description
from Product
inner join ProductSales4
on Product2.Id = ProductSales4.ProductId
--p2ring tehti 1 sekundiga
--teeme vahem2lu puhtaks

select Id, Name, Description 
from Product2
where not exists(select * from ProductSales4 where ProductId = Product2.Id)
--1 sek 
--vahem2;u puhtaks

select Product2.Id, NAme, Descriptiom
from Product2
left join ProductSales4
on Product2.Id = PRoductSales4.ProductId
where ProductSales4.ProductId is null

-- CURSOR-id
--relatsiooniliste DNB-de haldussysteemid saavad v2ga h2sti hakkama SETS-iga. SETS lubab mitut p2ringut
--kombineerida yheks tulemuseks.
--Sinna allak2ivad UNION, INTERSEXT ja ...

update ProductSales4 set UnitPrice = 50 where ProductSales4.ProductId = 101

--kui on vaja rea kaupa andmeid t66delda, siis k6ige parem oleks kasutada
--Cursoreid. Samas on need j6udlusele halvad ja v6imalusel v2ltida.
--Soovitav oleks kasutada JOIN-i.

--Cursorif jagunevad omakorda neljaks:
--1. Froward-Only e edasi-ainult
--2.Static e staatilised
--3.Keyset e v6tmele seadistatud
--4. Dynamic e dynaamiline

--cursori n2ide.
if the ProductName = 'Product - 55', set UnitPrice to 55

--------
declare @ProductId int
-- deklareerime cursori
declare ProductIdCursor cursor for
select ProductId from ProductSales4
--open avaldusega t2iddab select avaldust
--ja sisestab tulemuse 
open ProductIdCursor

fetch next from ProductIdCursor into @ProductId
--kui tulemuses on veel ridu, siis @@FETCH_STATUS on 0
while(@@FETCH_STATUS = 0)
begin
	declare @ProductName nvarchar(50)
	select @ProductName = Name from Product2 where ID = @ProductId

	if(@ProductName = 'Product - 55')
	begin
		update ProductSales4 set UnitPrice = 55 where ProductId = @ProductId
	end

	else if(@ProductName = 'Product - 65')
	begin
		update ProductSales4 set UnitPrice = 65 where ProductId = @ProductId
	end

	else if(@ProductName = 'Product - 1000')
	begin
		update ProductSales4 set UnitPrice = 1000 where ProductId = @ProductId
	end

	fetch next from ProductIdCursor into @ProductId
end
-- vabastab rea seadistuse e sulgeb cursori 
close ProductIdCursor
--vabastab resssursid
deallocate ProductIdCursor

--vaatame kas read on uuendatud
select Name, UnitPrice
from Product2 join
ProductSales4 on Product2.Id = ProductSales4.ProductId
where(Name = 'Product - 55' or Name = 'Product - 65' or NAme = 'Product - 1000')

--- asendame cursori joiniga
update ProductSales4
set UnitPrice = 
	case
		when Name = 'Product - 55' Then 155
		when Name = 'Product - 65' Then 165
		when Name = 'Product - 1000' Then 1001
	end
from ProductSales2
join Product2
on Product2.Id = ProductSales4.ProductId
where Name = 'Product - 55' or Name = 'Product - 65' or
Name like 'Product - 1000' 

--vaatame tulemust
select Name, UnitPrice
from Product2 join
ProductSales4 on Product2.Id = ProductSales4.ProductId
where (NAme = 'Product - 55' or Name = 'Product - 65' or Name = 'Product - 1000')

---Tabelite info

--nimekiri tabelitest
select * from sysobjects where  xtype = 'S'

select * from sys.tables 

--nimekiri tabelitest ja view-st
select * from INFORMATION_SCHEMA.TABLES

--kui soovid erinevaid objektityype vaadata, siis kasuta XTYPE 
--syntaksit
select distinct XTYPE from sysobjects
select * from sysobjects where XTYPE = 'V'
--IT t2hendab internal table
--P - stored procedure
--PK - primary key constraint
--S - system table
--SQ - service queue
--U -user table
--V -view

--annab teada, kas selle nimega tabel on olemas
if not exists (select * from INFORMATION_SCHEMA.TABLES
				where TABLE_NAME = 'Employees')
begin
	create table Employees
	(
	Id int primary key,
	Name nvarchar(30),
	Gender nvarchar(10),
	ManagerId int
	)
	print 'Table Employees created'
	end
	else
	begin
		print 'Table Employees already exists'
end

---saab aksutada ka sisseeehitatud funktsiooni: OBJECT_ID()
if OBJECT_ID('Employeeeeees') is null
begin
	print 'Table created'
end
else
begin
	print 'Table already exists'
end

--tahame sama nimega tabeli 2ra kustutada ja siis uuesti luua
if OBJECT_ID('EmployeeTest') is not null
begin
	drop table EmployeeTest
end
create table EmployeeTest
(
Id int primary key,
NAme nvarchar(30),
ManagerId int
)

alter table Employees
add Email nvarchar(50)

--kui teha uuesti k2ivitatavaks veeru kontrollimist ja loomist
if not exists(select * from INFORMATION_SCHEMA.COLUMNS where
COLUMN_NAME='Phone' and TABLE_NAME = 'Employees' and TABLE_SCHEMA = 'dbo')
begin
	alter table Employees 
	add Phone nvarchar(50)
end
else
begin
	print 'Column already exists'
end

--kontrollime, kas mingi nimega veerg on olemas
if COL_LENGTH('Employees', 'Easd') is not null
begin
	print 'Column already exists'
end
else
begin 
	print 'Column does not exist'
end