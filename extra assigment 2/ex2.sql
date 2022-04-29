-- Indexes 
CREATE INDEX IF NOT EXISTS products_type ON products USING HASH (type);
CREATE INDEX IF NOT EXISTS sales_type ON sales USING HASH (type);

-- Query 1
EXPLAIN ANALYZE
SELECT c.id, c.name
FROM products p,
     sales s,
     customers c,
     purchases_products_list p1,
     purchases p2
WHERE c.id = p2.customer_id
  AND p2.id = p1.purchase_id
  AND p1.product_id = p.id
  AND p.type = s.type
  AND s.discount::INTEGER > 0
GROUP BY c.id;


-- Query 2
EXPLAIN ANALYZE
SELECT c.id, c.name, SUM(p.price * s.discount::INTEGER / 100) AS saved_money
FROM products p,
     sales s,
     customers c,
     purchases_products_list p1,
     purchases p2
WHERE c.id = p2.customer_id
  AND p2.id = p1.purchase_id
  AND p1.product_id = p.id
  AND p.type = s.type
GROUP BY c.id
HAVING SUM(p.price * s.discount::INTEGER / 100) > 0;

