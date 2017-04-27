function Network-Check($pcName)
{
    ## Hardcoded servername
    $server = "Server_Name"
    
    ## Get PC Name to test
    $pcName = Read-Host "PC Name:"
    
    ## Ping PC
    $ping = Test-Connection $pcName -Count 1
    
    ## If no response, write message, otherwise, test server connection
    if($ping -eq $NULL)
    {
        Write-Host "Unable to reach computer"
    }
    else
    {
        $ping | format-table
        $srvrCheck = Test-Connection $server
        return $srvrCheck
    }
}
Network-Check