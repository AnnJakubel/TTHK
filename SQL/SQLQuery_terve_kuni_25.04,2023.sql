create database TARge22
--- tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine tabelisse
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (3, 'Unknown')

--- vaatame tabeli sisu
select * from Gender

-- tabeli tegemine
create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'w@w.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (3, 'Batman', 'bat@bat.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (4, 'Aquaman', 'a@a.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (5, 'Catwoman', 'c@c.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (6, 'Antman', 'ant"ant.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (8, NULL, NULL, 2)

--kuidas saab tabeli sisu vaadata???
select * from Person

-- võõrvõtme õhenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla väärtust,
-- siis see automaatselt sisetab sellele reale väärtuse 3
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

insert into Person (Id, Name, Email)
values (11, 'asdasd', 'asd@asd.com')

select * from Person

--piirangu maha v]tmine
alter table Person
drop constraint DF_Persons_GenderId

-- lisame uue veeru juurde
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--andmete uuendamine
update Person
set Age = 50
where Id = 6

select * from Person

insert into Person (Id, Name, Email, GenderId, Age)
values (10, 'Ironmn', 'i@iron.com', 2, 45)

-- lisame veeru juurde
alter table Person
add City nvarchar(50)

--- k]ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
-- k]ik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
-- k]ik, kes ei ela Gothamis, teine variant
select * from Person where City <> 'Gotham'

--n'itab teatud vanusega inimesi
select * from Person where Age = 120 or Age = 50 or Age = 28
select * from Person where Age in (120, 50, 28)

-- n'itab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 40 and 120

--wildcardi kasutamine e n'itab k]ik g-t'hega linnad
select * from Person where City like 'n%' 
-- email, milles on @ m'rk 
select * from Person where Email like '%@%'

-- n'itab k]iki, kellel on emailis ees ja 
-- peale @-m'rki ainult [ks t'ht
select * from Person where Email like '_@_.com'

-- k]ik, kellel nimes ei ole esimene t'ht W, A ja C
select * from Person where Name like '[^WAC]%'

--- kes elavad Gothamis ja New Yorkis
select * from Person where (City = 'Gotham' or City = 'New York')

-- kes elavad Gothamis ja New Yorkis ning on 
-- vanemad, kui 27
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 27

-- kuvab t'hestikulises j'rjekorras inimesi 
-- ja v]tab aluseks nime
select * from Person order by Name
-- vastupidine j'rjestus
select * from Person order by Name desc

--v]tab kolm esimest rida
select top 3 * from Person

--kolm esimest, aga tabeli j'rjestuses on Age ja siis Name
select top 3 Age, Name from Person

--kuvab esimesed 50% tabelist
select top 50 percent * from Person

-- v]tab neli esimest ja j'rjestab vanuse j'rgi
select top 4 * from Person order by Age desc

-- muudab Age muutuja intiks ja n'itab 
-- vanuselises j'rjestuses
select * from Person order by CAST(Age as int)

--kuvab k]ige nooremat isikut
select MIN(CAST(Age as int)) from Person
--kuvab k]ige vanemat isikut
select Max(CAST(Age as int)) from Person


-- n'eme konkreetsetes linnades olevate isikute koondvanust
select City, SUM(Age) as TotalAge from Person group by City

-- muudame koodiga andmet[[pi ja selle pikkust
alter table Person
alter column Name varchar(25)


-- kuvab esimeses reas v'lja toodud j'rjestuses ja kuvab Age-i
-- TotalAge-ks
-- j'rjestab Citys olevate nimede j'rgi ja siis GenderId j'rgi
select City, GenderId, SUM(Age) as TotalAge from Person
group by City, GenderId order by City

-- n'itab, et miu rida on selles tabelis
select COUNT(*) from Person

-- n'itab tulemust, et mitu inimest on GenderId v''rtusega 2
-- konkreetses linnas
-- arvutab vanuse kokku selles linnas
select GenderId, City, SUM(Age) as TotalAge, COUNT(Id) 
as [Total Person(s)] from Person
where GenderId = '2'
group by GenderId, City

-- n'itab 'ra, et mitu inimest on koondvanusena 
-- vanemad, kui 41 ja kui 
-- palju igas linnas elab
select GenderId, City, SUM(Age) as TotalAge, COUNT(Id) 
as [Total Person(s)] from Person
group by GenderId, City having SUM(Age) > 41



-- loome kaks tabelit
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
[Location] nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(50),
Salary nvarchar(50),
DepartmentId int
)

insert into Employees values 
(1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russell', 'Male', 8800, NULL)

insert into Department values
(1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department', 'Sydney', 'Cindrella')

--- 24.03.2023 2 tund

select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

select * from Employees

--arvutab k]ikide palgad kokku
--kasutame CAST-i kuna Salary on nvarchar andmet[[p
-- SUM arvutab k]ik kokku
select SUM(CAST(Salary as int)) from Employees
-- min palga saaja
select min(CAST(Salary as int)) from Employees
-- [he kuu palgafond linnade l]ikes
select City, SUM(CAST(Salary as int)) as TotalSalary 
from Employees
group by City

alter table Employees
add City nvarchar(30)

-- toome soolise erisuse p'ringusse
select City, Gender, SUM(CAST(Salary as int)) as [Total Salary] 
from Employees group by City, Gender

--j'rjestab linnade kaupa palgafondi
select City, Gender, SUM(CAST(Salary as int)) as [Total Salary] 
from Employees group by City, Gender order by City

---loeb 'ra, mitu inimest on nimekirjas e mitu rida on tabelis
select COUNT(*) from Employees

--saan teada, kui palju on t;;tajaid soo kaupa linnas
select Gender, City, SUM(CAST(Salary as int)) as [Total Salary],
COUNT (Id) as [Total Employee(s)]
from Employees
group by Gender, City

--kuvab ainult k]ik mehed linnade kaupa
select Gender, City, SUM(CAST(Salary as int)) as [Total Salary],
COUNT (Id) as [Total Employee(s)]
from Employees
where Gender = 'Male'
group by Gender, City

--kuvab ainult k]ik naised linnade kaupa
select Gender, City, SUM(CAST(Salary as int)) as [Total Salary],
COUNT (Id) as [Total Employee(s)]
from Employees
group by Gender, City
having Gender = 'Female'

--- annab errori
select * from Employees where SUM(CAST(Salary as int)) > 4000

select Gender, City, SUM(CAST(Salary as int)) as TotalSalary,
COUNT (Id) as TotalEmployees
from Employees group by Gender, City
having SUM(CAST(Salary as int)) > 4000

--- inner join
-- kuvab neid, kellel on DepartmentName all olemas v''rtus
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id

-- left join
-- v]tab k]ik andmed Employee tabelist
select Name, Gender, Salary, DepartmentName
from Employees
left join Department  -- v]ib kasutada ka LEFT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

