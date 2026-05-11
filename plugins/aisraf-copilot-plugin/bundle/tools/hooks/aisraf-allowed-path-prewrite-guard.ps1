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
    $patterns = @(Get-HookListSection -SectionName 'allowed_write_patterns' -ListPath $allowListPath)
    $repoPath = ConvertTo-RepoPath -PathValue $TargetPath -RootPath $PackageRoot

    foreach ($pattern in $patterns) {
        if ($repoPath -match $pattern) {
            Write-Output "PASS aisraf-allowed-path-prewrite-guard target=$repoPath"
            exit 0
        }
    }

    Write-Output "FAIL aisraf-allowed-path-prewrite-guard target=$repoPath reason=not_on_allow_list"
    exit 1
}
catch {
    Write-Output "FAIL aisraf-allowed-path-prewrite-guard reason=$($_.Exception.Message)"
    exit 1
}
