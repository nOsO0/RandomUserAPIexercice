Requête/Calculs SQL

Cette branche de l'activité contient :
* La création de la requête SQL pour la table :
```
--Creation (CREATE) ou modif (ALTER) de la table, puis declaration de chaque colonne (chiffres, lettres et nombre max de caractères)

Create TABLE dbo.randomuser (
civilité VARCHAR(20),
prenom VARCHAR(50),
nom VARCHAR(50),
numeroderue int,
rue VARCHAR(100),
ville VARCHAR(100),
pays VARCHAR(100),
region VARCHAR(100),
codepostal VARCHAR(100),
email VARCHAR(100),
age int,
)

--insertion des données de c:\...\Utilisateurs.csv dans la base de données, en déterminant les séparateurs (CSV = Comma Separated Values) dans ce cas ci des ';' et les séparateurs de lignes (saut de ligne = \n)
BULK INSERT dbo.randomuser
FROM 'C:\Users\GianniCOUPE\Documents\Benoit\Utilisateurs.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n'
)
```
* La création d'une multitude de programmes de calculs à insérer dans Grafana pour obtenir tout types d'analytics :
1. Géographiques, calculs sur les ; villes, pays, code postal, régions
2. Démographiques, calculs sur les population ; civilité, âges
3. Analyses Croisés, croisement entre Géo et Démographique
