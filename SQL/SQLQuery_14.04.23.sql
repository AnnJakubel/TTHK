--kasutame left joini kahe tabeli [hendamisel, antud juhul kuvab k6ik t66tajad
--olenemata, kas t66tajate tabelis on DepartmentId null v6i mitte

select Name, Gender, Salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--kasutame inner joini kahe tabeli yhendamisel, antud juhul kuvab k6ik t66tajad
--kellel on tabelis DepartmentId olemas v22rtus.
select Name, Gender, Salary, DepartmentName
from Employees
inner join Department
on Employees.DepartmentId = Department.Id


-- 6.tund

select * from Employees
select * from Gender


-- right join tagastab meile andmed m6lemast tabelist
-- ja mittekuuluvad andmed, mis antud juhul on Other Department
select Name, Gender, Salary, DepartmentName
from Employees
right join Department
on Employees.DepartmentId = Department.Id


-- tahan saada k]ik andmed m]lemast tabelist
-- ehk osakondadesse paigutatud t66tajad + osakonnad,
-- kus ei ole t66tajaid.
select Name, Gender, Salary, DepartmentName
from Employees
full join Department
on Employees.DepartmentId = Department.Id


-- Teeme p2ringu kahele tabelile, kus tahame n2ha neid t66tajaid, kelle osakonna all
-- on v22rtus NULL ehk tyhi, kasutame selles p2ringus lyhendeid
select Name, Gender, Salary, DepartmentName
from Employees E
left join Department D
on E.DepartmentId = D.Id
where D.Id is null

