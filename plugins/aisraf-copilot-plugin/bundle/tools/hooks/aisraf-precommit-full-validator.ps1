[CmdletBinding()]
param(
    [string]$PackageRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$previousLocation = Get-Location
try {
    Push-Location $PackageRoot
    & pwsh -NoProfile -File 'tools/Test-AisrafBp12AReadiness.ps1'
    $validatorExit = $LASTEXITCODE
    if ($validatorExit -eq 0) {
        Write-Output 'PASS aisraf-precommit-full-validator validator=tools/Test-AisrafBp12AReadiness.ps1'
        exit 0
    }

    Write-Output "FAIL aisraf-precommit-full-validator validator=tools/Test-AisrafBp12AReadiness.ps1 exit_code=$validatorExit"
    exit $validatorExit
}
catch {
    Write-Output "FAIL aisraf-precommit-full-validator reason=$($_.Exception.Message)"
    exit 1
}
finally {
    Set-Location $previousLocation
}
