create view vEmployeeDetails

select * from vEmp

INSERT INTO vEmployeeDetails
values(7, 'Female', 5100, 2, 'Valarie','', 'Smith', 'valarie@smith.com')
-- tuleb veateade
--nyyd vaatame, et kuidas saab instead of triggeriga seda
--probleemi lahendada

create trigger tr_vEmployeeDetails_InsteadOfInsert
on vEmployeeDetails
instead of insert
as begin
	declare @DeptId int
	
	select@DeptId = dbo.Department.Id
	from Department
	join inserted
	on inserted DepartmentName = Department.DepartmentName

	if(@DeptId is null)
		begin
		raiseerror('Invalid department name. Statement terminated', 16, 1)
		return
	end

	insert into dbo.Employee2(Id, FirstName, Gender, DepartmentId)