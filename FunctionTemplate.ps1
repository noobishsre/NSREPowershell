Function Action-Details
{
    <#
    .SYNOPSIS
    --Synopsis--
    .DESCRIPTION
    --Description--
    .EXAMPLE
    --Example--
    .NOTES
    --Notes--
    .LINK
    --URL--
    #>

    Param(
        [Parameter(Mandatory=$true,
        ValueFromPipeline=$true,
        HelpMessage="<Param helper>")]
	    [string] $ParamName
        
    )
}
Export-ModuleMember -Function Action-Details