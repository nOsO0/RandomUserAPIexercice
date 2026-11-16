$appel = Invoke-RestMethod -Uri "https://randomuser.me/api?inc=name,dob,location,email&nat=AU,BR,CA,CH,DE,DK,ES,FI,FR,GB,IE,IN,MX,NL,NO,NZ,RS,TR,UA,US&noinfo&results=1000&format=csv"
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

Foreach ($file in (Get-ChildItem C:\Users\GianniCOUPE\Documents\Benoit\*.csv))
{
    # Get the content of the current file and remove the diacritics
    $NewContent = Get-content $file | Remove-StringLatinCharacters
    
    # Overwrite the current file with the new content
    $NewContent | Set-Content $file
}

#Retrait des colonnes non necessaires (non dispo depuis l'url) et Remplace les Mrs miss madame mademoiselle monsieur Mr par : Mr, Mme
(Import-Csv $UtilisateursLogPath ) | Select-Object * -ExcludeProperty "location.coordinates.latitude","location.coordinates.longitude","location.timezone.offset","location.timezone.description","dob.date" | Export-Csv $UtilisateursLogPath -NoTypeInformation 
#Remplace , par ;
$content = [System.IO.File]::ReadAllText("$UtilisateursLogPath").Replace(",",";")-replace('Miss|Mademoiselle|Ms|Madame|Mrs','Mme')-replace('Monsieur','Mr')
[System.IO.File]::WriteAllText("$UtilisateursLogPath", $content)
#Start-Process .\Utilisateurs.csv