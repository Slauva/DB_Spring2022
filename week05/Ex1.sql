CREATE TABLE Customer
(
    clientId    INTEGER PRIMARY KEY NOT NULL,
    balance     REAL,
    creditLimit REAL,
    discount    REAL
);

CREATE TABLE Order
(
    orderId  INTEGER KEY NOT NULL,
    date     CHAR(50)
);

CREATE TABLE ShippingAddresses
(
    clientId INTEGER NOT NULL REFERENCES Customer (clientId),
    house#   CHAR(50),
    street   CHAR(50),
    district CHAR(50),
    city     CHAR(50)
);

CREATE TABLE Item
(
    itemId      INTEGER PRIMARY KEY NOT NULL,
    description CHAR(50)
);

CREATE TABLE Manufacturer
(
    manufacturerId INTEGER KEY NOT NULL,
    phonenumber    CHAR(50)
);

-- Relationships

CREATE TABLE Includes
(
    itemId   INTEGER NOT NULL REFERENCES Item (itemId),
    orderId  INTEGER NOT NULL REFERENCES Order (orderId),
    quantity INTEGER
);

CREATE TABLE Produce
(
    itemId         INTEGER NOT NULL REFERENCES Item (itemId),
    manufacturerId INTEGER NOT NULL REFERENCES Manufacturer (manufacturerId),
    quantity       INTEGER
);