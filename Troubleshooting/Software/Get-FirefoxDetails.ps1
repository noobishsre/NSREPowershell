Function Get-FirefoxDetails
{
    <#
    .SYNOPSIS
    Validate firefox installation details
    .DESCRIPTION
    This script performs a check on the version of firefox to ensure the correct
    version is installed, if not, it calls Repair-Firefox to uninstall the wrong
    version and install the correct one
    .EXAMPLE
    Get-FirefoxDetails <machinename>
    .NOTES
    Notes
    .LINK
    URL
    #>

    Param(
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        HelpMessage="PC Name?")]
	    [string] $pc
    )

    ## Hard coded path of Firefox Version on 64bit system
    $path = "\\$pc\HKLM\SOFTWARE\Wow6432Node\Mozilla\Mozilla Firefox"
    
    ## Query Registry
    $ffVersion = reg query $path /v CurrentVersion
    
    if($ffVersion -match "53.0.3")
    {
        Write-Host "Firefox Up To Date"
    }
    else
    {
        Write-Host "Firefox is not up date, running Repair-Firefox"
        Repair-Firefox $pc
    }
}
export-modulemember -function Get-FirefoxDetails