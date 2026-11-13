--Creation (CREATE) ou modif (ALTER) de la table, puis declaration de chaque colonne (chiffres, lettres et nombre max de caractères)

Alter TABLE randomuser (
nom VARCHAR(50),
prenom VARCHAR(50),
genre VARCHAR(20),
email VARCHAR(100),
age int,
pays VARCHAR(50),
ville VARCHAR(50),
rue VARCHAR(50),
numeroderue int,
region VARCHAR(50),
codepostal VARCHAR(50),
);
*/

--insertion des données de c:\...\Utilisateurs.csv dans la base de données, en déterminant les séparateurs (CSV = Comma Separated Values) dans ce cas ci des ';' et les séparateurs de lignes (saut de ligne = \n)
BULK INSERT dbo.randomuser
FROM 'C:\temp\Utilisateurs.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
)