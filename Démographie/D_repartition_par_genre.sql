SELECT
    COALESCE(NULLIF(LTRIM(RTRIM(genre)), ''), 'Inconnu') AS Genre,
    COUNT(*) AS Nombre,
    CAST(
        COUNT(*) * 100.0 /
        NULLIF((SELECT COUNT(*) FROM dbo.randomuser), 0)
        AS DECIMAL(5,2)
    ) AS Pourcentage
FROM dbo.randomuser
GROUP BY genre
ORDER BY Nombre DESC;
