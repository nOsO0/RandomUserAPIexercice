SELECT
    pays AS Pays,
    genre AS Genre,
    COUNT(*) AS Nombre
FROM dbo.randomuser
GROUP BY pays, genre
ORDER BY pays, Nombre DESC;
