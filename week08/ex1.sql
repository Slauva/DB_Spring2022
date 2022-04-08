-- Seq Scan on customer  (cost=0.00..4032.00 rows=100000 width=211)
-- After indexing Seq Scan on consumer  (cost=0.00..4032.00 rows=100000 width=211)
EXPLAIN
SELECT *
FROM CUSTOMER;

-- Seq Scan on customer  (cost=0.00..4532.00 rows=500 width=4)
-- Bitmap Heap Scan on customer  (cost=547.00..3087.04 rows=500 width=4)
EXPLAIN
SELECT ID
FROM CUSTOMER
WHERE ID % 2 = 0;

-- Seq Scan on customer  (cost=0.00..4782.00 rows=40 width=211)
-- Bitmap Heap Scan on customer  (cost=94.99..2557.11 rows=40 width=211)  
EXPLAIN
SELECT *
FROM CUSTOMER
WHERE ID % 2 = 1
  AND NAME LIKE 'S%';