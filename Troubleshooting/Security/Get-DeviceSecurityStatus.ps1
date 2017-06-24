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
	    [string] $pc
        
    )

    Get-HotFix -Description "Security*" -ComputerName "Server01" #-Cred "Server01\admin01"
}
Export-ModuleMember -Function Get-DeviceSecurityStatus