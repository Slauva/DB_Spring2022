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