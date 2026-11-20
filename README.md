Requêtes sur des API publiques :
randomuser.me/api
Afficher 10 personnes sur un fichier csv de manière organisé (genre,nom, prénom, âge, adresse, ville, pays, e-mail). 

* Version 1.0 (Création fichier .csv):
```
$appel = Invoke-RestMethod -Uri 'https://randomuser.me/api?inc=name,dob,location,email&noinfo&format=csv'
$UtilisateursLog = 'C:\temp\Utilisateurs.csv'
Set-Content $UtilisateursLog "$appel"
#Remplace , par ;
$content = [System.IO.File]::ReadAllText("$UtilisateursLog").Replace(",",";")
[System.IO.File]::WriteAllText("$UtilisateursLog", $content)
````

* Version 1.1 (correction , par ; + exclusion iran dans nat + log creation du fichier):
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

* Version 1.2 (correction accents en caractères simples, retrait des colonnes non voule (lattitude, longitude, timezone etc)) :
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

* Version finale
On enlève les guillemets pour ne pas gêner dans la table, et on remplace tout les alias de Mme et Mr par : Mme et Mr :
```
$appel = Invoke-RestMethod -Uri "https://randomuser.me/api?inc=name,dob,location,email&nat=AU,BR,CA,CH,DE,DK,ES,FI,FR,GB,IE,IN,MX,NL,NO,NZ,RS,TR,UA,US&noinfo&results=1000&format=csv"

$UtilisateursLogPath = "C:\Users\GianniCOUPE\Documents\Benoit\Utilisateurs.csv"

  

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

  

Foreach ($file in (Get-ChildItem $UtilisateursLogPath   ))

{

    # Get the content of the current file and remove the diacritics

    $NewContent = Get-content $file | Remove-StringLatinCharacters

    # Overwrite the current file with the new content

    $NewContent | Set-Content $file

}

  

#Retrait des colonnes non necessaires (non dispo depuis l'url) et Remplace les Mrs miss madame mademoiselle monsieur Mr par : Mr, Mme

(Import-Csv $UtilisateursLogPath ) | Select-Object * -ExcludeProperty "location.coordinates.latitude","location.coordinates.longitude","location.timezone.offset","location.timezone.description","dob.date" | Export-Csv $UtilisateursLogPath -NoTypeInformation

#Remplace , par ;

$content = [System.IO.File]::ReadAllText("$UtilisateursLogPath").Replace(",",";")-replace('Miss|Mademoiselle|Ms|Madame|Mrs','Mme')-replace('Monsieur','Mr')-replace('"','')

[System.IO.File]::WriteAllText("$UtilisateursLogPath", $content)

#Start-Process .\Utilisateurs.csv
```