--- rigth join
-- v]tab k]ik v''rtused paremast tabelist
select Name, Gender, Salary, DepartmentName
from Employees
right join Department  -- v]ib kasutada ka RIGHT OUTER JOIN-i
on Employees.DepartmentId = Department.Id

--- outer join
--- kuvab k]ikide tabelite v''rtused [hte p'ringusse
select Name, Gender, Salary, DepartmentName
from Employees
full join Department -- v]ib kasutada ka FULL OUTER JOIN-i
on Employees.DepartmentId = Department.Id

-- cross join
select Name, Gender, Salary, DepartmentName
from Employees
cross join Department 

--inner join
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Department.Id = Employees.DepartmentId

--- n'itab k]iki neid kellel on Employees tabelis DepartmentName null
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Department.Id = Employees.DepartmentId
where Department.Id is null

--- n'itab k]iki neid kellel on Employees tabelis DepartmentName null
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Department.Id = Employees.DepartmentId
where Employees.DepartmentId is null

--- full join
--- m]lema tabeli mitte-kattuvate v''rtustega read kuvab v'lja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

--- teise variant
select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id
where Department.Id is null

--- kuidas saame Department tabelis oleva rea, kus on NULL
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null

--- full join
--- mõlema tabeli mitte-kattuvate väärtustega read kuvab välja
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id
where Employees.DepartmentId is null
or Department.Id is null

select * from Department

-- saame muuta tabeli nimetust, alguses vana tabeli nimi ja siis uus soovitud
sp_rename 'Deparmtent1' , 'Department'

--- kasutame Employees tabeli asemel lühendit E ja M
select E.Name as Employee, M.Name as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

alter table Employees
add ManagerId int

--- inner join
--- kuvab ainult ManagerId all olevate isikute väärtuseid
select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--- kõik saavad kõikide ülemused olla
select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M



select isnull('Ingvar', 'No Manager') as Manager

--- NULL asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

--- kui Expression on õige, siis paneb v''rtuse, mida sovid või mõne teise väärtuse
case when Expression Then '' else '' end

--- neil kellel ei ole ülemust, siis paneb neile No Manager teksti
select  E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id


--- teeme p'ringu, kus kasutame case-i
select E.Name as Employee, case when M.Name is null then 'No Manager' 
else M.Name end as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

-- lisame tabelisse uued veerud
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)

select * from Employees

-- muudame ja lisame andmeid
update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1

update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2

update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3

update Employees
set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5

update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6

update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7

update Employees
set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8

update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9

update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

select * from Employees

-- igast reast v]tab esimesena t'idetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees


--- loome kaks tabelit
create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25)
)

--- sisestame tabelisse andmeid
insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com')
insert into IndianCustomers (Name, Email)
values ('Sam', 'S@S.com')

