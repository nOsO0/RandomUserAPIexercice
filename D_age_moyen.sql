SELECT
    AVG(CAST(age AS DECIMAL(10,2))) AS AgeMoyen
FROM dbo.randomuser
WHERE age >= 0;