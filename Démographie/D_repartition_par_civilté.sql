SELECT
    COALESCE(NULLIF(LTRIM(RTRIM(genre)), ''), 'Inconnu') AS Civilité,
    COUNT(*) AS Nombre,
    CAST(
        COUNT(*) * 100.0 /
        NULLIF((SELECT COUNT(*) FROM dbo.randomuser), 0)
        AS DECIMAL(5,2)
    ) AS Pourcentage
FROM dbo.randomuser
GROUP BY civilité
ORDER BY Nombre DESC;