insert into UKCustomers (Name, Email)
values ('Ben', 'B@B.com')
insert into UKCustomers (Name, Email)
values ('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers


--- kasutame union all, näitab kõiki ridu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

--- korduvate väärtustega read pannakse ühte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers

--- kuidas tulemust sorteerida nime järgi
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
order by Name


--- stored procedure
create procedure spGetEmployees
as begin
	select FirstName, Gender from Employees
end

--- nüüd saab kasutada selle nimelist sp-d
spGetEmployees
exec spGetEmployees
execute spGetEmployees

select * from Employees


create proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

-- kui nüüd allolevat käsklust käima panna, siis nõuab Gender parameetrit
spGetEmployeesByGenderAndDepartment
--- õige variant
spGetEmployeesByGenderAndDepartment 'Male', 1

--- niimoodi saab sp tahetud järjekorrast mööda minna, kui ise paned muutujad paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--- saab sp sisu vaadata result vaates
sp_helptext spGetEmployeesByGenderAndDepartment


--- 3 tund


-- kuidas muuta sp-d ja võti peale, et keegi teine peale teie ei saaks muuta
alter proc spGetEmployeesByGenderAndDepartment
@Gender nvarchar(20),
@DepartmentId int
with encryption -- paneb võtme peale
as begin
	select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
	and DepartmentId = @DepartmentId
end

select * from Employees


-- sp tegemine

create proc spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int output
as begin
	select @EmployeeCount = count(Id) from Employees where Gender = @Gender
end

--- annab tulemuse, kus loendab ära nõuetele vastavad read
--- prindib ka tulemuse kirja teel
declare @TotalCount int
execute spGetEmployeeCountByGender 'asd', @TotalCount out
if(@TotalCount = 0)
	print '@TotalCount is null'
else
	print '@Total is not null'
print @TotalCount

select * from Employees

--- näitab ära, et mitu rida vastab nõuetele
declare @TotalCount int
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Male'
print @TotalCount

--- sp sisu vaatamine
sp_help spGetEmployeeCountByGender
--- tabeli info
sp_help Employees
-- kui soovid sp teksti näha
sp_helptext spGetEmployeeCountByGender

--- vaatame, millest sõltub see sp
sp_depends spGetEmployeeCountByGender
--- vaatame tabelit
sp_depends Employees

---
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Name = Id, @Name = FirstName from Employees
end

--- annab kogu tabeli ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end

--- saame teada, et mitu rida andmeid on tabelis
Declare @TotalEmployees int
Execute spTotalCount2 @TotalEmployees Output
Select @TotalEmployees

--- mis id all on keegi nime järgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(50) output
as begin
	select @FirstName = FirstName from Employees where Id = @Id
end
--- annab tulemuse, kus id 1 real on keegi koos nimega
declare @FirstName nvarchar(50)
execute spGetNameById1 1, @FirstName output
print 'Name of the employee = ' + @FirstName

---
declare 
@FirstName nvarchar(20)
execute spGetNameById 1, @FirstName out
print 'Name = ' + @FirstName

sp_help spGetNameById

---
create proc spGetNameById2
@Id int
as begin
	return (select FirstName from Employees where Id = @Id)
end

-- tuleb veateade kuna kutsusime välja int-i, aga Tom on string
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName



---- sisseehitatud string funktsioonid
--- see konverteerib ASCII tähe väärtuse numbriks
select ascii('a')
-- kuvab A-tähe
select char (65)

--- prindime kogu t'hestiku välja
declare @Start int
set @Start = 97
WHILE (@Start <= 122)
begin
	select char (@Start)
	set @Start = @Start + 1
end

---- eemaldame tühjad kohad sulgudes
select ltrim('          Hello')

--- tühikute eemaldamine veerust
select ltrim(FirstName) as FirstName, MiddleName, LastName from Employees

select * from Employees

--- paremalt poolt tühjad stringid lõikab ära
select rtrim('     Hello                     ')

----keerab kooloni sees olevad andmed vastupidiseks
--- vastavalt upper ja lower-ga saan muuta märkide suurust
--- reverse funktsioon pöörab kõik ümber
select REVERSE(upper(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName),
rtrim(ltrim(FirstName)) + ' ' + MiddleName + '  ' + LastName as FullName
from Employees

--- näeb, mitu tähte on sõnal ja loeb tyhikud sisse
select FirstName, len(FirstName) as [Total Characters] from Employees
--- näeb, mitu tähte on sõnal ja ei loe tyhikuid sisse
select FirstName, len(ltrim(FirstName)) as [Total Characters] from Employees


--- left, right, substring
-- vasakult poolt neli esimest tähte
select left('ABCDEF', 4)
--- paremalt poolt kolm tähte
select right('ABCDEF', 3)

--- kuvab @-tähemärgi asetust
select charindex('@', 'sara@aaa.com')

--- esimene nr peale komakohta näitab, et mitmendast alustab  ja siis mitu nr peale seda kuvada
select substring('pam@bbb.com', 5, 2)


--- @-märgist kuvab kolm tähemärki. Viimase nr saab määrata pikkust
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 1, 3)

--- peale @-m'rki reguleerin tähemärkide pikkuse näitamist
select substring('pam@bbb.com', charindex('@', 'pam@bbb.com') + 2,
len('pam@bbb.com') - charindex('@', 'pam@bbb.com'))

--- saame teada domeeninimed emailides
select substring (Email, charindex( '@', Email) + 1,
len (Email) - charindex('@', Email)) as EmailDomain
from Employees

select * from Employees

alter table Employees
add Email nvarchar(20)

update Employees set Email = 'Tom@aaa.com' where Id = 1
update Employees set Email = 'Pam@bbb.com' where Id = 2
update Employees set Email = 'John@aaa.com' where Id = 3
update Employees set Email = 'Sam@bbb.com' where Id = 4
update Employees set Email = 'Todd@bbb.com' where Id = 5
update Employees set Email = 'Ben@ccc.com' where Id = 6
update Employees set Email = 'Sara@ccc.com' where Id = 7
update Employees set Email = 'Valarie@aaa.com' where Id = 8
update Employees set Email = 'James@bbb.com' where Id = 9
update Employees set Email = 'Russel@bbb.com' where Id = 10

select * from Employees

---lisame *-märgiga teatud kohast
select FirstName, LastName,
	substring(Email, 1, 2) + replicate('*', 5) + -- peale teist tähemärki paneb viis t'rni
	substring(Email, charindex('@', Email), len(Email) - charindex('@', Email)+1) as Email --kuni @-märgini e on dünaamiline
from Employees

--- kolm korda näitab stringis olevat v''rtust
select replicate('asd', 3)

-- kuidas sisestada tyhikut kahe nime vahele
select space(5)

-- tühikute arv ahe nime vahel
select FirstName + space(25) + LastName as FullName
from Employees

---PATINDEX
--- sama, mis CHARINDEX, aga dünaamilisem ja saab kasutada wildcardi
select Email, PATINDEX('%@aaa.com', Email) as FirstOccurence
from Employees
where PATINDEX('%@aaa.com', Email) > 0 --- leian kõik selle domeeni esindajad ja 
--- alates mitmendast m'rgist algab @

--- kõik .com-d asendatakse .net-ga
select Email, replace(Email, '.com', '.net') as ConvertedEamil
from Employees

---- soovin asendada peale esimest m'rki kolm tähte viie tärniga
select FirstName, LastName, Email,
	stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees


---
create table DateTime
(
c_time time,
c_date date,
c_smalldatetime smalldatetime,
c_datetime datetime,
c_datetime2 datetime2,
c_datetimeoffset datetimeoffset
)

select * from DateTime

--konkreetse masina kellaaeg
select getdate(), 'GETDATE()'

--- 
insert into DateTime 
values (getdate(), getdate(), getdate(), getdate(), getdate(), getdate())


update DateTime set c_datetimeoffset = '2022-04-08 14:49:28.1933333 +10:00'
where c_datetimeoffset = '2022-04-08 14:49:28.1933333 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' --- aja päring
select SYSDATETIME(), 'SYSDATETIME'  -- veel täpsem aja päring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --- täpne aeg koos ajalise nihkega UTC suhtes
select GETUTCDATE(), 'GETUTCDATE' ---UTC aeg

--- 4 tund SQL

select ISDATE('asd') --tagastab 0 kuna string ei ole date
select ISDATE(getdate()) -- tagastab 1 kuna on kp
select ISDATE('2022-04-08 14:49:28.1933333') --- tagastab 0 kuna max kolm komakohta võib olla
select ISDATE('2022-04-08 14:49:28.193') -- tagastab 1
select DAY(GETDATE()) -- annab tänase päeva nr
select DAY('01/31/2017') -- annab stringis oleva kp ja järjestus peab olema õige
select Month(GETDATE()) --annab jooksva kuu nr
select Month('03/31/2017') -- annab stringis oleva kuu
select Year(GETDATE()) -- annab jooksva aasta nr
select Year('01/31/2017') -- annab stringis oleva aasta nr

select datename(day, '2022-04-08 14:49:28.193') -- annab stringis oleva päeva nr
select datename(WEEKDAY, '2022-04-08 14:49:28.193') -- annab stringis oleva päeva sõnana
select datename(MONTH, '2022-04-08 14:49:28.193') -- ananb stringis oleva kuu sõnana

create table EmployeesWithDates
(
	Id nvarchar(2),
	Name nvarchar(20),
	DateOfBirth datetime
)

INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (1, 'Sam', '1980-12-30 00:00:00.000');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (2, 'Pam', '1982-09-01 12:02:36.260');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (3, 'John', '1985-08-22 12:03:30.370');
INSERT INTO EmployeesWithDates  (Id, Name, DateOfBirth)  
VALUES (4, 'Sara', '1979-11-29 12:59:30.670');

--- kuidas võtta ühest veerust andmeid ja selle abil luua uued veerud
select	Name, DateOfBirth, DATENAME(WEEKDAY, DateOfBirth) as [Day],  ---vt DoB veerust päeva ja kuvab päeva nimetuse sõnana
		MONTH(DateOfBirth) as MonthNumber,  ---vt DoB veerust kp-d ja kuvab kuu nr
		DateName(Month, DateOfBirth) as [MonthName],  ---vt DoB veerust kuud ja kuvab sõnana
		Year(DateOfBirth) as [Year] -- võtab DoB veerust aasta
from EmployeesWithDates

create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
	declare @tempdate datetime, @years int, @months int, @days int
		select @tempdate = @DOB

		select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(getdate())) or (month(@DOB) 
		= month(getdate()) and day(@DOB) > day(getdate())) then 1 else 0 end
		select @tempdate = dateadd(year, @Years, @tempdate)

		select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate()) then 1 else 0 end
		select @tempdate = dateadd(MONTH, @months, @tempdate)

		select @days = datediff(day, @tempdate, getdate())

	declare @Age nvarchar(50)
		set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2)) + ' Months ' + cast(@days as nvarchar(2)) +
		' Days old'
	return @Age
