

Function Get-CPUInfo {

    $pcName = Read-Host "Enter Machine Name:"
    $cpuData = Get-WmiObject Win32_Process -computername $pcName | `
    Select Name, @{Name="CPU_Time"; Expression={$_.kernelmodetime + $_.usermodetime}} | `
    sort CPU_Time -Descending | select -first 5
    return $cpuData
}
Get-CPUInfo

