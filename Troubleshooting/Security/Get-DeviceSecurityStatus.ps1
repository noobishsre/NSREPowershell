Function Get-DeviceSecurityStatus
{
    <#
    .SYNOPSIS
    --Synopsis--
    .DESCRIPTION
    --Description--
    .EXAMPLE
    --Example--
    .NOTES
    --Notes--
    .LINK
    --URL--
    #>

    Param(
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        HelpMessage="Device Name?")]
	    [string] $pc,
        [Parameter(Mandatory=$true)]
        [String]$usr
    )

    #####################################################
    ## Check hotfix installation status
    #####################################################
    Get-HotFix -Description "Security*" -ComputerName "Server01" #-Cred "Server01\admin01"

    <# Other Examples

    $A = Get-Content "servers.txt"
    $A | ForEach { if (!(Get-HotFix -Id "KB957095" -ComputerName $_)) { Add-Content $_ -Path "Missing-kb953631.txt" }}

    (Get-HotFix | sort installedon)[-1]
    #>

    #####################################################
    ## Check last time local admin password was reset
    #####################################################
    Add-Type -AssemblyName System.DirectoryServices.AccountManagement 
    $PrincipalContext = New-Object System.DirectoryServices.AccountManagement.PrincipalContext([System.DirectoryServices.AccountManagement.ContextType]::Machine, $pc)
    $User = [System.DirectoryServices.AccountManagement.UserPrincipal]::FindByIdentity($PrincipalContext, $usr)
    $User.LastPasswordSet
}
Export-ModuleMember -Function Get-DeviceSecurityStatus