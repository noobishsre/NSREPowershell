$NSRERoot = (Split-Path -Path $MyInvocation.MyCommand.Path)

#For future use : "$moduleRoot\SQLBasics\*.ps1"
"$NSRERoot\Troubleshooting\*.ps1" | Resolve-Path | ForEach-Object { . $_.ProviderPath }

#By adding the Toolbox path to the environment path 
#This enables us to be able to call these functions 
#regardless of which directory they are in
if ($env:path -ne $NULL) {
	if (!($env:path.Contains("\NSREPowershell\Toolbox"))) {
		$env:path += ";$NSRERoot\Toolbox"
	}
}

#sc is the alias for Set-Content, but we point to sc.exe instead, which is what we normally use
#Set-Alias -name sc -value sc.exe -Option AllScope -Force