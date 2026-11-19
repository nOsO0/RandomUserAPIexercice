SELECT DISTINCT
    PERCENTILE_CONT(0.5)
    WITHIN GROUP (ORDER BY age)
    OVER () AS AgeMedian
FROM dbo.randomuser
WHERE age >= 0;