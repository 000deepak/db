## Section 6: Aggregate Functions

**1. COUNT: count number of rows**
```sql
SELECT COUNT(*) FROM tablename; -- count number of row
SELECT COUNT(colname) FROM tablename; -- count number of row of a column
SELECT COUNT(DISTINCT colname) FORM tablename; -- count distinct row of a column
```

**2. GROUP BY: aggregates identical data into single rows**
```sql
SELECT colname FROM tablename GROUP BY colname;
```

**3. MIN: return minimum column value**
```sql
SELECT MIN(colname) FROM tablename;
```

**4. MAX: return maximum column value**
```sql
SELECT MAX(colname0 FROM tablename GROUP BY colname;
```

**5. MAX/MIN with GROUP BY**
Group row first before finding minimum
```sql
SELECT colname1,
       MIN(colname2) 
FROM tablename 
GROUP BY colname2;
```

**6. SUM: sum column value**
```sql
SELECT colname1, SUM(colname2)
FROM tablename
GROUP BY colname2;
```

**7. AVG: average column value**
```sql
SELECT AVG(colname) FROM tablename;

SELECT colname1, AVG(colname2)
FROM tablename
GROUP BY colname2;
```