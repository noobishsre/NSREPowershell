Function Get-WebAccessCheck
{
    Param(
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        HelpMessage="PC Name?")]
	    [string] $pcName
        
        #For later use...
        <#
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        HelpMessage="Username?")]
	    [string] $userName
        #>
    )
    
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
    $ffVersion = Get-FirefoxDetails $pc
    $ffVersion | format-table

    ######################################
    ## Round 4 - Folder Permission Check
    ######################################
    Write-Host "Checking Folder Permissions..."
    $folderPerms = Check-FolderPermissions $pc
    $folderPerms | format-list
}
export-modulemember -function Get-WebAccessCheck