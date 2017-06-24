Function Check-FolderPermissions
{
    <#
    .SYNOPSIS
    Script Synopsis
    .DESCRIPTION
    Script Description
    .EXAMPLE
    Usage Example
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