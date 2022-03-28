CREATE TABLE Airport
(
    IATACode INTEGER PRIMARY KEY
);

CREATE TABLE AircraftType
(
    typeId INTEGER PRIMARY KEY
);

CREATE TABLE DailyFlightLegCombination
(
    DFLegId INTEGER PRIMARY KEY
);

CREATE TABLE Flight
(
    flightNum INTEGER PRIMARY KEY
);

CREATE TABLE FlightLeg
(
    flightLegId INTEGER PRIMARY KEY
);

CREATE TABLE CanLand
(
    IATACode int not null,
    FOREIGN KEY (IATACode) REFERENCES Airport (IATACode),
    typeId   int not null,
    FOREIGN KEY (typeId) REFERENCES AircraftType (typeId)
);