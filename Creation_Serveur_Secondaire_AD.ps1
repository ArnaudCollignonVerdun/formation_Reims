function PreparerServeur {
    param (
        [string]$NomServeur
    )

    # Afficher un message de bienvenue
    Write-Host "Bienvenue ! Configuration des paramètres réseau pour le serveur $NomServeur." -ForegroundColor Cyan

    # Listez les adaptateurs réseau disponibles
    $Adaptateurs = Get-NetAdapter | Select-Object -Property InterfaceIndex, InterfaceAlias, MacAddress

    # Demander à l'utilisateur de choisir une carte réseau
    Write-Host "Cartes réseau disponibles :"
    $i = 1
    foreach ($Adaptateur in $Adaptateurs) {
        Write-Host "$i. $($Adaptateur.InterfaceAlias) - $($Adaptateur.MacAddress)"
        $i++
    }

    $ChoixCarte = Read-Host "Choisissez le numéro de la carte réseau à configurer" 
    $CarteSelectionnee = $Adaptateurs[$ChoixCarte - 1]

    # Demander les informations réseau
    $IP = Read-Host "Adresse IP du serveur"
    
    # Demander le masque en format CIDR
    $MasqueCIDR = Read-Host "Masque de sous-réseau en format CIDR (ex. 24 pour 255.255.255.0)"
    
    # Calculer le PrefixLength à partir du masque CIDR
    $PrefixLength = [math]::Pow(2, (32 - $MasqueCIDR)) - 1
    
    $Gateway = Read-Host "Passerelle par défaut"
    $DNSPrimaire = Read-Host "Serveur DNS principal"
    $DNSAuxiliaire = Read-Host "Serveur DNS auxiliaire"

    # Afficher les informations saisies
    Write-Host "Configuration réseau pour $NomServeur sur la carte $($CarteSelectionnee.InterfaceAlias) :"
    Write-Host "Adresse IP : $IP"
    Write-Host "Masque de sous-réseau (CIDR) : $MasqueCIDR"
    Write-Host "Passerelle par défaut : $Gateway"
    Write-Host "Serveur DNS principal : $DNSPrimaire"
    Write-Host "Serveur DNS auxiliaire : $DNSAuxiliaire"

    # Exécuter les commandes de configuration réseau
    New-NetIPAddress -InterfaceIndex $($CarteSelectionnee.InterfaceIndex) -IPAddress $IP -PrefixLength $MasqueCIDR -DefaultGateway $Gateway
   
    Set-DnsClientServerAddress -InterfaceIndex $($CarteSelectionnee.InterfaceIndex) -ServerAddresses $DNSPrimaire, $DNSAuxiliaire
}

$choixreboot =  Read-Host " changer le nom serveur Oui : 1 Non : 2"
    if($choixreboot = 1){
        $NouveauNomServeur = Read-Host "Entrez le nouveau nom du serveur"
            Rename-Computer -NewName $NouveauNomServeur -Force -Restart
        }
         else{
                write-host "fini sans changer de nom ou reboot"
             }
# Appeler la fonction avec le nom du serveur
PreparerServeur -NomServeur "$NouveauNomServeur"