end

-- saame vaadata kasutajate vanust 
select Id, Name, DateofBirth, dbo.fnComputeAge(DateOfBirth) as Age from EmployeesWithDates

-- kui kasutame seda funktsiooni, siis saame teada t'nase päeva vahet stringis välja tooduga
select dbo.fnComputeAge('11/11/2010')

-- nr peale DOB muutujat näitab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 126) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] from EmployeesWithDates

select cast(getdate() as date) -- tänane kp
select convert(date, getdate()) -- tänane kp

--- matemaatilised funktsioonid

select abs(-101.5) ---abs on absoluutne nr ja tulemuseks saame ilma miinus m'rgita tulemuse
select ceiling(15.2)  ---tagastab 16 ja suurendab suurema täisarvu suunas
select ceiling(-15.2)  ---tagastab -15 ja suurendab suurema positiivse täisarvu suunas
select floor(15.2) --- ümardab negatiivsema nr poole
select floor(-15.2) --- ümardab negatiivsema nr poole
select power(2, 4) -- hakkab korrutama 2x2x2x2, esimene nr on korrutatav
select SQUARE(9) -- antud juhul 9 ruudus
select sqrt(81) -- annab vastuse 9, ruutjuur

select rand() -- annab suvalise nr
select floor (rand() * 100) -- korrutab sajaga iga suvalise nr

--- iga kord näitab 10 suvalist nr-t
declare @counter int
set @counter = 1
while (@counter <= 10)
	begin
		print floor(rand() * 1000)
		set @counter = @counter + 1
end

select ROUND(850.556, 2) -- ümardab kaks kohta peale komat, tulemus 850.560
select ROUND(850.556, 2, 1) -- ümardab allapoole, tulemus 850.550
select ROUND(850.556, 1) -- ümardab ülespoole ja võtab ainult esimest nr peale koma arvesse 850.600 
select ROUND(850.556, 1, 1) -- ümardab allapoole
select ROUND(850.556, -2) -- ümardab täisnr ülesse
select ROUND(850.556, -1) -- ümardab täisnr allapoole


---
create function dbo.CalculateAge (@DOB date)
returns int
as begin
declare @Age int

set @Age = datediff(year, @DOB, GETDATE()) - 
	case
		when (month(@DOB) > month(getdate())) or
			 (month(@DOB) > month(getdate()) and day(@DOB) > day(getdate()))
		then 1
		else 0
		end
	return @Age
end

execute CalculateAge '10/08/2020'

-- arvutab välja, kui vana on isik ja võtab arvesse kuud ja päevad
-- antud juhul näitab kõike, kes on üle 36 a vanad
select Id, dbo.CalculateAge(DateOfBirth) as Age from Employees
where dbo.CalculateAge(DateOfBirth) > 36


--- inline table valued functions

alter table EmployeesWithDates
add DepartmentId int
alter table EmployeesWithDates
add Gender nvarchar(10)

select * from EmployeesWithDates

update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 1
update EmployeesWithDates set Gender = 'Female', DepartmentId = 2
where Id = 2
update EmployeesWithDates set Gender = 'Male', DepartmentId = 1
where Id = 3
update EmployeesWithDates set Gender = 'Female', DepartmentId = 3
where Id = 4
insert into EmployeesWithDates (Id, Name, DateOfBirth, DepartmentId, Gender)
values (5, 'Todd', '1978-11-29 12:59:30.670', 1, 'Male')


