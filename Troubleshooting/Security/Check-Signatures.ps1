Function Check-Signatures
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
        HelpMessage="PC Name?")]
	    [string] $pc
        
    )
cls
$url="http://www.microsoft.com/security/portal/definitions/adl.aspx"
$page=Invoke-WebRequest -Uri $url
Write-Host "MPC Current Signature version is: " -ForegroundColor Yellow -nonewline;write-host -foregroundcolor white $page.ParsedHtml.getElementById("ctl00_ctl00_pageContent_leftside_defVersion").textcontent
Write-Host "http://www.microsoft.com/security/portal/definitions/adl.aspx" -ForeGroundColor blue
cls
Write-Host "MPC Current Signature version is: " -ForegroundColor Yellow -nonewline;write-host -foregroundcolor white $page.ParsedHtml.getElementById("ctl00_ctl00_pageContent_leftside_defVersion").textcontent
Write-Host "http://www.microsoft.com/security/portal/definitions/adl.aspx" -ForeGroundColor blue


write-host ""

Write-Host "(WSUS) Microsoft Catalog Signature version is: " -ForegroundColor Yellow -nonewline
$MSCatalog=Invoke-WebRequest -uri "https://catalog.update.microsoft.com/v7/site/search.aspx?q=antimalware" -UserAgent "Mozilla/5.0 (Windows; U; MSIE 9.0; Windows NT 9.0; en-US)"

$MSCatalog.Links | Where-Object {$_.InnerHtml -like "HTTP Malware Definition Update for Microsoft Forefront Threat Management Gateway"}
$MSCatalog.Links.innertext[14].Trim("HTTP Malware Definition Update for Microsoft Forefront Threat Management Gateway (Antimalware").Trim(")")

$MSCatlogVersion=$MSCatalog.Links.innertext[14].Trim("HTTP Malware Definition Update for Microsoft Forefront Threat Management Gateway (Antimalware").Trim(")")
Write-host "https://catalog.update.microsoft.com/v7/site/search.aspx?q=antimalware" -ForeGroundColor Blue

write-host ""


$url="http://www.microsoft.com/security/portal/shared/prereleasesignatures.aspx"
$page=Invoke-WebRequest -Uri $url
Write-Host "MPC Pre-Release Signature version is: " -ForegroundColor Yellow -Nonewline;write-host -nonewline $page.ParsedHtml.getElementById("ctl00_ctl00_pageContent_leftside_defVersion").textcontent
Write-host ""
Write-host "http://www.microsoft.com/security/portal/shared/prereleasesignatures.aspx" -ForeGroundColor blue 
Write-host ""
write-host "signature change log:" -ForegroundColor white; Write-host "https://www.microsoft.com/security/portal/definitions/whatsnew.aspx" -ForegroundColor Blue

Write-host ""
Write-host ""
Write-host ""
Write-host ""
$url="http://www.microsoft.com/security/portal/shared/prereleasesignatures.aspx"
$page=Invoke-WebRequest -Uri $url
Write-Host "2nd web request - MPC Pre-Release Signature version is: " -ForegroundColor Yellow -Nonewline;write-host -nonewline $page.ParsedHtml.getElementById("ctl00_ctl00_pageContent_leftside_defVersion").textcontent
Write-host ""
Write-host "http://www.microsoft.com/security/portal/shared/prereleasesignatures.aspx" -ForeGroundColor blue -nonewline

Write-host ""
$url="http://www.microsoft.com/security/portal/shared/prereleasesignatures.aspx"
$page=Invoke-WebRequest -Uri $url
Write-Host "3rd web request - MPC Pre-Release Signature version is: " -ForegroundColor Yellow -Nonewline;write-host -nonewline $page.ParsedHtml.getElementById("ctl00_ctl00_pageContent_leftside_defVersion").textcontent
Write-host ""
Write-host "http://www.microsoft.com/security/portal/shared/prereleasesignatures.aspx" -ForeGroundColor blue -nonewline
Write-host ""
}
Export-ModuleMember -Function Check-Signatures