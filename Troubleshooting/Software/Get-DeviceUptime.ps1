cls                                             
$erroractionpreference = "SilentlyContinue"
# Helper Function - convert WMI date to TimeDate object
function WMIDateStringToDate($Bootup) {
 [System.Management.ManagementDateTimeconverter]::ToDateTime($Bootup)
}

# Main script
$Computer = Get-Content "c:\Servers.txt"

foreach ($system in $Computer) {
$rtn = Test-Connection -ComputerName $system -Count 1 -BufferSize 16 -Quiet
	 	IF($rtn -match 'True') {
		$NameSpace = "Root\CIMV2"
		$wmi = [WMISearcher]""
	 	$wmi.options.timeout = '0:0:15' #set timeout to 10 seconds
	 	$query = 'Select * from Win32_OperatingSystem'
	 	$wmi.scope.path = "\\$system\$NameSpace"
	 	$wmi.query = $query
	  	Try{
	  	$wmiresult = $wmi.Get()
	  	#	$wmiresult
			foreach ($wmioutput in $wmiresult){
			   $Bootup = $wmioutput.LastBootUpTime
			   $LastBootUpTime = WMIDateStringToDate($Bootup)
			   $now = Get-Date
			   $Uptime = $now - $lastBootUpTime
			   $d = $Uptime.Days
			   $h = $Uptime.Hours
			   $m = $uptime.Minutes
			   $ms= $uptime.Milliseconds
			   $a = "$System Up for: {0} days, {1} hours, {2}.{3} minutes" -f $d,$h,$m,$ms
			   Write-Host "$a" -ForegroundColor Green
	  		   }
	  		}
		Catch {
	  			Write-host "WMI not available on : $System" -ForegroundColor Red
				Write-Output "WMI failed on $system because : $_" | Out-File "d:\failed.txt" -Force -Append 
	  	}
		}
		else{
			write-host "$system Offline" -ForegroundColor DarkRed
			Write-Output "$system Offline" | Out-File 'd:\wintech\Get-Uptime\failed.txt' -Force -Append 
		}
	} 