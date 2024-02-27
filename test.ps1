$CSVFile = "C:\Scripts\AD_USERS\Medic_Argile.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter ";" -Encoding UTF8
Foreach($Utilisateur in $CSVData){
    $UtilisateurNom = $Utilisateur.Nom
    $UtilisateurPrenom = $Utilisateur.Prenom
    $UtilisateurSamAccount = "$Utilisateur.SamAccountName"
    $UtilisateurOU = $Utilisateur.OU
    $UtilisateurEmail = "$utilisateurSamAccount@abdasr24.adds"
    $utilisateurMDP = "azeAZE123-"


 # Vérifier la présence de l'utilisateur dans l'AD
 if (Get-ADUser -Filter {SamAccountName -eq $UtilisateurSamAccount})
 {
     Write-Warning "L'identifiant $UtilisateurSamAccount existe déjà dans l'AD"
 }
 else
 {
     New-ADUser -Name "$UtilisateurNom $UtilisateurPrenom" `
                 -DisplayName "$UtilisateurNom $UtilisateurPrenom" `
                 -GivenName $UtilisateurPrenom `
                 -Surname $UtilisateurNom `
                 -SamAccountName $UtilisateurSamAccount `
                 -UserPrincipalName "$UtilisateurSamAccount@abdasr24.adds" `
                 -EmailAddress $UtilisateurEmail `
                 -Path "OU=$OU,DC=abdasr24,DC=adds" `
                 -AccountPassword(ConvertTo-SecureString $UtilisateurMotDePasse -AsPlainText -Force) `
                 -ChangePasswordAtLogon $true `
                 -Enabled $true

     Write-Output "Création de l'utilisateur : $UtilisateurLogin ($UtilisateurNom $UtilisateurPrenom)"
 }
}