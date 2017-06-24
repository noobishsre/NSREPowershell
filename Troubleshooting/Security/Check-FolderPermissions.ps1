Function Check-FolderPermissions
{
    <#
    .SYNOPSIS
    Validates folder permissions
    .DESCRIPTION
    This script validates whether or not the permissions for a directory are configured
    correctly
    .EXAMPLE
    Check-FolderPermissions <machinename>
    .NOTES
    Notes
    .LINK
    URL
    #>

    Param(
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        HelpMessage="PC Name?")]
	    [string] $pcName
    )
    ## Check folder permissions for CCleaner folder
    $result = (Get-Acl "\\$pcName\c$\Program Files (x86)\Mozilla Firefox").Access | where{$_.IdentityReference -eq "BUILTIN\Users"}
    return $result
}
export-modulemember -function Check-FolderPermissions