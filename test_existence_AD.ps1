function ExistenceAD {
    [CmdletBinding()]
    param ([string]$personneNom)
    
    #test d'existence du compte dans Active Directory
    try {Write-Debug "test de l'existence."
     $existeAD = (Get-ADUser $personneNom)}
    catch {$existeAD = $false}

    #bedug
    $DebugPreference ="Inquire"
    #affichage du messsage d'existence ou de creation du compte
    Write-Debug "affichage du message"
    if ($existeAD) {"le compte du stagiaire {0} existe dans Active Directory" -f $personneNom }
    else {"Vous devez créer le compte de {0} dans Active Directory." -f $personneNom }
   
}
ExistenceAD "test1"