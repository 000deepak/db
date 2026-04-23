USE dbo;
GO

-- Create tables
CREATE TABLE tableA (
                        id INT
);

CREATE TABLE tableB (
                        id INT
);

-- View initial data
SELECT * FROM tableA;

-- Insert data
INSERT INTO tableA (id)
VALUES (NULL);

SELECT * FROM tableB;

INSERT INTO tableB (id)
VALUES (NULL);

/*
Expected number of rows:
1. INNER JOIN  = 11
2. LEFT JOIN   = 10
3. FULL OUTER  = (depends on data)
*/

-- LEFT JOIN
SELECT *
FROM tableA AS A
         LEFT JOIN tableB AS B
                   ON A.id = B.id;  -- ~10 rows

-- RIGHT JOIN
SELECT *
FROM tableA AS A
         RIGHT JOIN tableB AS B
                    ON A.id = B.id;  -- ~11 rows

-- INNER JOIN
SELECT *
FROM tableA AS A
         INNER JOIN tableB AS B
                    ON A.id = B.id;  -- ~8 rows

-- CROSS JOIN (note: no ON clause needed)
SELECT *
FROM tableA AS A
         CROSS JOIN tableB AS B;  -- Cartesian product

/*
MySQL does not support FULL OUTER JOIN directly,
but it can be emulated using UNION.
*/

SELECT *
FROM tableA AS a
         LEFT JOIN tableB AS b
                   ON a.id = b.id

UNION

SELECT *
FROM tableA AS a1
         RIGHT JOIN tableB AS a2
                    ON a1.id = a2.id;