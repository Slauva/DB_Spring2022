CREATE TABLE Salesperson
(
    salesperson_id INTEGER NOT NULL primary key
);

CREATE TABLE Car
(
    car_id        INTEGER NOT NULL primary key,
    serial_number VARCHAR(255)
);

CREATE TABLE Customer
(
    customer_id INTEGER NOT NULL primary key
);

CREATE TABLE Mechanic
(
    mechanic_id INTEGER NOT NULL primary key
);

CREATE TABLE Service
(
    service_id INTEGER NOT NULL primary key
);

CREATE TABLE Part
(
    part_id INTEGER NOT NULL primary key
);

CREATE TABLE Invoice
(
    invoice_id     INTEGER NOT NULL primary key,
    car_id         int     not null,
    customer_id    int     not null,
    salesperson_id int     not null,
    FOREIGN KEY (car_id) REFERENCES Car (car_id),
    FOREIGN KEY (customer_id) REFERENCES Customer (customer_id),
    FOREIGN KEY (salesperson_id) REFERENCES Salesperson (salesperson_id)
);

-- Relationships

CREATE TABLE ServiceTicket
(
    ticket_id   INTEGER NOT NULL primary key,
    car_id      int     not null,
    customer_id int     not null,
    FOREIGN KEY (car_id) REFERENCES Car (car_id),
    FOREIGN KEY (customer_id) REFERENCES Customer (customer_id)
);

CREATE TABLE PartsUsed
(
    parts_used_id INTEGER NOT NULL primary key,
    part_id       int     not null,
    ticket_id     int     not null,
    FOREIGN KEY (part_id) REFERENCES Part (part_id),
    FOREIGN KEY (ticket_id) REFERENCES ServiceTicket (ticket_id)
);

CREATE TABLE ServiceMechanic
(
    service_Mechanic_id INTEGER NOT NULL primary key,
    service_id          INTEGER NOT NULL,
    ticket_id           int     not null,
    mechanic_id         int     not null,
    FOREIGN KEY (service_id) REFERENCES Service (service_id),
    FOREIGN KEY (ticket_id) REFERENCES ServiceTicket (ticket_id),
    FOREIGN KEY (mechanic_id) REFERENCES Mechanic (mechanic_id)
);
