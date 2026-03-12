create database TurboAz
use TurboAz

create table Marka
(
	Id int primary key identity,
	[Name] nvarchar(50)
)

insert into Marka values('Mercedes-Benz'),
('BMW'),
('Audi'),
('Volkswagen'),
('Toyota'),
('Honda'),
('Nissan'),
('Ford'),
('Chevrolet'),
('Hyundai')

create table BanNovu
(
	Id int primary key identity,
	[Name] nvarchar(50)
)

insert into BanNovu values('Sedan'),
('Hatchback'),
('SUV'),
('Coupe'),
('Convertible'),
('Wagon'),
('Van'),
('Pickup Truck')

create table Seher
(
	Id int primary key identity,
	[Name] nvarchar(50)
)

insert into Seher values('Baku'),
('Ganja'),
('Sumqayit'),
('Mingachevir'),
('Lankaran'),
('Shaki'),
('Nakhchivan'),
('Quba'),
('Qusar'),
('Gabala')

create table Bazar
(
	Id int primary key identity,
	[Name] nvarchar(50)
)

insert into Bazar values('Avropa'),
('Asiya'),
('Amerika')


create table Reng
(
	Id int primary key identity,
	[Name] nvarchar(50)
)

insert into Reng values('Qara'),
('Ağ'),
('Gümüşü'),
('Boz'),
('Qırmızı'),
('Mavi'),
('Sarı'),
('Yaşıl'),
('Bənövşəyi'),
('Narıncı')

create table BuraxilisIli
(
	Id int primary key identity,
	Il char(4) check(Il like '[1-2][0-9][0-9][0-9]')
)

insert into BuraxilisIli values('2000'),
('2001'),
('2002'),
('2003'),
('2004'),
('2005'),
('2006'),
('2007'),
('2008'),
('2009')

create table Muherrik
(
	Id int primary key identity,
	[Name] nvarchar(50)
)

insert into Muherrik values('Dizel'),
('Benzin'),
('Hibrid'),
('Elektrik')

create table Satici
(
	Id int primary key identity,
	FullName nvarchar(50),
	Telephone nvarchar(50),
	Emails nvarchar(50)
)

insert into Satici values('Ali Veliyev', '0501234567', 'ali.veliyev@example.com'),
('Ayşe Həsənova', '0512345678', 'ayse.hasanova@example.com'),
('Mehmet Demir', '0523456789', 'mehmet.demir@example.com'),
('Fatma Yılmaz', '0534567890', 'fatma.yilmaz@example.com'),
('Ahmet Kaya', '0545678901', 'ahmet.kaya@example.com'),
('Elif Özdemir', '0556789012', 'elif.ozdemir@example.com')



create table Fotos
(
	Id int primary key identity,
	[URL] nvarchar(100)
)

insert into Fotos values('https://example.com/photo1.jpg'),
('https://example.com/photo2.jpg'),
('https://example.com/photo3.jpg'),
('https://example.com/photo4.jpg'),
('https://example.com/photo5.jpg'),
('https://example.com/photo6.jpg')

create table Techizat
(
	Id int primary key identity,
	[Name] nvarchar(50)
)

insert into Techizat values('ABS'),
('Airbag'),
('ESP'),
('Yol Kompüter'),
('Kruiz Kontrol'),
('Park Sensorları')


create table Models
(
	Id int primary key identity,
	[Name] nvarchar(50),
	MarkaId int foreign key references Marka(Id),
	BanNovuId int foreign key references BanNovu(Id),
	MuherrikId int foreign key references Muherrik(Id)
)

insert into Models values('C-Class', 1, 1, 1),
('3 Series', 2, 1, 2),
('A4', 3, 1, 3),
('Passat', 4, 1, 1),
('Camry', 5, 1, 2),
('Civic', 6, 1, 3),
('Altima', 7, 1, 3),
('F-150', 8, 1, 1),
('Silverado', 9, 1, 1),
('Elantra', 10, 1, 1)


create table Elan
(
	Id int primary key identity,
	[No] nvarchar(30),
	[Name] nvarchar(50),
	Yuruyush int,
	AvtoVeziyyet nvarchar(100),
	Qiymet int,
	MarkaId int foreign key references Marka(Id),
	SeherId int foreign key references Seher(Id),
	SaticiId int foreign key references Satici(Id),
	FotoId int foreign key references Fotos(Id)
)

insert into Elan values('ELN001', 'Mercedes-Benz C-Class', 50000, 'Yaxşı vəziyyətdə', 30000, 1, 1, 1, 1),
('ELN002', 'BMW 3 Series', 60000, 'Əla vəziyyətdə', 35000, 2, 2, 2, 2),
('ELN003', 'Audi A4', 55000, 'Yaxşı vəziyyətdə', 32000, 3, 3, 3, 3),
('ELN004', 'Volkswagen Passat', 70000, 'Əla vəziyyətdə', 40000, 4, 4, 4, 4),
('ELN005', 'Toyota Camry', 80000, 'Yaxşı vəziyyətdə', 45000, 5, 5, 5, 5),
('ELN006', 'Honda Civic', 65000, 'Əla vəziyyətdə', 38000, 6, 6, 6, 6)


create table ElanTechizat
(
	Id int primary key identity,
	ElanId int foreign key references Elan(Id),
	TechizatID int foreign key references Techizat(Id)
)

insert into ElanTechizat values(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 2),
(3, 4),
(4, 1),
(4, 5),
(5, 2),
(5, 6),
(6, 3),
(6, 4)


create table BazarM
(
	Id int primary key identity,
	BazarId int foreign key references Bazar(Id),
	ModelsId int foreign key references Models(Id)
)
-- insert into BazarM values(BazarId, ModelsId) modelsid start 11
insert into BazarM values(1, 11),
(1, 12),
(2, 13),
(2, 14),
(3, 15),
(3, 16)


create table ModelR
(
	Id int primary key identity,
	ModelsId int foreign key references Models(Id),
	RengId int foreign key references Reng(Id)
)

insert into ModelR values(11, 1),
(11, 2),
(12, 3),
(12, 4),
(13, 5),
(13, 6),
(14, 7),
(14, 8),
(15, 9),
(15, 10),
(16, 1),
(16, 2)

create table ModelB
(
	Id int primary key identity,
	ModelsId int foreign key references Models(Id),
	BuraxilisId int foreign key references BuraxilisIli(Id) 
)

insert into ModelB values(11, 1),
(11, 2),
(12, 3),
(12, 4),
(13, 5),
(13, 6),
(14, 7),
(14, 8),
(15, 9),
(15, 10),
(16, 1),
(16, 2)


