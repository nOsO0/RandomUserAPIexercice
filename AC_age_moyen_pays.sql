SELECT
    pays AS Pays,
    COUNT(*) AS NombrePersonnes,
    AVG(CAST(age AS DECIMAL(10,2))) AS AgeMoyen
FROM dbo.randomuser
WHERE age >= 0
GROUP BY pays
ORDER BY NombrePersonnes DESC;