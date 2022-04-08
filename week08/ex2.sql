"""
    Task 1
"""

SELECT distinct ON (f.film_id) title, name 
FROM film as f 
	INNER JOIN film_category as fc ON f.film_id =fc.film_id
	INNER JOIN category as c ON  fc.category_id = c.category_id
	INNER JOIN inventory as i on f.film_id = i.film_id
	INNER JOIN rental as r on i.inventory_id = r.inventory_id
WHERE  (f.rating ='R' OR f.rating = 'PG-13') AND (c.name = 'Horror' OR c.name='Sci-Fi') 
AND (r.return_date IS NOT NULL OR NOT EXISTS (SELECT 1 FROM film ,inventory WHERE film.film_id = inventory.film_id))


"""
Unique  (cost=330.96..334.70 rows=375 width=87)
  InitPlan 1 (returns $1)
    ->  Nested Loop  (cost=0.28..1646.41 rows=4581 width=0)
          ->  Seq Scan on inventory  (cost=0.00..70.81 rows=4581 width=2)
          ->  Index Only Scan using film_pkey on film  (cost=0.28..0.34 rows=1 width=4)
                Index Cond: (film_id = inventory.film_id)
  ->  Sort  (cost=330.32..332.19 rows=749 width=87)
        Sort Key: f.film_id
        ->  Nested Loop  (cost=88.14..294.56 rows=749 width=87)
              ->  Hash Join  (cost=87.86..177.99 rows=215 width=91)
                    Hash Cond: (i.film_id = f.film_id)
                    ->  Seq Scan on inventory i  (cost=0.00..70.81 rows=4581 width=6)
                    ->  Hash  (cost=87.27..87.27 rows=47 width=89)
                          ->  Nested Loop  (cost=1.54..87.27 rows=47 width=89)
                                ->  Hash Join  (cost=1.26..20.58 rows=125 width=70)
                                      Hash Cond: (fc.category_id = c.category_id)
                                      ->  Seq Scan on film_category fc  (cost=0.00..16.00 rows=1000 width=4)
                                      ->  Hash  (cost=1.24..1.24 rows=2 width=72)
                                            ->  Seq Scan on category c  (cost=0.00..1.24 rows=2 width=72)
                                                  Filter: (((name)::text = 'Horror'::text) OR ((name)::text = 'Sci-Fi'::text))
                                ->  Index Scan using film_pkey on film f  (cost=0.28..0.53 rows=1 width=19)
                                      Index Cond: (film_id = fc.film_id)
                                      Filter: ((rating = 'R'::mpaa_rating) OR (rating = 'PG-13'::mpaa_rating))
              ->  Index Scan using idx_fk_inventory_id on rental r  (cost=0.29..0.51 rows=3 width=4)
                    Index Cond: (inventory_id = i.inventory_id)
                    Filter: ((return_date IS NOT NULL) OR (NOT $1))
"""


-- Analysis
-- The most expensive part here is - Nested Loop  (cost=0.28..1646.41 rows=4581 width=0)
-- This could be optimized if we introduce a btree index for the subquery on the film_id column 



"""
    Task 2
"""

EXPLAIN select distinct
    on (p3.store_id) p3.store_id,
                     sum(p3.amount)
from (inventory as inv inner join (select res.inventory_id, res.amount
                                   from (rental as r inner join (select p.rental_id, p.amount
                                                                 from payment as p
                                                                 where extract(month from p.payment_date) =
                                                                       extract(month from current_timestamp)) as pp
                                         on r.rental_id = pp.rental_id) as res) as p2
      on inv.inventory_id = p2.inventory_id) as p3
group by p3.store_id

"Unique  (cost=846.89..847.47 rows=2 width=34)"
"  ->  GroupAggregate  (cost=846.89..847.46 rows=2 width=34)"
"        Group Key: inv.store_id"
"        ->  Sort  (cost=846.89..847.07 rows=73 width=8)"
"              Sort Key: inv.store_id"
"              ->  Nested Loop  (cost=0.57..844.63 rows=73 width=8)"
"                    ->  Nested Loop  (cost=0.29..822.00 rows=73 width=10)"
"                          ->  Seq Scan on payment p  (cost=0.00..399.92 rows=73 width=10)"
"                                Filter: (date_part('month'::text, payment_date) = date_part('month'::text, CURRENT_TIMESTAMP))"
"                          ->  Index Scan using rental_pkey on rental r  (cost=0.29..5.78 rows=1 width=8)"
"                                Index Cond: (rental_id = p.rental_id)"
"                    ->  Index Scan using inventory_pkey on inventory inv  (cost=0.28..0.31 rows=1 width=6)"
"                          Index Cond: (inventory_id = r.inventory_id)"

-- Analysis
-- The most expensive part here is - Nested Loop  (cost=0.29..822.00 rows=73 width=10)
-- This could be optimized if we introduce a btree index for the subquery on the inventory_id column 