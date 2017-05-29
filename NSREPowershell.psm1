$NSRERoot = (Split-Path -Path $MyInvocation.MyCommand.Path)
"$NSRERoot\Troubleshooting\*.ps1",`
"$NSRERoot\Troubleshooting\Network\*.ps1",`
"$NSRERoot\Troubleshooting\Software\*.ps1",`
"$NSRERoot\Troubleshooting\Hardware\*.ps1",`
"$NSRERoot\Troubleshooting\Security\*.ps1", `
"$NSRERoot\SQLBasics\*.ps1" | Resolve-Path | ForEach-Object { . $_.ProviderPath }