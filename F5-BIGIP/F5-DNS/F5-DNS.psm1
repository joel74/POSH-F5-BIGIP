<#
.SYNOPSIS  
    A module for using the F5 iControlREST API to administer the DNS module of a BIG-IP device
.DESCRIPTION  
    This module uses the F5 iControlREST API to manipulate and query pools, pool members, wide IP and other objects
    It is built to work with version ???
.NOTES  
    File Name    : F5-DNS.psm1
    Author       : TBD
    Requires     : PowerShell V3
#>

#JN: This is being set in the parent F5-BIGIP module
#$Script:F5Session=$null

$ScriptPath = Split-Path $MyInvocation.MyCommand.Path

#region Load Public Functions

try {
    Get-ChildItem "$ScriptPath\Public" -Filter *.ps1 -Recurse| Select-Object -Expand FullName | ForEach-Object {
        $Function = Split-Path $_ -Leaf
        . $_
    }
} catch {
    Write-Warning ("{0}: {1}" -f $Function,$_.Exception.Message)
    Continue
}

#endregion

#region Load Private Functions

try {
   Get-ChildItem "$ScriptPath\Private" -Filter *.ps1 -Recurse | Select-Object -Expand FullName | ForEach-Object {
       $Function = Split-Path $_ -Leaf
       . $_
   }
} catch {
   Write-Warning ("{0}: {1}" -f $Function,$_.Exception.Message)
   Continue
}

#endregion