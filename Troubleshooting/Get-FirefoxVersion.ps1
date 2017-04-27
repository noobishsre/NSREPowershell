Function Get-FirefoxVersion
{
    ## Hard coded path of Firefox Version on 64bit system
    $path = "HKLM\SOFTWARE\Wow6432Node\Mozilla\Mozilla Firefox"
    
    ## Query Registry
    $ffVersion = reg query $path /v CurrentVersion
    
    ## Return Version
    return $ffVersion
}
Get-FirefoxVersion