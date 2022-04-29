# Task 1

## Queries

### Query #1

~~~SQL
EXPLAIN ANALYZE
SELECT ID, Name
FROM customer
WHERE ID > 1000
  AND ID < 10000
~~~

### Query #2

~~~SQL
EXPLAIN ANALYZE
SELECT Review
FROM customer
WHERE ID > 1000
  AND ID < 10000
  AND Name like 'Amanda'
~~~

### Query #3

~~~SQL
EXPLAIN ANALYZE
SELECT Name, Review
FROM customer
WHERE ID > 500
  AND ID < 50000
  AND Address like 'PSC'
~~~

### Query #4

~~~SQL
EXPLAIN ANALYZE
SELECT *
FROM customer
WHERE ID % 2 = 1
  AND Address like 'PSC'
~~~

## Indexes

**B-Tree** index with two columns _Name_, _ID_ with filter by _Name_

~~~SQL
CREATE INDEX IF NOT EXISTS customer_id ON customer USING BTREE (Name, ID) WHERE Name like 'Amanda';
~~~

**BRIN** index with _ID_ column with filter by _ID_

~~~SQL
CREATE INDEX IF NOT EXISTS customer_idx ON customer USING BRIN (ID) WHERE ID > 500 AND ID < 50000;
~~~

**HASH** index with _Name_ column

~~~SQL
CREATE INDEX IF NOT EXISTS customer_name ON customer USING HASH (Name);
~~~

**GIN** index with _Review_ column

~~~SQL
CREATE INDEX IF NOT EXISTS customer_review ON customer USING GIN (to_tsvector('english'::regconfig, Review));
~~~

**GIST** index with _Address_ column with sort by _Address_

~~~SQL
CREATE INDEX IF NOT EXISTS customer_address ON customer USING GIST (to_tsvector('english'::regconfig, Address)) WHERE Address like 'PSC';
~~~

## Results

|          | Cost w/o Index | Time w/o Index | Cost with Index | Time with Index |
|----------|----------------|----------------|-----------------|-----------------|
| Query #1 | 547.31         | 2.410          | 547.31          | 1.938           |
| Query #2 | 569.26         | 1.827          | 8.14            | 0.007           |
| Query #3 | 3148.58        | 11.334         | 8.14            | 0.012           |
| Query #4 | 16777.39       | 30.941         | 8.14            | 0.010           |
