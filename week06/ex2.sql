-- Task 1
SELECT *
FROM Author as a
         LEFT JOIN Book as b
WHERE a.author_id = b.editor;

-- Task 2
SELECT a.first_name, a.second_name
FROM Author as a,
     (SELECT b.editor
      FROM Book as b
               LEFT JOIN Author as aj
      WHERE aj.author_id = b.editor) as r
WHERE a.author_id != r.editor
  AND r.editor != null;

-- Task 3
SELECT a.author_id
FROM Author as a,
     Book as b
WHERE a.author_id != b.editor
  AND b.editor != null;

