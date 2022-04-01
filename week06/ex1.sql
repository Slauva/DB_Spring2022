-- Task 1
SELECT DISTINCT s.sname
FROM parts as p
         JOIN catalog c on p.pid = c.pid
         JOIN suppliers s on s.sid = c.sid
WHERE p.color = 'Red';

-- Task 2
SELECT DISTINCT c.sid
FROM parts as p
         JOIN catalog c on p.pid = c.pid
WHERE p.color = 'Red'
   or p.color = 'Green';

-- Task 3
SELECT DISTINCT c.sid
FROM parts as p
         JOIN catalog c on p.pid = c.pid
WHERE p.color = 'Red'
UNION
SELECT DISTINCT s.sid
FROM suppliers s
WHERE s.address = '221 Packer Street';

-- Task 4
SELECT DISTINCT c.sid
FROM parts as p
         JOIN catalog c on p.pid = c.pid
WHERE p.color = 'Red'
INTERSECT
SELECT DISTINCT c.sid
FROM parts as p
         JOIN catalog c on p.pid = c.pid
WHERE p.color = 'Green';

--Task 5
SELECT *
FROM catalog as c
WHERE NOT EXISTS(
        (SELECT p.pid FROM parts as p)
        EXCEPT
        (SELECT cc.pid FROM catalog as cc WHERE c.sid = cc.sid)
    );

--Task 6
SELECT *
FROM catalog as c
WHERE NOT EXISTS(
        (SELECT p.pid FROM parts as p WHERE p.color = 'Red')
        EXCEPT
        (SELECT cc.pid FROM catalog as cc WHERE c.sid = cc.sid)
    );

--Task 7
SELECT *
FROM catalog as c
WHERE NOT EXISTS(
        (SELECT p.pid FROM parts as p WHERE p.color = 'Red' or p.color = 'Green')
        EXCEPT
        (SELECT cc.pid FROM catalog as cc WHERE c.sid = cc.sid)
    );

--Task 8
SELECT *
FROM catalog as c
WHERE NOT EXISTS(
        (SELECT p.pid FROM parts as p WHERE p.color = 'Red')
        EXCEPT
        (SELECT cc.pid FROM catalog as cc WHERE c.sid = cc.sid)
    )
UNION
SELECT *
FROM catalog as c
WHERE NOT EXISTS(
        (SELECT p.pid FROM parts as p WHERE p.color = 'Green')
        EXCEPT
        (SELECT cc.pid FROM catalog as cc WHERE c.sid = cc.sid)
    );

-- Task 9
SELECT R.sid, G.sid
FROM catalog as R
         CROSS JOIN catalog as G
WHERE R.pid = G.pid
  AND R.sid != G.sid
  AND R.cost > G.cost;

-- Task 10
SELECT R.pid
FROM catalog as R
         CROSS JOIN catalog as G
WHERE R.pid = G.pid
  AND R.sid != G.sid;