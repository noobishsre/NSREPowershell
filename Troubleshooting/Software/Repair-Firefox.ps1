function get-firefoxDL
{
    $source = "https://download.mozilla.org/?product=firefox-stub&os=win&lang=en-US"
    $destination = "c:\users\administrator\downloads\Firefox Setup Stub 53.0.3.exe"
 
    Invoke-WebRequest $source -OutFile $destination
}

function uninstall-firefox
{
    $dir = "C:\Program Files (x86)\Mozilla Firefox\uninstall\"
    $file = "helper.exe"
    $fp = "$dir$file"
    Write-Host "Starting..."
    start-process $fp /s -wait
    write-host "Completed"
}

function Install-Firefox
{
    $dir = "c:\users\administrator\downloads\"
    $file = "Firefox Setup Stub 53.0.3.exe"
    $fp = "$dir$file"
    Write-Host "Starting..."
    start-process $fp /s -wait
    write-host "Completed"
}

function Repair-Firefox
{
    <#
    .SYNOPSIS
    Uninstall/Reinstalls Firefox
    .DESCRIPTION
    This script is utilized by Get-FirefoxDetails to uninstall an old or incorrect
    version of Firefox and install the desired version
    .EXAMPLE
    Repair-Firefox <machinename>
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

    write-host "Downloading newest version..."
    Get-FirefoxDL $pc
    start-sleep -s 2
    ls c:\users\administrator\downloads *firefox*
    start-sleep -s 2
    clear-host
    
    Write-Host "Uninstalling old version"
    uninstall-firefox $pc
    Write-Host "uninstall complete"

    start-sleep -s 2
    

    Write-host "Installing new version"
    install-firefox $pc
    write-host "Installation complete"

    start-sleep -s 30
    

    Write-Host "Verifying installed version"
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
        Write-Host "Something Went Wrong"
    }
}
export-modulemember -function Repair-Firefox