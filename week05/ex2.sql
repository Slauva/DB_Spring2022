CREATE TABLE Group
(
    groupId INTEGER PRIMARY KEY
);

CREATE TABLE Item
(
    itemId INTEGER PRIMARY KEY
);

CREATE TABLE Plant
(
    plantId INTEGER PRIMARY KEY
);

CREATE TABLE Company
(
    companyId INTEGER PRIMARY KEY
);

CREATE TABLE Structure
(
    structureId INTEGER KEY,
    FOREIGN KEY (companyId) REFERENCES Company
);