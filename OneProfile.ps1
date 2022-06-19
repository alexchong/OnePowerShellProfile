param(
    [string] $PSProfileRootPath = $env:USERPROFILE + '\OneDrive - Microsoft\Documents\', # default to OneDrive Documents
    [string] $SourceProfile = 'profile.txt',
    [switch] $Reset
)

$ONEPROFILE_PATH = '' # replace emptry string with absolute path to OneProfile/
$SourceProfile = $global:ONEPROFILE_PATH + "/" + $SourceProfile

function Test-InstalledProgram {
    $Name = $args[0]

    if ($null -eq $Name -or $Name -eq '') {
        Write-Error 'Parameter not found. Provide a variation of the installed program name as an argument.'
    }

    $localMachineKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
    $currentUserKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
  
    $getLocalMachineKey = Get-ItemProperty $localMachineKey |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | ? { $_.DisplayName -match $Name }
    $getCurrentUserKey = Get-ItemProperty $currentUserKey |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | ? { $_.DisplayName -match $Name }
  
    if ($null -ne $getLocalMachineKey) {
        Write-Host "Found registry match in HKLM (local machine) for program '$Name'" -ForegroundColor Green
        $getLocalMachineKey
        return $true
    }
    elseif ($null -ne $getCurrentUserKey) {
        Write-Host "Found registry match in HKCU (current user) for program '$Name'" -ForegroundColor Green
        $getCurrentUserKey
        return $true
    }
    else {
        Write-Host "Registry match not found '$Name'." -Foreground Red
        return $false
    }
}
  
function Invoke-OneProfileConfiguration {

    $RunAs = ''
    $File = $global:ONEPROFILE_PATH + "\" + $SourceFile

    if ($null -eq $args[0]) {
        $RunAs = "code" # default to vscode
        Write-Host "Set '$RunAs' as target editor" -ForegroundColor Yellow
    }
    else {
        $RunAs = $args[0]
    }

    if ((Test-InstalledProgram {Visual Studio Code}) -eq $true -and $RunAs -eq "code") {
        Write-Host "Opening '$File' on Visual Studio Code" -ForegroundColor Green
        code $File
    }
    else {
        Write-Host "Opening '$File' on default text editor" -ForegroundColor Green
        Invoke-Item $File
    }
}

function Set-OneProfile {
    try {
        # Check for valid Documents path w/ PowerShell modules
        $DocumentsArg = $PSProfileRootPath
        $DocumentsOneDrive = $env:USERPROFILE + '\OneDrive - Microsoft\Documents\WindowsPowerShell\'
        $DocumentsLocal = $env:USERPROFILE + '\OneDrive - Microsoft\Documents\WindowsPowerShell\'

        if (Test-Path $DocumentsArg) {
            # Write-Host "Found $DocumentsArg" -ForegroundColor Green
        }
        elseif (Test-Path $DocumentsOneDrive) {
            # Write-Host "Found $DocumentsOneDrive" -ForegroundColor Green
            $PSProfileRootPath = $env:USERPROFILE + '\OneDrive - Microsoft\Documents\'
        }
        elseif (Test-Path $DocumentsLocal) {
            # Write-Host "Found $DocumentsLocal" -ForegroundColor Green
            $PSProfileRootPath = $env:USERPROFILE + '\Documents\'
        }
        else {
            Write-Error "Cannot find valid Documents path with WindowsPowerShell."
            throw
        }

        $ISE = $PSProfileRootPath + 'WindowsPowerShell\Microsoft.PowerShellISE_profile.ps1'
        $Desktop = $PSProfileRootPath + 'WindowsPowerShell\Microsoft.PowerShell_profile.ps1'
        $Core = $PSProfileRootPath + 'PowerShell\Microsoft.PowerShell_profile.ps1'

        $PSProfiles = $ISE, $Desktop, $Core

        foreach ($TargetProfile in $PSProfiles) {
            if (Test-Path $TargetProfile) {
                # Write-Host "Overwriting" $TargetProfile
                Get-Content $SourceProfile > $TargetProfile
            }
            else {
                # Write-Host "'$TargetProfile' path does not exist. Continue." -ForegroundColor Yellow
            }
        }
    }
    catch {
        throw
    }
}

Set-OneProfile