-- scalare function annab mingis vahemikus olevaid andmeid, aga
-- inline table values ei kasuta begin ja end funktsioone
-- scalar annab väärtused ja inline annab tabeli 
create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as
return (select Id, Name, DateOfBirth, DepartmentId, Gender
		from EmployeesWithDates
		where Gender = @Gender)

-- kõik female töötajad
select * from fn_EmployeesByGender('Female')

select * from fn_EmployeesByGender('Female')
where Name = 'Pam'  --- where abil saab otsingut täpsustada

select * from Department

--- kahest erinevast tabelist andmete võtmine ja koos kuvamine
--- esimene on funktsioon ja teine tabel
select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D on D.Id = E.DepartmentId

--- multi-table statment

-- inline funktsioon
create function fn_GetEmployees()
returns table as
return (Select Id, Name, cast(DateOfBirth as date)
		   as DOB
		   from EmployeesWithDates)


select * from fn_GetEmployees()

-- multi-state puhul peab defineerima uue tabeli veerud koos muutujatega
create function fn_MS_GetEmployees()
returns @Table Table (Id int, Name nvarchar(20), DOB date)
as begin
	insert into @Table
	select Id, Name, Cast(DateOfBirth as date) from EmployeesWithDates

	return
end

select * from fn_MS_GetEmployees()

--- inline tabeli funktsioonid on paremini töötamas kuna käsitletakse vaatena
--- multi puhul on pm tegemist stored proceduriga ja kulutab ressurssi rohkem

update fn_GetEmployees() set Name = 'Sam1' where Id = 1  -- saab muuta andmeid
update fn_MS_GetEmployees() set Name = 'Sam 1' where Id = 1  -- ei saa muuta andmeid multistate puhul


-- deterministic ja non-deterministic

select count(*) from EmployeesWithDates
select SQUARE(3) -- kõik tehtemärgid on deterministic funktsioonid, sinna kuuluvad veel sum, avg, square

-- non-deterministic
select getdate()
select CURRENT_TIMESTAMP
select rand() --see funktsioon saab olla mõlemas kategoorias, kõik oleneb sellest, kas sulgudes on 1 või ei ole

-- loome funktsiooni
create function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

select dbo.fn_GetNameById(4)

drop table EmployeesWithDates

create table EmployeesWithDates
(
	Id int primary key,
	Name nvarchar(50) NULL,
	DateOfBirth datetime NULL,
	Gender nvarchar(10) NULL,
	DepartmentId int NULL
)

insert into EmployeesWithDates values(1, 'Sam', '1980-12-30 00:00:00.000', 'Male', 1)
insert into EmployeesWithDates values(2, 'Pam', '1982-09-01 12:02:36.260', 'Female', 2)
insert into EmployeesWithDates values(3, 'John', '1985-08-22 12:03:30.370', 'Male', 1)
insert into EmployeesWithDates values(4, 'Sara', '1979-11-29 12:59:30.670', 'Female', 3)
insert into EmployeesWithDates values(5, 'Todd', '1978-11-29 12:59:30.670', 'Male', 1)


create function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

sp_helptext fn_GetEmployeeNameById

-- peale seda ei näe funktsiooni sisu
alter function fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with encryption
as begin
	return (select Name from EmployeesWithDates where Id = @Id)
end

--- muudame ülevalpool olevat funktsiooni, kindlasti tabeli ette panna dbo.TabeliNimi
alter function dbo.fn_GetEmployeeNameById(@Id int)
returns nvarchar(20)
with schemabinding
as begin
	return (select Name from dbo.EmployeesWithDates where Id = @Id)
end

-- ei saa kustutada tabelid ilma funktsiooni kustutamata
drop table dbo.EmployeesWithDates

--- 5 tund

--- temporary tables

--- #-märgi ette panemisel saame aru, et tegemist on temp table-ga
--- seda tabelit saab ainult selles päringus avada
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails

select Name from sysobjects
where Name like '#PersonDetails%'

--- kustuta temp table
drop table #PersonDetails


create proc spCreateLocalTempTable
as begin
create table #PersonDetails(Id int, Name nvarchar(20))

insert into #PersonDetails values(1, 'Mike')
insert into #PersonDetails values(2, 'John')
insert into #PersonDetails values(3, 'Todd')

select * from #PersonDetails
end

exec spCreateLocalTempTable

--- globaalse temp table tegemine
create table ##PersonDetails(Id int, Name nvarchar(20))


---index
create table EmployeeWithSalary
(
Id int primary key,
Name nvarchar(25),
Salary int,
Gender nvarchar(10)
)

insert into EmployeeWithSalary values(1, 'Sam', 2500, 'Male')
insert into EmployeeWithSalary values(2, 'Pam', 6500, 'Female')
insert into EmployeeWithSalary values(3, 'John', 4500, 'Male')
insert into EmployeeWithSalary values(4, 'Sara', 5500, 'Female')
insert into EmployeeWithSalary values(5, 'Todd', 3100, 'Male')

select * from EmployeeWithSalary

select * from EmployeeWithSalary
where Salary > 5000 and Salary < 7000

--- loome indeksi, mis asetab palga kahanevasse järjestusse
create index IX_Employee_Salary
on EmployeeWithSalary (Salary asc)

--- saame teada, et mis selle tabli primaarvõti ja index
EXEC sys.sp_helpindex @objname = 'EmployeeWithSalary'


-- saame vaadata tabelit koos selle sisuga alates väga detialisest infost
SELECT 
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name,
     ind.*,
     ic.*,
     col.* 
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
     ind.is_primary_key = 0 
     AND ind.is_unique = 0 
     AND ind.is_unique_constraint = 0 
     AND t.is_ms_shipped = 0 
ORDER BY 
     t.name, ind.name, ind.index_id, ic.is_included_column, ic.key_ordinal;

--- indeksi kustutamine
drop index EmployeeWithSalary.IX_Employee_Salary


