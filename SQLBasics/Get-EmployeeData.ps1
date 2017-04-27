function Get-EmployeeData
{
    $employeeID = Read-Host "Please Enter Employee ID"
    
    $firstN = "a.F_N as EI_FN,b.F_N as OI_FN"
    $lastN = "a.L_N as EI_LN,b.L_N as OI_LN"
    $query = "SELECT OFFICE_ID,a.emp_id as EMP_ID,b.DEPT,b.JOB_TYPE,$firstN,$lastN,CITY,ST_ID,ZIP_CODE "
    $query += "FROM test_org..org_info as a,test_org..emp_info as b "
    $query += "WHERE a.emp_id=$employeeID AND a.emp_id=b.emp_id"

    $results = Invoke-SQLCmd -query $query -ServerInstance Server\Instance
    
    $results | format-list
}
Get-EmployeeData