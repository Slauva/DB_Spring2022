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
    house#   CHAR(50),
    street   CHAR(50),
    district CHAR(50),
    city     CHAR(50),
    FOREIGN KEY (clientId) REFERENCES Customer
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
    FOREIGN KEY (itemId) REFERENCES Item,
    FOREIGN KEY (orderId) REFERENCES Order
    quantity INTEGER
);

CREATE TABLE Produce
(
    FOREIGN KEY (itemId) REFERENCES Item,
    FOREIGN KEY (manufacturerId) REFERENCES Manufacturer,
    quantity       INTEGER
);