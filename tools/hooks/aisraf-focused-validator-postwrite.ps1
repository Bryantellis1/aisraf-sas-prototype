[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$TargetPath,
    [string]$PackageRoot = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-HookListSection {
    param(
        [Parameter(Mandatory = $true)][string]$SectionName,
        [Parameter(Mandatory = $true)][string]$ListPath
    )

    if (-not (Test-Path -LiteralPath $ListPath -PathType Leaf)) {
        throw "Hook allow-list missing: $ListPath"
    }

    $values = New-Object System.Collections.Generic.List[string]
    $activeSection = ''
    foreach ($line in @(Get-Content -LiteralPath $ListPath)) {
        if ($line -match '^([A-Za-z0-9_-]+):\s*$') {
            $activeSection = $Matches[1]
            continue
        }
        if ($activeSection -eq $SectionName -and $line -match '^\s*-\s*"(.+)"\s*$') {
            $values.Add($Matches[1])
        }
    }

    if ($values.Count -eq 0) {
        throw "Hook allow-list section has no values: $SectionName"
    }
    return @($values)
}

function ConvertTo-RepoPath {
    param(
        [Parameter(Mandatory = $true)][string]$PathValue,
        [Parameter(Mandatory = $true)][string]$RootPath
    )

    $raw = $PathValue.Trim().Replace('\', '/')
    if ($raw -match '(^|/)\.\.(/|$)') {
        throw "Target path contains parent traversal: $PathValue"
    }

    $rootFull = [System.IO.Path]::GetFullPath($RootPath).TrimEnd('\', '/')
    if ([System.IO.Path]::IsPathRooted($PathValue)) {
        $full = [System.IO.Path]::GetFullPath($PathValue)
    }
    else {
        $full = [System.IO.Path]::GetFullPath((Join-Path $rootFull $PathValue))
    }
    $full = $full.TrimEnd('\', '/')

    if ($full.StartsWith($rootFull, [System.StringComparison]::OrdinalIgnoreCase) -eq $false) {
        throw "Target path is outside package root: $PathValue"
    }

    return $full.Substring($rootFull.Length).TrimStart('\', '/').Replace('\', '/')
}

try {
    $allowListPath = Join-Path $PackageRoot 'tools/hooks/hook-allow-list.yaml'
    $routes = @(Get-HookListSection -SectionName 'validator_routes' -ListPath $allowListPath)
    $repoPath = ConvertTo-RepoPath -PathValue $TargetPath -RootPath $PackageRoot
    $matchingRoute = $null

    foreach ($route in $routes) {
        $parts = @($route -split '\|', 3)
        if ($parts.Count -lt 2) { continue }
        if ($repoPath -match $parts[0]) {
            $matchingRoute = $parts
            break
        }
    }

    if ($null -eq $matchingRoute) {
        Write-Output "FAIL aisraf-focused-validator-postwrite target=$repoPath reason=no_validator_route"
        exit 1
    }

    $validatorPath = Join-Path $PackageRoot $matchingRoute[1]
    if (-not (Test-Path -LiteralPath $validatorPath -PathType Leaf)) {
        Write-Output "FAIL aisraf-focused-validator-postwrite target=$repoPath reason=validator_missing"
        exit 1
    }

    $validatorArgs = @('-NoProfile', '-File', $validatorPath)
    if ($matchingRoute.Count -eq 3 -and $matchingRoute[2].Trim().Length -ne 0) {
        foreach ($token in @($matchingRoute[2] -split ' ' | Where-Object { $_.Trim().Length -ne 0 })) {
            if ($token -eq '{target}') {
                $validatorArgs += (Join-Path $PackageRoot $repoPath)
            }
            else {
                $validatorArgs += $token
            }
        }
    }

    & pwsh @validatorArgs
    $validatorExit = $LASTEXITCODE
    if ($validatorExit -eq 0) {
        Write-Output "PASS aisraf-focused-validator-postwrite target=$repoPath validator=$($matchingRoute[1])"
        exit 0
    }

    Write-Output "FAIL aisraf-focused-validator-postwrite target=$repoPath validator=$($matchingRoute[1]) exit_code=$validatorExit"
    exit $validatorExit
}
catch {
    Write-Output "FAIL aisraf-focused-validator-postwrite reason=$($_.Exception.Message)"
    exit 1
}
