--- CTE ehk common table expression 

--- CTE
with EmployeeCount(DepartmentName, DepartmentId, TotalEmployees)
as
	(
	select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName, DepartmentId
	)
select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2

--- CTE-d v6ivad sarnaneda temp tablega
--- sarnane p2ritud tabelile ja ei ole salvestatud objektina
--- ning kestab p2ringu ulatuses

--- p2ritud tabel
select * DepartmentName, TotalEmployees
from
	(
	select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName, DepartmentId
	)
select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2


--- Mitu CTE-d j2rjest
with EmployeeCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
	(
	select DepartmentName, COUNT(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	where DepartmentName in('Payroll', 'IT')
	group by DepartmentName
	),
EmployeesCountBy_HR_Admin_Dept(DepartmentName, Total)
as
	(
	select DepartmentName, COUNT(Employee.Id) as TotalEmployees
	from Employee
	join Department
	on Employee.DepartmentId = Department.Id
	group by DepartmentName
	)
select * from EmployeesCountBy_HR_Admin_Dept
union
select * from EmployeeCountBy_Payroll_IT_Dept
--- kui on kaks CTE-d, siis unioni abil peab yhendama p2ringu

with EmployeeCount(DepartmentID, TotalEmployees)
as
(
	select DepartmentId, COUNT(*) as TotalEmployees
	from Employee
	group by DepartmentId
)
-- select 'Hello'  <- iga SELECT ka ei l2he
select DepartmentName, TotalEmployees
from Department
join EmployeeCount
on Department.Id = EmployeeCount.DepartmentId
order by TotalEmployees
--- Peale CTE-d peab kohe tulema k2sklus SELECT, INSERT, UPDATE v6i DELETE
--- kui proovid muud tuleb veateade

--- Uuendamine CTE-s
--- loome lihtsa CTE

with Employees_Name_Gender
as
(
	select Id, FirstName, Gender from Employee
)
select * from Employees_Name_Gender

--- uuendame andmeid l2bi CTE
with Employees_Name_Gender
as
(
	select Id, FirstNAme, Gender from Employee
)
update Employees_Name_Gender set Gender = 'Female' where Id = 1

select * from dbo.Employee

--- kasutame join-i CTE tegemisel
with EmployeesByDepartment
as
(
select Employee.Id, FirstName, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
select * from EmployeesByDepartment

-- kasutame joini ja muudame yhes tabelis andmeid
with EmployeesByDepartment
as
(
select Employee.Id, FirstName, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment set Gender = 'Male'  where Id = 1

--- kasutame joini ja muudame m6lemas andmeid
with EmployeesByDepartment
as
(
select Employee.Id, FirstName, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment set Gender = 'Male', DepartmentName = 'HR' 
where Id = 1
--- Ei luba korraga mitmes tabelis andmeid muuta

with EmployeesByDepartment
as
(
select Employee.Id, FirstName, Gender, DepartmentName
from Employee
join Department
on Department.Id = Employee.DepartmentId
)
update EmployeesByDepartment set DepartmentName = 'HR' 
where Id = 1

--- kokkuv6te CTE-st
--- 1.Kui CTE baseerub yhel tabelil, siis uuendus t66tab
--- 2.Kui CTE baseerib mitmel tabelil, siis tuleb veateade
--- 3.Kui CTE baseerub mitmel tabelil ja tahame muuta ainult yhte
---   tabelit, siis uuendus saab tehtud 
