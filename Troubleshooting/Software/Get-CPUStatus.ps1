Function Get-CPUStatus
{
    <#
    .SYNOPSIS
    Get data about CPU
    .DESCRIPTION
    This script performs a scan of running processes on a given machine and returns
    top five processes utilizing CPU
    .EXAMPLE
    Get-CPUStatus <machinename>
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
    
    ### Get top 5 processes utilizing CPU, sort descending order
    $cpuData = Get-WmiObject Win32_Process -computername $pcName | `
    Select Name, @{Name="CPU_Time"; Expression={$_.kernelmodetime + $_.usermodetime}} | `
    sort CPU_Time -Descending | select -first 5
    return $cpuData

    #########################
    ## TODO
    #########################
    ## Add functionality to clean up CPU_Time output
    ## Multiple Machines?
    
}
export-modulemember -function Get-CPUStatus