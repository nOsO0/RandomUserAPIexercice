SELECT
    genre AS Genre,
    CASE
        WHEN age < 18 THEN 'Moins de 18 ans'
        WHEN age BETWEEN 18 AND 24 THEN '18-24 ans'
        WHEN age BETWEEN 25 AND 34 THEN '25-34 ans'
        WHEN age BETWEEN 35 AND 44 THEN '35-44 ans'
        WHEN age BETWEEN 45 AND 54 THEN '45-54 ans'
        WHEN age BETWEEN 55 AND 64 THEN '55-64 ans'
        ELSE '65 ans et plus'
    END AS TrancheAge,
    COUNT(*) AS Nombre
FROM dbo.randomuser
WHERE age >= 0
GROUP BY
    genre,
    CASE
        WHEN age < 18 THEN 'Moins de 18 ans'
        WHEN age BETWEEN 18 AND 24 THEN '18-24 ans'
        WHEN age BETWEEN 25 AND 34 THEN '25-34 ans'
        WHEN age BETWEEN 35 AND 44 THEN '35-44 ans'
        WHEN age BETWEEN 45 AND 54 THEN '45-54 ans'
        WHEN age BETWEEN 55 AND 64 THEN '55-64 ans'
        ELSE '65 ans et plus'
    END
ORDER BY Genre, MIN(age);
