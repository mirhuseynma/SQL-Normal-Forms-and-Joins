create database [Order]
use [Order]

create table [Tables]
(
	ID int primary key identity,
	[No] int
)

create table Meals
(
	ID int primary key identity,
	[Name] nvarchar(50),
	Price float 
)

create table Orders
(
	ID int primary key identity,
	MealsID int foreign key references Meals(ID),
	[TablesID] int foreign key references [Tables](ID),
	DateOrderCreated datetime
)



insert into [Tables] values (1)
insert into [Tables] values (2)
insert into [Tables] values (3)
insert into [Tables] values (4)
insert into [Tables] values (5)

insert into Meals values ('Pizza', 10.99)
insert into Meals values ('Burger', 7.99)
insert into Meals values ('Pasta', 8.99)
insert into Meals values ('Salad', 5.99)
insert into Meals values ('Sushi', 12.99)

-- insert into orders datetime should be in the format 'YYYY-MM-DD HH:MM:SS'
insert into Orders values (1, 1, '2024-09-01 12:10:00')
insert into Orders values (2, 2, '2024-09-01 12:30:00')
insert into Orders values (3, 3, '2024-09-01 13:25:00')
insert into Orders values (4, 4, '2024-09-01 13:30:00')
insert into Orders values (5, 5, '2024-09-01 14:00:00')
insert into Orders values (1, 2, '2024-09-01 14:30:00')
insert into Orders values (2, 3, '2024-09-01 15:05:00')
insert into Orders values (3, 4, '2024-09-01 15:30:00')
insert into Orders values (4, 5, '2024-09-01 16:40:00')
insert into Orders values (5, 1, '2024-09-01 17:00:00')

--1.
select t.No as TableNO,(select count(o.TablesID) from Orders o where o.TablesID = t.ID) as OrderCount from [Tables] t

--2.
select m.Name, (select count(o.MealsID) from Orders o where o.MealsID = m.ID) as MealsOrder from Meals m

--3.
select o.ID, m.Name from Orders o 
join Meals m on m.ID = o.MealsID
order by m.name asc

--4.
select o.ID as OrderNO, m.Name as Meal, t.No as TablesNo from Orders o 
join Meals m on m.ID = o.MealsID
join [Tables] t on t.ID = o.TablesID
order by m.name asc

--5.
select t.No as TableNo, sum(m.Price) as TotalOrderPrize from Orders o
join [Tables] t on t.ID = o.TablesID
join Meals m on m.ID = o.MealsID
group by t.No
order by t.No asc

SELECT SYSDATETIME();
SELECT DATEADD(DAY, 10, '2024-09-01');
SELECT DATEDIFF(DAY, '2024-09-01', '2024-09-10');

--6.
select t.No as TableNo, datediff(hour, min(o.DateOrderCreated),max(o.DateOrderCreated)) as OrderTimeRangeHour from Orders o
join [Tables] t on t.ID = o.TablesID
where t.No = 2
group by t.No

select o.DateOrderCreated from Orders o

--7.
select o.Id, o.DateOrderCreated as CreationDate from Orders o 
where o.DateOrderCreated < (select dateadd(minute, -30, max(o.DateOrderCreated)) from Orders o)

--8.
select t.No as TableNoOrder from Orders o
join [Tables] t on t.ID = o.TablesID
where o.MealsID is null or o.DateOrderCreated is null

--9.
select t.No from [Tables] t
join Orders o on o.TablesID = t.ID
where o.DateOrderCreated < (select dateadd(minute, -60, max(o.DateOrderCreated)) from Orders o) or o.MealsID is null or o.DateOrderCreated is null
group by t.No
