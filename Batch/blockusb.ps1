<#

        .SYNOPSIS
        Enable or Disable access to Removable Storage

        .DESCRIPTION
        This is a simple Powershell script to enable or disable access to Removable Storage.
        It make use of the following two policies:
          - http://gpsearch.azurewebsites.net/#7963
          - http://gpsearch.azurewebsites.net/#7965

        .PARAMETER Check
        Query the status of the policy

        .PARAMETER Disable
        Disable the policy for Removable Storage, access to the drive is permitted

        .PARAMETER Enable
        Enable the policy for Removable Storage, access to the drive is prohibited

        .PARAMETER Query
        Query the status of the policy

        .EXAMPLE
        Query the status of the policy

            PS C:\> .\Block-USB.ps1 -Check
            The policy is Disabled...

        .EXAMPLE
        Disable the policy

            PS C:\> .\Block-USB.ps1 -Disable
            Policy is set to Disabled...

        .EXAMPLE
        Enable the policy

            PS C:\> .\Block-USB.ps1 -Enable
            Policy is set to Enabled...

        .EXAMPLE
        Query the status of the policy

            PS C:\> .\Block-USB.ps1 -Query
            The policy is Disabled...

        .NOTES
        Author: Branko Vucinec
        Blog  : https://blog.brankovucinec.com/

        .LINK
        https://blog.brankovucinec.com/

#>
#Requires -Version 5 -RunAsAdministrator

[CmdletBinding()]
Param(
    [Switch]$Check,
    [Switch]$Disable,
    [Switch]$Enable,
    [Switch]$Query)

Function Test-RegistryValue {
     param
     (
         [Object]
         $regkey,

         [Object]
         $name
     )

    $exists = Get-ItemProperty -Path "$regkey" -Name "$name" -ErrorAction SilentlyContinue
    If (($exists -ne $null) -and ($exists.Length -ne 0)) {
        Return Write-Host 'The policy is Enabled...' -BackgroundColor Green -ForegroundColor Black
    }
    Return Write-Host 'The policy is Disabled...' -BackgroundColor Green -ForegroundColor Black
}

Function Create-RegistryValue {
     param
     (
         [Object]
         $regkey,

         [Object]
         $name
     )
    $exists = Test-Path $regkey
    if (!$exists) {
        New-Item -Path 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices' -Name '{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}' -Force | Out-Null
    }
    New-ItemProperty -Path $regkey -Name $name -Value 1 -PropertyType 'DWord' -Force | Out-Null
}

Function Delete-RegistryValue {
     param
     (
         [Object]
         $regkey
     )
     $exists = Test-Path $regkey
    if ($exists) {
        Remove-Item -Path $regkey -Recurse -Force | Out-Null
    }
}

if (($Enable) -and ($Disable)) { 
    Write-Host 'It is not possible to use the parameter -Enable together with -Disable at the command line' -ForegroundColor Red
    Break
} Elseif ($Enable) { 
    Create-RegistryValue -regkey 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Read'
    Create-RegistryValue -regkey 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Write'
    Write-Host 'Policy is set to Enabled...' -BackgroundColor Green -ForegroundColor Black 
    Break
} Elseif ($Disable) {
    Delete-RegistryValue -regkey 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}'
    Write-Host 'Policy is set to Disabled...' -BackgroundColor Red -ForegroundColor Black
    Break
} Elseif (($Check) -or ($Query)) {
    Test-RegistryValue -regkey 'HKLM:\Software\Policies\Microsoft\Windows\RemovableStorageDevices\{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}' -Name 'Deny_Read'
    Break
} Elseif ((!$Enable) -and (!$Disable)) {
    Write-Host 'No parameter used, use -Enable or -Disable at the command line' -ForegroundColor Red
}
