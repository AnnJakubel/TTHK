create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)

create table Employee2
(
Id int primary key,
Gender nvarchar(10),
Salary int,
DepartmentId int,
FirstNAme nvarchar(20),
MiddleName nvarchar(20),
LastName nvarchar(20),
Email nvarchar(30)
)

-- peale iga t66taja sisestamist tahame teada saada t66taja Id-d,
-- p'eva ning aega(millal sisestati)
-- k6ik andmed tulevad EmployeeAudit tabelisse.

create trigger trEmployeeForInsert
on Employee2
for insert
	as begin
		declare @Id int
		select @Id = Id from inserted
		insert into EmployeeAudit
		values ('New employee with Id = ' + CAST(@Id as nvarchar(5)) + ' is added at '
		+ CAST(GETDATE() as nvarchar(20)))
	end

insert into Employee2
values (1, 'Male', 3000, 1, 'Bob', 'Blob', 'Bomb', 'bob@bomb.com')

--delete trigger
create trigger trEmployeeForDelete
on Employee2
for delete
	as begin
		declare @Id int
		select @Id = Id from deleted
		insert into EmployeeAudit
		values('New employee with Id = ' + CAST(@Id as nvarchar(5))
		+ ' is added at ' + CAST(GetDate() as nvarchar(20)))
	end
