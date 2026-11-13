1ère semaine
Benoit : 
Requêtes sur des API publiques :
randomuser.me/api
afficher 10 personnes sur un fichier csv de manière organisé (genre,nom, prénom, âge, adresse, ville, pays, e-mail)
Puis les insérer dans une base de données sql 

Version 1.0 (Création fichier .csv):
```
$appel = Invoke-RestMethod -Uri 'https://randomuser.me/api?inc=name,dob,location,email&noinfo&format=csv'
$UtilisateursLog = 'C:\temp\Utilisateurs.csv'
Set-Content $UtilisateursLog "$appel"
#Remplace , par ;
$content = [System.IO.File]::ReadAllText("$UtilisateursLog").Replace(",",";")
[System.IO.File]::WriteAllText("$UtilisateursLog", $content)
````

Version 1.1 (correction , par ; + exclusion iran dans nat + log creation du fichier):
```
$appel = Invoke-RestMethod -Uri 'https://randomuser.me/api?inc=name,dob,location,email&nat=AU,BR,CA,CH,DE,DK,ES,FI,FR,GB,IE,IN,MX,NL,NO,NZ,RS,TR,UA,US&noinfo&results=10&format=csv'
$UtilisateursLogPath = 'C:\temp\Utilisateurs.csv'

#Verification fichier
If (Test-Path $UtilisateursLogPath)
{
    Write-Host "La liste d'Utilisateurs a bien ete transferee dans le fichier Utilisateurs.csv"
}
else {
    $Creation
    Write-Host "Le fichier a bien ete cree"
}

$Creation = Set-Content $UtilisateursLogPath "$appel"
#Remplace , par ;
$content = [System.IO.File]::ReadAllText("$UtilisateursLogPath").Replace(",",";")
[System.IO.File]::WriteAllText("$UtilisateursLogPath", $content)
```

Version 1.2 (correction accents en caractères simples, retrait des colonnes non voule (lattitude, longitude, timezone etc)) :
```
$appel = Invoke-RestMethod -Uri "https://randomuser.me/api?inc=name,dob,location,email&nat=AU,BR,CA,CH,DE,DK,ES,FI,FR,GB,IE,IN,MX,NL,NO,NZ,RS,TR,UA,US&noinfo&results=10&format=csv"

$UtilisateursLogPath = "C:\temp\Utilisateurs.csv"

#Verification fichier

If (Test-Path $UtilisateursLogPath)

{
    Set-Content $UtilisateursLogPath "$appel"

    Write-Host "La liste d'Utilisateurs a bien ete transferee dans le fichier Utilisateurs.csv"
}

else {

    Set-Content $UtilisateursLogPath "$appel"

    Write-Host "Le fichier a bien ete cree"
}

#Filtre d'accents
function Remove-StringLatinCharacters
{
    PARAM (

        [parameter(ValueFromPipeline = $true)]

        [string]$String
    )
    PROCESS
    {
  [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($String))
    }
}

Foreach ($file in (Get-ChildItem C:\temp\Utilisateurs.csv))

{
    # Get the content of the current file and remove the diacritics
    $NewContent = Get-content $file | Remove-StringLatinCharacters

    # Overwrite the current file with the new content
    $NewContent | Set-Content $file
}

  

#Retrait des colonnes non necessaires (non dispo depuis l'url)
(Import-Csv $UtilisateursLogPath ) | Select-Object * -ExcludeProperty "location.coordinates.latitude","location.coordinates.longitude","location.timezone.offset","location.timezone.description","dob.date" | Export-Csv $UtilisateursLogPath -NoTypeInformation

#Remplace , par ;
$content = [System.IO.File]::ReadAllText("$UtilisateursLogPath").Replace(",",";")
[System.IO.File]::WriteAllText("$UtilisateursLogPath", $content)
Start-Process .\Utilisateurs.csv
```

Création des requêtes SQL :
```
--Creation (CREATE) ou modif (ALTER) de la table, puis declaration de chaque colonne (chiffres, lettres et nombre max de caractères)
/*
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
```




