create database IMDB
use IMDB

create table Directors
(
	ID int primary key identity,
	FullName nvarchar(50) not null,
	Age int
)

create table Movies
(
	ID int primary key identity,
	[Name] nvarchar(50) not null,
	IMDBPoint float,
	Duration time,
	DirectorsID int foreign key references Directors(ID)
)

create table Actors
(
	ID int primary key identity,
	FullName nvarchar(50) not null,
	Age int 
)

create table MovieActors
(
	ID int primary key identity,
	MoviesID int foreign key references Movies(ID),
	ActorsID int foreign key references Actors(ID)
)

create table Jenres
(
	ID int primary key identity,
	[Name] nvarchar(20)
)

create table MoviesJenres
(
	ID int primary key identity,
	MoviesID int foreign key references Movies(ID),
	JenresID int foreign key references Jenres(ID)
)

-- insert data into Directors
insert into Directors values ('Christopher Nolan', 50)
insert into Directors values ('Quentin Tarantino', 60)
insert into Directors values ('Steven Spielberg', 75)
insert into Directors values ('Martin Scorsese', 78)
insert into Directors values ('James Cameron', 66)

-- insert data into Movies
insert into Movies values ('Inception', 8.8, '02:28:00', 1)
insert into Movies values ('Pulp Fiction', 8.9, '02:34:00', 2)
insert into Movies values ('Jurassic Park', 8.1, '02:07:00', 3)
insert into Movies values ('The Departed', 8.5, '02:31:00', 4)
insert into Movies values ('Avatar', 7.8, '02:42:00', 5)

-- insert data into Actors
insert into Actors values ('Leonardo DiCaprio', 46)
insert into Actors values ('Brad Pitt', 57)
insert into Actors values ('Morgan Freeman', 84)
insert into Actors values ('Tom Hanks', 65)
insert into Actors values ('Scarlett Johansson', 36)

-- insert data into MovieActors
insert into MovieActors values (1, 1)
insert into MovieActors values (2, 1)
insert into MovieActors values (3, 2)
insert into MovieActors values (4, 2)
insert into MovieActors values (5, 3)
insert into MovieActors values (1, 4)
insert into MovieActors values (2, 4)
insert into MovieActors values (3, 5)
insert into MovieActors values (4, 5)
insert into MovieActors values (5, 1)

-- insert data into Jenres
insert into Jenres values ('Action')
insert into Jenres values ('Adventure')
insert into Jenres values ('Sci-Fi')
insert into Jenres values ('Thriller')
insert into Jenres values ('Drama')

-- insert data into MoviesJenres
insert into MoviesJenres values (1, 1)
insert into MoviesJenres values (1, 2)
insert into MoviesJenres values (1, 3)
insert into MoviesJenres values (2, 1)
insert into MoviesJenres values (2, 4)
insert into MoviesJenres values (3, 2)
insert into MoviesJenres values (3, 3)
insert into MoviesJenres values (4, 1)
insert into MoviesJenres values (4, 5)
insert into MoviesJenres values (5, 2)
insert into MoviesJenres values (5, 3)


-- 1. option
select m.[Name] as 'Movie', m.IMDBPoint as 'IMDB', j.[Name] as 'Jenre', d.FullName as 'Director', a.FullName as 'Actor' from Movies m 
join Directors d on d.ID = m.DirectorsID
join MoviesJenres mj on mj.MoviesID = m.ID 
join Jenres j on j.ID = mj.JenresID
join MovieActors ma on ma.MoviesID = m.ID
join Actors a on a.ID = ma.ActorsID
where m.IMDBPoint >= 6
order by m.IMDBPoint desc

-- 2. option
select m.Name as 'Movie', m.IMDBPoint as 'IMBD', j.[Name] as 'Jenre' from Jenres j
join MoviesJenres mj on mj.JenresID = j.ID
join Movies m on m.ID = mj.MoviesID
where j.[Name] like '%a%'

--3. option
select m.[Name] as 'Movie', IMDBPoint as 'IMBD', Duration, j.[Name] as 'Jenre' from Movies m 
join MoviesJenres mj on mj.MoviesID = m.ID
join Jenres j on j.id = mj.JenresID
where len(m.[Name])>10 and m.[Name] like '%t%'

--4. option 
select m.[Name] as 'Movie', IMDBPoint as 'IMBD', d.FullName as 'Director', a.FullName as 'Actor', j.[Name] as 'Jenre' from Movies m 
join Directors d on d.ID = m.DirectorsID
join MovieActors ma on ma.MoviesID = m.ID
join Actors a on a.ID = ma.ActorsID
join MoviesJenres mj on mj.MoviesID = m.ID
join Jenres j on j.id = mj.JenresID
where IMDBPoint > (select avg(IMDBPoint) from Movies)
order by IMDBPoint 

