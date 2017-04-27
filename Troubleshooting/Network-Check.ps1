function Network-Check
{
    Param(
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        HelpMessage="PC Name?")]
	    [string] $pcName
    )
    
     
    ## Hardcoded servername
    $server = "Google.Com"
    
    $yN = @()
    ## Ping PC
    $ping = Test-Connection $pcName -Count 1
    
    ## If no response, write message, otherwise, test server connection
    if($ping -eq $NULL)
    {
        Write-Host "`nUnable to reach destination computer"
        $yN = "00"
    }
    else
    {
        
        $yN = "1"
        Write-Host "`nDestination computer pingable"
        Write-Host "`nChecking Server Connection..."
        $ping | format-table
        $srvrCheck = Test-Connection $server -Count 1
        if($srvrCheck -eq $NULL)
        {
            $yN += "0"
            Write-Host "Unable to reach server"
        }
        else
        {
            $srvrCheck | format-table
            $yN += "1"
            Write-Host "Server is accessible"
        }
    }

    if($yN -match "00")
    {
        $rtrnMessage = "`nUsers PC is having connection issues"
    }
    elseif($yN -match "10")
    {
        $rtrnMessage = "`nIt appears that the server is down"
    }
    elseif($yN -match "11")
    {
        $rtrnMessage = "`nConnection tests were successful"
    }
    else
    {
        $rtrnMessage = "`nAn error occurred"
    }
    return $rtrnMessage
}