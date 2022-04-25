-- Query #1
-- Without Indexing

"Nested Loop Anti Join  (cost=534.78..2284549.49 rows=9731 width=10) (actual time=4473.030..13335.781 rows=1 loops=1)"
"Execution Time: 13338.031 ms"

-- With Indexing

"Nested Loop Anti Join  (cost=535.06..1557083.92 rows=9731 width=10) (actual time=239.048..252.519 rows=1 loops=1)"
"Execution Time: 255.993 ms"

-- Result:
-- W/o  indexes we have the cost 534.78..2284549.49
-- With indexes we have the cost 535.06..1557083.92

-- Final query with indexing

CREATE INDEX IF NOT EXISTS rental_last_update_idx ON rental (last_update);

-- Query #2
-- Without Indexing

"Seq Scan on film f1  (cost=0.00..13472193.00 rows=7000 width=18) (actual time=94.701..21400.978 rows=723 loops=1)"
"Execution Time: 21402.623 ms"

-- With Indexing

"Seq Scan on film f1  (cost=0.00..8619285.00 rows=7000 width=18) (actual time=99.896..4511.177 rows=723 loops=1)"
"Execution Time: 4512.570 ms"

-- Result:
-- W/o  indexes we have the cost 0.00..13472193.00
-- With indexes we have the cost  0.00..8619285.00

-- Final query with indexing

CREATE INDEX IF NOT EXISTS film_release_year_idx ON film (release_year);

-- Query #3
-- Without Indexing

"Seq Scan on film f  (cost=0.00..6154911.94 rows=10500 width=50) (actual time=349.597..7927.069 rows=21000 loops=1)"
"Execution Time: 7965.130 ms"

-- With Indexing

"Seq Scan on film f  (cost=0.00..2267955.08 rows=10500 width=50) (actual time=334.434..539.257 rows=21000 loops=1)"
"Execution Time: 547.513 ms"


-- Result:
-- W/o  indexes we have the cost 0.00..6154911.94
-- With indexes we have the cost 0.00..2267955.08

-- Final query

CREATE INDEX IF NOT EXISTS film_rating_idx ON film (rating);
CREATE INDEX IF NOT EXISTS payment_rating_idx ON payment (rental_id);
CREATE INDEX IF NOT EXISTS rental_inventory_id_idx ON rental (inventory_id);
CREATE INDEX IF NOT EXISTS rental_customer_id_idx ON rental (customer_id);
CREATE INDEX IF NOT EXISTS inventory_film_id_idx ON inventory (film_id);
CREATE INDEX IF NOT EXISTS film_actor_film_id_idx ON film_actor (film_id);
CREATE INDEX IF NOT EXISTS film_actor_actor_id_idx ON film_actor (actor_id);
CREATE INDEX IF NOT EXISTS customer_first_name_idx ON customer (first_name);
CREATE INDEX IF NOT EXISTS actor_first_name_idx ON actor (first_name);