-- Drop same indexes if thats exists
DROP INDEX IF EXISTS rental_idx;
DROP INDEX IF EXISTS film_idx;
DROP INDEX IF EXISTS films_idx;
DROP INDEX IF EXISTS payment_idx;
DROP INDEX IF EXISTS rentals_idx;
DROP INDEX IF EXISTS inventory_idx;
DROP INDEX IF EXISTS film_actor_idx;
DROP INDEX IF EXISTS customer_idx;
DROP INDEX IF EXISTS actor_idx;

-- №1 Query
CREATE INDEX IF NOT EXISTS rental_idx ON rental (last_update, rental_id, staff_id, customer_id) WITH (fillfactor=29);
-- №2 Query
CREATE INDEX IF NOT EXISTS film_idx ON film (release_year, rental_rate);
-- №3 Query
CREATE INDEX IF NOT EXISTS films_idx ON film (rating, release_year);
CREATE INDEX IF NOT EXISTS film_actor_idx ON film_actor (actor_id, film_id);

CREATE INDEX IF NOT EXISTS payment_idx ON payment (rental_id);
CREATE INDEX IF NOT EXISTS rentals_idx ON rental (customer_id, rental_id) WITH (fillfactor=100);
CREATE INDEX IF NOT EXISTS inventory_idx ON inventory (film_id, inventory_id);

CREATE INDEX IF NOT EXISTS customer_idx ON customer USING HASH (first_name);
CREATE INDEX IF NOT EXISTS actor_idx ON actor using HASH (first_name);