---- indeksi tüübid:
--1. Klastrites olevad
--2. Mitte-klastris olevad
--3. Unikaalsed
--4. Filtreeritud
--5. XML
--6. Täistekst
--7. Ruumiline
--8. Veerusäilitav
--9. Veergude indeksid
--10. Välja arvatud veergudega indeksid

-- klastris olev indeks määrab ära tabelis oleva füüsilise järjestuse 
-- ja selle tulemusel saab tabelis olla ainult üks klastris olev indeks

drop table EmployeeWithSalary

create table EmployeeCity
(
Id int primary key,
Name nvarchar(50),
Salary int,
Gender nvarchar(10),
City nvarchar(50)
)


exec sp_helpindex EmployeeCity

-- andmete õige järjestuse loovad klastris olevad indeksid ja kasutab selleks Id nr-t
-- põhjus, miks antud juhul kasutab Id-d, tuleneb primaarvõtmest
insert into EmployeeCity values(3, 'John', 4500, 'Male', 'New York')
insert into EmployeeCity values(1, 'Sam', 2500, 'Male', 'London')
insert into EmployeeCity values(4, 'Sara', 5500, 'Female', 'Tokyo')
insert into EmployeeCity values(5, 'Todd', 3100, 'Male', 'Toronto')
insert into EmployeeCity values(2, 'Pam', 6500, 'Male', 'Sydney')

-- klastris olevad indeksid dikteerivad säilitatud andmete järjestuse tabelis 
-- ja seda saab klastrite puhul olla ainult üks

select * from EmployeeCity

create clustered index IX_EmployeeCity_Name
on EmployeeCity(Name)

--- annab veateate, et tabelis saab olla ainult üks klastris olev indeks
--- kui soovid, uut indeksit luua, siis kustuta olemasolev

--- saame luua ainult ühe klastris oleva indeksi tabeli peale
--- klastris olev indeks on analoogne telefoni suunakoodile

-- loome composite indeksi
-- enne tuleb kõik teised klastris olevad indeksid ära kustutada

create clustered index IX_Employee_Gender_Salary
on EmployeeCity(Gender desc, Salary asc)
-- kui teed select päringu sellele tabelile, siis peaksid nägema andmeid, mis on järjestatud selliselt:
-- Esimeseks võetakse aluseks Gender veerg kahanevas järjestuses ja siis Salary veerg tõusvas järjestuses

select * from EmployeeCity

--- mitte klastirs olev indeks
create nonclustered index IX_EmployeeCity_Name
on EmployeeCity(Name)
-- teeme päringu tabelile
select * from EmployeeCity

--- erinevused kahe indeksi vahel
--- 1. ainult üks klastris olev indeks saab olla tabeli peale, 
--- mitte-klastris olevaid indekseid saab olla mitu
--- 2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi viitama tabelile
--- Juhul, kui selekteeritud veerg ei ole olemas indeksis
--- 3. Klastris olev indeks määratleb ära tabeli ridade slavestusjärjestuse
--- ja ei nõua kettal lisa ruumi. Samas mitte klastris olevad indeksid on 
--- salvestatud tabelist eraldi ja nõuab lisa ruumi


create table EmployeeFirstName
(
	Id int primary key,
	FirstName nvarchar(50),
	LastName nvarchar(50),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName

--- ei saa sisestada kahte samasuguse Id väärtusega rida
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

---
drop index EmployeeFirstName.PK__Employee__3214EC0769D3038B
--- kui käivitad ülevalpool oleva koodi, siis tuleb veateade
--- et SQL server kasutab UNIQUE indeksit jõustamaks väärtuste unikaalsust ja primaarvõtit
--- koodiga Unikaalseid Indekseid ei saa kustutada, aga käsitsi saab

-- sisestame uuesti kaks koodirida andmeid
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'John', 'Menco', 2500, 'Male', 'London')

--- unikaalset indeksid kasutatakse kindlustamaks väärtuste unikaalsust (sh primaarvõtme oma)

-- mõlemat tüüpi indeksid saavad olla unikaalsed

create unique nonclustered index UIX_Employee_Firstname_Lastname
on EmployeeFirstName(FirstName, LastName)
-- alguses annab veateate, et Mike Sandoz-st on kaks korda
-- ei saa lisada mitte-klastris olevat indeksit, kui ei ole unikaalseid andmeid
--- kustutame tabeli ja sisestame andmed uuesti

insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(2, 'John', 'Menco', 2500, 'Male', 'London')

--- lisame uue unikaalse piirnagu
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstName_City
unique nonclustered(City)

--- ei luba tabelisse väärtusega uut Londonit
insert into EmployeeFirstName values(3, 'John', 'Menco', 3500, 'Male', 'London')

-- saab vaadata indeksite nimekirja
exec sp_helpconstraint EmployeeFirstName

---
-- 1.Vaikimisi primaarvõti loob unikaalse klastris oleva indeksi, samas unikaalne piirang
-- loob unikaalse mitte-klastris oleva indeksi
-- 2. Unikaalset indeksit või piirangut ei saa luua olemasolevasse tabelisse, kui tabel 
-- juba sisaldab väärtusi võtmeveerus
-- 3. Vaikimisi korduvaid väärtusied ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks või piirang. Nt, kui tahad sisestada 10 rida andmeid,
-- millest 5 sisaldavad korduviad andmeid, siis kõik 10 lükatakse tagasi. Kui soovin ainult 5
-- rea tagasi lükkamist ja ülejäänud 5 rea sisestamist, siis selleks kasutatakse IGNORE_DUP_KEY

--koodinäide:
create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

insert into EmployeeFirstName values(3, 'John', 'Menco', 3512, 'Male', 'London')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3123, 'Male', 'London1')
insert into EmployeeFirstName values(4, 'John', 'Menco', 3220, 'Male', 'London1')
--- enne ignore käsku oleks kõik kolm rida tagasi lükatud, aga
--- nüüd läks keskmine rida läbi kuna linna nimi oli unikaalne

