function Validate-EmployeeData
{
    ##Get Employee ID
    $employeeID = Read-Host "Please Enter Employee ID"
    
    ## Create Query String
    $firstN = "a.F_N as EI_FN,b.F_N as OI_FN"
    $lastN = "a.L_N as EI_LN,b.L_N as OI_LN"
    $query = "SELECT OFFICE_ID,a.emp_id as EMP_ID,$firstN,$lastN,CITY,ST_ID,ZIP_CODE "
    $query += "FROM test_org..org_info as a,test_org..emp_info as b "
    $query += "WHERE a.emp_id=$employeeID AND a.emp_id=b.emp_id"

    ## Run query store results
    $results = Invoke-SQLCmd -query $query -ServerInstance Server\Instance
    $empInfoFN = $results.EI_FN
    $offInfoFN = $results.OI_FN

    ## Compare results
    if($empInfoFN -ne $offInfoFN)
    {
        $results | select-object EMP_ID,EI_FN,OI_FN,EI_LN,OI_LN | format-table
        write-host "Data values do not match"
        $choice = Read-Host "Do you want to correct? (1-Yes, 2-No)"
        if($choice -eq 1)
        {
            $newName = Read-Host "Enter corrected value"
            $newName = "'$newName'"
            $updateQry = "UPDATE test_org..org_info "
            $updateQry += "SET F_N=$newName "
            $updateQry += "WHERE EMP_ID=$employeeID"
            Invoke-SQLCMD -query $updateQry -ServerInstance Server\Instance
            Write-host "Update query has completed"
        }
        else
        {
            Write-host "Completed"
        }
    }
    elseif($empInfoFN -eq $offInfoFN)
    {
        $results | select-object EMP_ID,EI_FN,OI_FN,EI_LN,OI_LN | format-table
        write-host "values match"
    }
    else
    {
        write-host "an error has occurred"
    }
}
Validate-EmployeeData