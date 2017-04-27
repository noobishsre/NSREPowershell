Function Get-WebAccessCheck($userInfo)
{
    $usr = $userInfo.Username
    $pc = $userInfo.PCName

    ######################################
    ## Round 1 - Network Check
    ######################################
    Write-Host "Checking Network Connections..."
    $netCheck = Network-Check $pc
    $netCheck | format-table

    ######################################
    ## Round 2 - CPU Check
    ######################################
    Write-Host "Checking CPU Usage..."
    $cpuCheck = Get-CPUStatus $pc
    $cpuCheck | format-table

    ######################################
    ## Round 3 - Firefox Version Check
    ######################################
    Write-Host "Checking Firefox Version..."
    $ffVersion = Get-BrowserV $pc
    $ffVersion | format-table

    ######################################
    ## Round 4 - Folder Permission Check
    ######################################
    Write-Host "Checking Folder Permissions..."
    $folderPerms = Check-FolderPermissions $pc
    $folderPerms | format-list
}

$user = Read-Host "Username:"
$pcName = Read-Host "Machine Name:"
$userInfo = [PSCustomObject]@{
    Username = $user
    PCName = $pcName
}
Get-WebAccessCheck $userInfo