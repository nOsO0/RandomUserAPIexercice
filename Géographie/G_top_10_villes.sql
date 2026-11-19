SELECT TOP 10
    ville AS Ville,
    pays AS Pays,
    COUNT(*) AS Nombre
FROM dbo.randomuser
WHERE ville IS NOT NULL
GROUP BY ville, pays
ORDER BY Nombre DESC;
