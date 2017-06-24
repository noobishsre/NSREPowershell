function Get-EmployeeData
{
    <#
    .SYNOPSIS
    Gather details about a given employee from MySQL database
    .DESCRIPTION
    Script queries database for info about an employee and returns the data
    .EXAMPLE
    Get-EmployeeData <employeeID>
    .NOTES
    For this script to function correctly, you must have a database configured
    with the correct tables/columns/data
    .LINK
    URL
    #>

    $employeeID = Read-Host "Please Enter Employee ID"
    
    $firstN = "a.F_N as EI_FN,b.F_N as OI_FN"
    $lastN = "a.L_N as EI_LN,b.L_N as OI_LN"
    $query = "SELECT OFFICE_ID,a.emp_id as EMP_ID,b.DEPT,b.JOB_TYPE,$firstN,$lastN,CITY,ST_ID,ZIP_CODE "
    $query += "FROM test_org..org_info as a,test_org..emp_info as b "
    $query += "WHERE a.emp_id=$employeeID AND a.emp_id=b.emp_id"

    $results = Invoke-SQLCmd -query $query -ServerInstance <#Server\Instance#>
    
    $results | format-list
}
export-modulemember -function Get-EmployeeData