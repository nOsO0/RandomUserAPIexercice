SELECT
    MIN(age) AS AgeMinimum,
    MAX(age) AS AgeMaximum
FROM dbo.randomuser
WHERE age >= 0;