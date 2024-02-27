$CSVFile = "C:\Scripts\AD_USERS\Medic_Argile.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter ";" -Encoding UTF8
[string]$DC1="abdasr24"
[string]$DC2="adds"
Foreach($Utilisateur in $CSVData){
    $UtilisateurNom = $Utilisateur.Nom
    $UtilisateurPrenom = $Utilisateur.Prenom
    $UtilisateurSamAccount = $Utilisateur.SamAccountName
    $UtilisateurOU = $Utilisateur.OU
    #$UtilisateurEmail = "$utilisateurSamAccount@abdasr24.adds"
    $utilisateurMDP = "azeAZE123-"


 # Vérifier la présence de l'utilisateur dans l'AD
 if (Get-ADUser -Filter {SamAccountName -eq $UtilisateurSamAccount})
 {
     Write-Warning "L'identifiant $UtilisateurSamAccount existe déjà dans l'AD"
 }
 else
 {
     $userParams = @{
        SamAccountName = $UtilisateurSamAccount
        UserPrincipalName = "$($utilisateur.SamAccountName)@$DC1.$DC2"
        Name = $UtilisateurNom
        GivenName = $UtilisateurPrenom
        Surname = $UtilisateurNom
        DisplayName = "$UtilisateurNom"
        Path = "OU=$utilisateurOU,DC=$DC1,DC=$DC2"
        Description = "Description de $UtilisateurNom"
        Enabled = $true
        AccountPassword = ConvertTo-SecureString "azeAZE123-" -AsPlainText -Force
        ChangePasswordAtLogon = $true
        }

     # Créer l'utilisateur dans Active Directory
    New-ADUser @userParams

    Write-Host "L'utilisateur $username a été créé avec succès dans Active Directory."
    }

 }
