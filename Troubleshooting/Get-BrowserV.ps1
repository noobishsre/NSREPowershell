Function Get-BrowserV
{
    Param(
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        HelpMessage="PC Name?")]
	    [string] $pcName
    )

    ## Hard coded path of Firefox Version on 64bit system
    $path = "\\$pcName\HKLM\SOFTWARE\Wow6432Node\Mozilla\Mozilla Firefox"
    
    ## Query Registry
    $ffVersion = reg query $path /v CurrentVersion
    
    ## Return Version
    return $ffVersion
}
Get-BrowserV