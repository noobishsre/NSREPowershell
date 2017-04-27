Function Get-CPUInfo {

    ##Prompt for PC name
    $pcName = Read-Host "Enter Machine Name:"
    
    ## Get top 5 processes utilizing CPU, sort descending order
    $cpuData = Get-WmiObject Win32_Process -computername $pcName | `
    Select Name, @{Name="CPU_Time"; Expression={$_.kernelmodetime + $_.usermodetime}} | `
    sort CPU_Time -Descending | select -first 5
    return $cpuData

    ## TODO ##
    <#
    Add functionality to clean up CPU_Time output
    Multiple Machines?
    #>
}
Get-CPUInfo