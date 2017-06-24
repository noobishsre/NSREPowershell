Function Get-WebAccessCheck
{
    <#
    .SYNOPSIS
    Validates criteria needed for accessing web application
    .DESCRIPTION
    This script validates several different criteria in order to check if
    a given user/machine has the necessary configuration and/or access to
    utilize a web based application
    .EXAMPLE
    Get-WebAccessCheck <machinename>
    .NOTES
    The user validation portion of this script is not currently configured
    .LINK
    URL
    #>

    Param(
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        HelpMessage="PC Name?")]
	    [string] $pc
        
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