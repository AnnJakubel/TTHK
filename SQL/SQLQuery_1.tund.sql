-- tabeli loomine 
use TARge22

-- andmete sisestamine tabelisse
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (3, 'Unknown')

-- vaatame tabeli sisu
select * from Gender

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

select * from Person

-- võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ole sisestanud GenderID alla väärtust
-- siis see automaatselt sisestab sellele reale väärtuse 3
alter table Person 
add constraint DF_Persons_GenderID
default 3 for GenderId

insert into Person (Id, Name, Email)
values (11, 'asdasd', 'asd@asd.com')

select * from Person

-- piirangu maha võtmine
alter table Person
drop constraint DF_Persons_GenderId

-- lisame uue veeru juurde
alter table Person
add Age nvarchar(10)

-- lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--andmete uuendamine
update Person
set Age = 40
where Id = 1

update Person
set Age = 120
where Id = 2

update Person
set Age = 30
where Id = 3

update Person
set Age = 25
where Id = 4

update Person
set Age = 28
where Id = 5

update Person
set Age = 50
where Id = 6

insert into Person (Id, Name, Email, GenderId, Age)
values (7, 'Robin', 'r@2.com', 2, 21)

insert into Person (Id, Name, Email, GenderId, Age)
values (9, 'Thor', 't@t.com', 2, 35)

insert into Person (Id, Name, Email, GenderId, Age)
values (10, 'Ironman', 'i@iron.com', 2, 45)

--lisame veeru juurde
alter table Person
add City nvarchar(50)

select * from Person

-- kõik,kes elavad Gothami linnas
select * from Person where City = 'Gotham'
--kõik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
-- kõik,kes ei ela Gothamis, teine variant
select * from Person where City <> 'Gotham'

--näitab teatud vanusega inimese
select * from Person where Age  = 120 or Age = 50 or Age = 28
select * from Person where Age in (120, 50, 28)

--näitab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 40 and 120

--wildcardi kasutamine näitab kõik n-tähega linnad ära
select * from Person where City like 'n%'
--email, illes on @ märk
select * from Person where Email like '%@%'

--n'itab kõiki kellel on emailis ees
-- ja peale @ märki ainult üks täht
select * from Person where Email like '_@_.com'

--kõik, kellel nimes ei ole esimene täht W, A ja C
select * from Person where Name like '[]'

--kes elavad Gothamis ja New Yorkis nin on vanemad kui 27
select * from Person where (City = 'Gotham' or City = 'New York')
and Age >= 27

--järjestus nime alusel
select * from Person order by Name
--vastupidine järjestus
select * from Person order by Name desc

--võtab 3 esimest rida
select top 3 * from Person

--kolm esimest, aga tabeli järjestuses on Age ja siis Name
select top 3 Age, Name from Person

--kuvab esimesed 50% tabelist
select top 50 percent * from Person

--võtab 4 esimest ja järjestab vanuse järgi 
select top 4 * from Person order by Age desc

--muudab age muutuja int-iks ja n2itab
--vanuselises j2rjestuses
select * from Person order by CAST(Age as int)

--kuvab k6ige nooremat isikut
select MIN(CAST(Age as int)) from Person

--kuvab k6ige vanemat isikut
select MAX(CAST(Age as int)) from Person

--n2eme konkreetsetes linnades olevate isikute koondvanust 
--(ehk kokku liidetud)
select City, SUM(Age) as TotalAge from Person group by City

--muudame koodiga andmetyypi ja selle pikkust
alter table Person
alter column Name nvarchar(25)

--kuvab esimeses reas v2lja toodud j2rjestuses
--ja kuvab Age-i TotalAge-iks
--j2rjestab Citys olevate nimede j2rgi ja siis GenderId j2rgi
select City, GenderId, SUM(Age) as TotalAge from Person
group by City, GenderId order by City

--n2itab, mitu rida selles tabelis
select COUNT(*) from Person

--n2itab tulemust, et mitu iimest on GenderId v22rtusega 2
--konkreetses linnas
--Arvutab vanuse kokku
select GenderId, City, SUM(Age) as TotalAge, COUNT(Id)
as [Total Person(s)] from Person
where GenderId = '2'
group by GenderId, City

--n2itab 2ra, et mitu inimest on koondvanusena vanemad kui 41
-- ja kui palju igas linnas elab
select GenderId, City, SUM(Age) as TotalAge, COUNT(Id)
as [Total Person(s)] from Person
group by GenderId, City having SUM(Age) > 41