select * from EmployeeFirstName

--- view

--- view on salvestatud SQL-i päring. Saab käsitleda ka virtuaalse tabelina

select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

select FirstName, Salary, Gender, DepartmentId
from Employees

-- loome view
create view vEmployeesByDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

--- view päringu esile kutsumine
select * from vEmployeesByDepartment

-- view ei salvesta andmeid vaikimisi
-- seda tasub võtta, kui salvestatud virtuaalse tabelina

-- milleks vaja:
-- saab kasutada andmebaasi skeemi keerukuse lihtsutamiseks,
-- mitte IT-inimesele
-- piiratud ligipääs andmetele, ei näe kõiki veerge

-- teeme veeru, kus näeb ainult IT-töötajaid
create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id
where Department.DepartmentName = 'IT'
-- ülevalpool olevat päringut saab liigitada reataseme turvalisuse alla
-- tahan ainult näidata IT osakonna töötajaid

select * from vITEmployeesInDepartment

-- veeru taseme turvalisus
-- peale selecti määratled veergude näitamise ära
create view vEmployeesInDepartmentSalaryNoShow
as
select FirstName, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

select * from vEmployeesInDepartmentSalaryNoShow


---saab kasutada esitlemaks koondandmeid ja üksikasjalike andmeid
-- view, mis tagastab summeeritud andmeid
create view vEmployeesCountByDepartment
as
select DepartmentName, count(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.Id
group by DepartmentName

select * from vEmployeesCountByDepartment

-- kui soovid vaadata view sisu
sp_helptext vEmployeesCountByDepartment
-- muuta
alter view vEmployeesCountByDepartment
-- kustutada
drop view vEmployeesCountByDepartment

--- view uuendused
-- kas läbi view saab uuendada andmeid

--- teeme andmete uuenduse, aga enne teeme view
update vEmployeesDataExceptSalary
set [FirstName] =  'Tom' where Id = 2

create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees

---
-- kustutame ja sisestame andmeid
delete from vEmployeesDataExceptSalary where Id = 2
insert into vEmployeesDataExceptSalary (Id, Gender, DepartmentId, FirstName)
values(2, 'Female', 2, 'Pam') 


select * from Employees


--- indekseeritud view
-- MS SQL-s on indekseeritud view nime all ja 
-- Oracle-s materjaliseeritud view

create table Product
(
Id int primary key,
Name nvarchar(20),
UnitPrice int
)

insert into Product values (1, 'Books', 20)
insert into Product values (2, 'Pens', 14)
insert into Product values (3, 'Pencils', 11)
insert into Product values (4, 'Clips', 10)

create table ProductSales
(
Id int,
QuantitySold int
)

insert into ProductSales values(1, 10)
insert into ProductSales values(3, 23)
insert into ProductSales values(4, 21)
insert into ProductSales values(2, 12)
insert into ProductSales values(1, 13)
insert into ProductSales values(3, 12)
insert into ProductSales values(4, 13)
insert into ProductSales values(1, 11)
insert into ProductSales values(2, 12)
insert into ProductSales values(1, 14)

-- loome view, mis annab meile veerud TotalSales ja TotalTransaction

create view vTotalSalesByProduct
with schemabinding
as 
select Name,
sum(isnull((QuantitySold * UnitPrice), 0)) as TotalSales,
count_big(*) as TotalTransactions
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = dbo.ProductSales.Id
group by Name

--- kui soovid luua indeksi view sisse, siis peab järgima teatud reegleid
-- 1. view tuleb luua koos schemabinding-ga
-- 2. kui lisafunktsioon select list viitab väljendile ja selle tulemuseks
-- võib olla NULL, siis asendusväärtus peaks olema täpsustatud. 
-- Antud juhul kasutasime ISNULL funktsiooni asendamaks NULL väärtust
-- 3. kui GroupBy on täpsustatud, siis view select list peab
-- sisaldama COUNT_BIG(*) väljendit
-- 4. Baastabelis peaksid view-d olema viidatud kahesosalie nimega
-- e antud juhul dbo.Product ja dbo.ProductSales.


select * from vTotalSalesByProduct

create unique clustered index UIX_vTotalSalesByProduct_Name
on vTotalSalesByProduct(Name)
-- paneb selle view tähestikulisse järjestusse

-- 6 SQL tund


--- view piirangud

create view vEmployeeDetails
@Gender nvarchar(20)
as
Select Id, FirstName, Gender, DepartmentId
from Employees
where Gender = @Gender

--- vaatesse ie saa kaasa panan parameetreid e antud juhul Gender

create function fnEmployeeDetails(@Gender nvarchar(20))
returns table
as return
(Select Id, FirstName, Gender, DepartmentId
from Employees where Gender = @Gender)

--funktsiooni esile kutsumine koos parameetriga
select * from fnEmployeeDetails('male')

--- order by kasutamine
create view vEmployeeDetailsSorted
as 
select Id, FirstName, Gender, DepartmentId
from Employees
order by Id

-- order by-d ei saa kasutada

--- temp table kasutamine

create table ##TestTempTable(Id int, FirstName nvarchar(20), Gender nvarchar(10))

insert into ##TestTempTable values(101, 'Martin', 'Male')
insert into ##TestTempTable values(102, 'Joe', 'Female')
insert into ##TestTempTable values(103, 'Pam', 'Female')
insert into ##TestTempTable values(104, 'James', 'Male')
-- sisestame andmed

create view vOnTempTable
as
select Id, FirstName, Gender
from ##TestTempTable

-- temp table-s ei saa kasutada view-d

--Trigger
-- kokku on kolme tüüpi triggereid: DML, DDL, LOGON

-- trigger on stored procedure eriliik, mis automaatselt käivitub, kui mingi 
-- tegevus peaks andmebaasis aset leidma

-- DML - data manipulation language
-- DML-i põhilised käsklused: insert, update ja delete

-- DML triggereid saab klasifitseerida kahte tüüpi:
-- 1. After trigger (kutsutakse ka FOR triggeriks)
-- 2. Instead of trigger (selmet trigger e selle asemel trigger)

-- after trigger käivitub peale sündmust, kui kuskil on tehtud insert, update ja delete

create database TARge22

create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)

