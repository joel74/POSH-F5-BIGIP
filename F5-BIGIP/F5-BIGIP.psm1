<#
.SYNOPSIS  
    A module for using the F5 iControlRESTT API to administer BIGIP devices
.DESCRIPTION  
    This module uses the F5 iControlREST REST API to work with BIGIP devices and their various modules
    It is built to work with version 11.6
.NOTES  
    File Name    : F5-LTM.psm1
    Author       : Joel Newton - jnewton@springcm.com
    Requires     : PowerShell V3
    Dependencies : It includes a Validation.cs class file (based on code posted by Brian Scholer) to allow for using the REST API 
    with LTM devices using self-signed SSL certificates.
#>

$Script:F5Session=$null

Add-Type -Path "${PSScriptRoot}\Validation.cs"
Add-Type -Path "${PSScriptRoot}\TypeData\PoshLTM.Types.cs"
Update-FormatData "${PSScriptRoot}\TypeData\PoshLTM.Format.ps1xml"
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