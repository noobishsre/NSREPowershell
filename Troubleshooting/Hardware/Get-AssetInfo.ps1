﻿Function Get-AssetInfo
{
    <#
    .SYNOPSIS
    Gathers hardware information of a given device
    .DESCRIPTION
    This script uses Get-WMIObject to obtain information about a given device
    .EXAMPLE
    Get-AssetInfo <devicename>
    .NOTES
    Notes
    .LINK
    URL
    #>

    Param(
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        HelpMessage="Asset Name?")]
	    [string] $asset
        
    )

    $logFile = "C:\Temp\AssetInfo-$asset.txt"
    
    ##########################################################
    ## Gather BIOS version and Device Serial Number
    ##########################################################
    $winBiosObj = Get-WmiObject -Class Win32_BIOS -ComputerName $asset | `
    Select SMBIOSBIOSVersion, SerialNumber | `
    out-file -append $logFile

    ##########################################################
    ## Gather system information
    ##########################################################
    $CompSysObj = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $asset| `
    Select-Object -Property PSComputerName, BootupState, Status, Name, `
    DNSHostname, Domain, Manufacturer, Model, SystemType, UserName | `
    out-file -append $logFile

    ##########################################################
    ## Check installed hotfixes
    ##########################################################
    $hotFixObj = Get-WmiObject -Class Win32_QuickFixEngineering -ComputerName $asset | `
    Select-Object -Property HotFixID, InstalledOn, InstalledBy | `
    out-file -append $logFile

    ##########################################################
    ## Get Operating System Information
    ##########################################################
    $winOSObj = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $asset | `
    Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion,ServicePackMinorVersion | `
    out-file -append $logFile

    ##########################################################
    ## Get HDD Information
    ##########################################################
    $winDiskObj = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" -ComputerName $asset | `
    Select DeviceID, @{n="Size";e={[math]::Round($_.Size/1GB,2)}},@{n="FreeSpace";e={[math]::Round($_.FreeSpace/1GB,2)}} | `
    out-file -append $logFile

    ##########################################################
    ## Top 5 processes utilizing CPU
    ##########################################################
    $cpuStatus = Get-CPUStatus $asset | out-file -append $logFile

    ##########################################################
    ## Service checks and restarts if necessary
    ## There's something goofy going on in this section
    ## It's not validating the status
    ##########################################################
    $serviceList = @("NetLogon", "DNS", "Spooler", "sqlwriter")

    foreach($s in $serviceList)
    {
        
        $serv = Get-Service -ComputerName $asset | where-object {$_.Name -eq $s} | out-file -append $logFile
        $status = $serv.Status
        if($status -eq "Stopped")
        {
            "$status has been found in a non running state, attempting to restart" | out-file -append $logFile
            try
            {
                start-service $s
            }
            catch
            {
                ##Error
            }

            get-service $s
            if($s.Status -eq "Stopped")
            {
                Write-Host "Unable to restart $s service" | out-file -append $logFile
            }
        }
    }


    ##########################################################
    ## Future Use
    ##########################################################
    <#
    Get-WmiObject Win32_PNPEntity | Where-Object{$_.ConfigManagerErrorCode -ne 0} | Select Name, DeviceID

    Get-WmiObject win32_networkadapterconfiguration | select Description, DHCPEnabled, IPEnabled, ServiceName #could also add Index
    #>
}
export-modulemember -function Get-AssetInfo