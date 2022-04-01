-- Task 1
SELECT s.sname
FROM Student as s
         LEFT JOIN Registration as r ON r.sid = s.sid
WHERE r.cid = 107
  AND r.percent > 90;