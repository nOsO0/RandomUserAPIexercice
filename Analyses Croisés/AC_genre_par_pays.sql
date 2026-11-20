SELECT
    pays AS Pays,
    genre AS Civilité,
    COUNT(*) AS Nombre
FROM dbo.randomuser
GROUP BY pays, civilité
ORDER BY pays, Nombre DESC;
