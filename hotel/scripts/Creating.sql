CREATE DATABASE IF NOT EXISTS Hotels;

USE Hotels;

CREATE TABLE IF NOT EXISTS HotelBranch 
(
	HotelBranchId INT PRIMARY KEY AUTO_INCREMENT,
    HotelName Varchar(256) NOT NULL,
    City Varchar(256) NOT NULL,
    Address Varchar(256) NOT NULL,
    Administrator Varchar(256)
);

CREATE TABLE IF NOT EXISTS RoomType
(
	RoomTypeId INT PRIMARY KEY AUTO_INCREMENT,
    RoomTypeName Varchar(256) NOT NULL DEFAULT 'Room for one person',
    NumberOfHumans INT
);

CREATE TABLE IF NOT EXISTS Season
(
	SeasonId INT PRIMARY KEY AUTO_INCREMENT,
    SeasonName Varchar(256) NOT NULL
);

CREATE TABLE IF NOT EXISTS Price
(
	RoomType INT NOT NULL,
    HotelBranch INT NOT NULL,
	Season INT NOT NULL,
    Price FLOAT NOT NULL,
    FOREIGN KEY (RoomType)  REFERENCES RoomType (RoomTypeId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (HotelBranch)  REFERENCES HotelBranch (HotelBranchId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Season)  REFERENCES Season (SeasonId) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Room
(
	RoomId INT PRIMARY KEY AUTO_INCREMENT,
    Floor INT NOT NULL,
    RoomNumber INT NOT NULL,
    RoomType INT NOT NULL,
    HotelBranch INT NOT NULL,
    FOREIGN KEY (RoomType)  REFERENCES RoomType (RoomTypeId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (HotelBranch)  REFERENCES HotelBranch (HotelBranchId) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Roomer
(
	RoomerId INT PRIMARY KEY AUTO_INCREMENT,
    FullName Varchar(256) NOT NULL,
    PhoneNumber Varchar(256) NOT NULL,
    PassportNumber INT,
    IPN INT
);

CREATE TABLE IF NOT EXISTS Booking
(
	BookingId INT PRIMARY KEY AUTO_INCREMENT,
    DayOfBooking DATE NOT NULL,
    DateOfArrival DATE NOT NULL,
    DepartureDate DATE NOT NULL,
    Roomer INT NOT NULL,
    Room INT NOT NULL,
    Note Varchar(256),
    FOREIGN KEY (Roomer)  REFERENCES Roomer (RoomerId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Room)  REFERENCES Room (RoomId) ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK (DateOfArrival < DepartureDate)
);

CREATE TABLE IF NOT EXISTS TypeOfService
(
	TypeOfServiceId INT PRIMARY KEY AUTO_INCREMENT,
    NameOfService Varchar(256),
    Price FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS ServicesBill
(
	ServicesBillId INT PRIMARY KEY AUTO_INCREMENT,
    PaymentDate DATE,
    RoomerId INT NOT NULL,
    Total FLOAT,
    FOREIGN KEY (RoomerId)  REFERENCES Roomer (RoomerId) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ProvisionOfServises
(
	TypeOfService INT NOT NULL,
    ServicesBill INT NOT NULL,
    ProvisionDate DATE NOT NULL,
    FOREIGN KEY (TypeOfService)  REFERENCES TypeOfService (TypeOfServiceId) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ServicesBill)  REFERENCES ServicesBill (ServicesBillId) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS AcomodationBill
(
    Booking INT NOT NULL,
    Total FLOAT NOT NULL,
    PaymentDay DATE, 
    FOREIGN KEY (Booking)  REFERENCES Booking (BookingId) ON UPDATE CASCADE ON DELETE CASCADE
);
