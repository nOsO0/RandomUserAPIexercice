SELECT
    ville AS Ville,
    pays AS Pays,
    AVG(CAST(age AS DECIMAL(10,2))) AS AgeMoyen,
    MIN(age) AS AgeMinimum,
    MAX(age) AS AgeMaximum,
    COUNT(*) AS NombrePersonnes
FROM dbo.randomuser
WHERE age >= 0
GROUP BY ville, pays
ORDER BY NombrePersonnes DESC;