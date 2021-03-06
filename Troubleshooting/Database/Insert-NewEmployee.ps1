﻿function Insert-NewEmployee{

    <#
    .SYNOPSIS
    Insert new employee in database
    .DESCRIPTION
    This script will prompt for details about a new user and then insert them
    into the employee database
    .EXAMPLE
    Insert-NewEmployee
    .NOTES
    For this script to function correctly, you must have a database configured
    with the correct tables/columns/data
    .LINK
    URL
    #>

    $fn = Read-Host "First Name:"
    $fn = "'$fn'"
    $ln = Read-Host "Last Name:"
    $ln = "'$ln'"
    $empID = Read-Host "Employee ID:"
    $oID = Read-Host "Office ID:"
    $city = Read-Host "City:"
    $city = "'$city'"
    $state = Read-Host "State:"
    $state = "'$state'"
    $zipCode = Read-Host "Zip Code:"
    $dept = Read-Host "Department:"
    $jobType = Read-Host "Job Type(code):"

    $insertEmpInfo = "INSERT INTO test_org..emp_info"
    $insertOrgInfo = "INSERT INTO test_org..org_info"
    $empValues = "VALUES($fn,$ln,$empID,$dept,$jobType)"
    $orgValues = "VALUES($oID,$state,$zipCode,$city,$empID,$fn,$ln)"


    $qryOne = "$insertEmpInfo $empValues"
    $qryTwo = "$insertOrgInfo $orgValues"

    Invoke-SQLCMD -query $qryOne -ServerInstance Server\Instance
    Invoke-SQLCMD -query $qryTwo -ServerInstance Server\Instance
}
export-modulemember -function Insert-NewEmployee