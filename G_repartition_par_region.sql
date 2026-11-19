SELECT
    pays AS Pays,
    region AS Region,
    COUNT(*) AS Nombre
FROM dbo.randomuser
WHERE region IS NOT NULL
GROUP BY pays, region
ORDER BY Nombre DESC;