create table Employee
(
Id int primary key,
Gender nvarchar(10),
Salary int,
DepartmentId int,
FirstName nvarchar(20),
MiddleName nvarchar(20),
LastName nvarchar(20),
Email nvarchar(30)
)

--- peale iga töötaja sisestamist tahame teada saada tötaja Id-d,
--- päeva ning aega(millal sisestati)
--- kõik andmed tulevad EmployeeAudit tabelisse

create trigger trEmployeeForInsert
on Employee
for insert
	as begin
		declare @Id int
		select @Id = Id from inserted
		insert into EmployeeAudit
		values ('New employee with Id = ' + CAST(@Id as nvarchar(5)) 
		+ ' is added at ' + CAST(GETDATE() as nvarchar(20)))
	end

insert into Employee 
values (1, 'Male', 3000, 1, 'Bob', 'Blob', 'Bomb', 'bob@bomb.com')

select * from EmployeeAudit

--- delete trigger
create trigger trEmployeeForDelete
on Employee
for delete
	as begin
		declare @Id int
		select @Id = Id from deleted
		insert into EmployeeAudit
		values ('An existing with Id = ' + CAST(@Id as nvarchar(5)) 
		+ ' is deleted at ' + CAST(GETDATE() as nvarchar(20)))
	end

delete from Employee where Id = 1
go --tee ülevalpool olevad protsessid enne ära ja siis mine edasi
select * from EmployeeAudit


--- update trigger
create trigger trEmployeeForUpdate
on Employee
for update
as begin
	--muutujate deklareerimine
	declare @Id int
	declare @OldGender nvarchar(10), @NewGender nvarchar(10)
	declare @OldSalary int, @NewSalary int
	declare @OldDepartmentId int, @NewDepartmentId int
	declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
	declare @OldMiddleName nvarchar(20), @NewMiddleName nvarchar(20)
	declare @OldLastName nvarchar(20), @NewLastName nvarchar(20)
	declare @OldEmail nvarchar(50), @NewEmail nvarchar(50)
	--- muutuja, kuhu l'heb l]pptekst
	declare @AuditString nvarchar(1000)
	-- laeb kõik andmed temp tabelisse
	select * into #TempTable from inserted

	-- käib läbi kõik andmed temp table-s
	while(exists(select Id from #TempTable))
	begin
		set @AuditString = ''
		--selekteerib esimese rea andmed temp tabelist
		select top 1 @Id = Id, @NewGender = Gender,
		@NewSalary = Salary, @NewDepartmentId = DepartmentId,
		@NewFirstName = FirstName, @NewMiddleName = MiddleName,
		@NewLastName = LastName, @NewEmail = Email
		from #TempTable
		-- võtab vanad andmed kustutatud tabelist
		select @OldGender = Gender,
		@OldSalary = Salary, @OldDepartmentId = DepartmentId,
		@OldFirstName = FirstName, @OldMiddleName = MiddleName,
		@OldLastName = LastName, @OldEmail = Email
		from deleted where Id = @Id

		--loob auditi stringi d[naamiliseks
		set @AuditString = 'Employee with Id = ' + CAST(@Id as nvarchar(4)) + ' changed '
		if(@OldGender <> @NewGender)
			set @AuditString = @AuditString + ' Gender from ' + @OldGender + 
			' to ' + @NewGender

		if(@OldSalary <> @NewSalary)
			set @AuditString = @AuditString + ' Salary from ' + cast(@OldSalary as nvarchar(20)) + 
			' to ' + cast(@NewSalary as nvarchar(20))

		if(@OldDepartmentId <> @NewDepartmentId)
			set @AuditString = @AuditString + ' DepartmentId from ' + cast(@OldDepartmentId as nvarchar(20)) + 
			' to ' + cast(@NewDepartmentId as nvarchar(20))

		if(@OldFirstName <> @NewFirstName)
			set @AuditString = @AuditString + ' FirstName from ' + @OldFirstName + 
			' to ' + @NewFirstName

		if(@OldMiddleName <> @NewMiddleName)
			set @AuditString = @AuditString + ' MiddleName from ' + @OldMiddleName + 
			' to ' + @NewMiddleName

		if(@OldLastName <> @NewLastName)
			set @AuditString = @AuditString + ' LastName from ' + @OldLastName + 
			' to ' + @NewLastName

		if(@OldEmail <> @NewEmail)
			set @AuditString = @AuditString + ' Email from ' + @OldEmail + 
			' to ' + @NewEmail

		insert into dbo.EmployeeAudit values (@AuditString)
		--- kustutab temp tabelist rea, et saaksime liikuda uue rea juurde
		delete from #TempTable where Id = @Id
	end
end

update Employee set FirstName = 'test123', Salary = 3500
where Id = 1
go
select * from EmployeeAudit


create table Department
(
Id int primary key,
DepartmentName nvarchar(20)
)

truncate table Employee

insert into Employee values 
(1, 'Male', 3000, 3, 'John', 'Travolta', 'Amolta', 'john@john.com'),
(2, 'Male', 3500, 2, 'Mike', '', 'Mendes', 'mike@mike.com'),
(3, 'Female', 4000, 1, 'Pam', 'Sam', 'Anderson', 'pam@pam.com'),
(4, 'Female', 5000, 1, 'Sara', 'Ann', 'Connor', 'sara@sara.com'),
(5, 'Male', 2000, 3, 'Ben', 'Zen', 'Ten', 'ben@ben.com'),
(6, 'Male', 3200, 4, 'Todd', 'Alex', 'Mode', 'todd@todd.com')

create view vEmployeeDetails
as
select Employee.Id, FirstName, Gender, DepartmentName
from Employee
join Department
on Employee.DepartmentId = Department.Id

select * from vEmployeeDetails

--- 25.04.2023  r1736