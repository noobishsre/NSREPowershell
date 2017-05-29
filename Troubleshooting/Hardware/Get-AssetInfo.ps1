Function Get-AssetInfo{

#############################################
#TODO
## Pipeline work for targeting specific data
## Create object for storing return data
## Create Baseline validation functionality of return data
## Add a component or two that act on the data 

Get-WmiObject -Class Win32_BIOS -ComputerName .

Get-WmiObject -Class Win32_Processor -ComputerName . | Select-Object -Property [a-z]*

Get-WmiObject -Class Win32_ComputerSystem | Select-Object -Property [a-z]*

Get-WmiObject -Class Win32_QuickFixEngineering -ComputerName . | Select-Object -Property [a-z]*

Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" -ComputerName .

Get-WmiObject -Class Win32_ComputerSystem -Property * -ComputerName .

Get-WmiObject -Class Win32_LocalTime -ComputerName . | Select-Object -Property [a-z]*

Get-WmiObject -Class Win32_Service -ComputerName . | where-object {$_.DisplayName -match "Hyper"} | Format-Table -Property Status,Name,DisplayName -AutoSize -Wrap

Get-WmiObject Win32_PNPEntity | Where-Object{$_.ConfigManagerErrorCode -ne 0} | Select Name, DeviceID

Get-WmiObject win32_networkadapterconfiguration | select Description, DHCPEnabled, IPEnabled, ServiceName #could also add Index
}
export-modulemember -function Get-AssetInfo