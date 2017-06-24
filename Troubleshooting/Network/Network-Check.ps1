function Network-Check
{
    <#
    .SYNOPSIS
    Network Checks for a given device
    .DESCRIPTION
    This script performs a few different checks to troubleshoot
    network issues
    .EXAMPLE
    Network-Check <machinename>
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
    
     
    ## Hardcoded servername
    $server = "Google.Com"
    
    $yN = @()
    ## Ping PC
    try
    {
        $ping = Test-Connection $pcName -Count 1 -erroraction silentlycontinue
    }
    catch
    {
        #Do stuff
    }
    
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
        
        try
        {
            $srvrCheck = Test-Connection $server -Count 1 -erroraction silentlycontinue
        }
        catch
        {
            #dostuff
        }

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
export-modulemember -function Network-Check