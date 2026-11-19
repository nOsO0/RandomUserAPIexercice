SELECT TOP 20
    pays AS Pays,
    codepostal AS CodePostal,
    COUNT(*) AS Nombre
FROM dbo.randomuser
WHERE codepostal IS NOT NULL
GROUP BY pays, codepostal
ORDER BY Nombre DESC;