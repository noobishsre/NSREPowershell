Function Check-FolderPermissions
{
    ## Check folder permissions for CCleaner folder
    $result = (Get-Acl 'C:\Program Files\CCleaner').Access | where{$_.IdentityReference -eq "BUILTIN\Users"}
    return $result
}
Check-FolderPermissions