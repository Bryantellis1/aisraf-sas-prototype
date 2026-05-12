<#
.SYNOPSIS
    Assemble the AISRAF Copilot plugin bundle by reference (WP-12C-K3C).

.DESCRIPTION
    Build-AisrafCopilotPluginBundle copies governed canonical and projection
    surfaces into plugins/aisraf-copilot-plugin/bundle/, preserving source-root
    path shape, then emits plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml
    recording source_path, target_path, source_sha256, and target_sha256 for
    every bundled file.

    The script is deterministic. It uses an explicit allow-list of source
    surfaces (folders) and source files. It excludes runs/, samples/,
    validation/, release/, diagrams/, docs/, .git/, .claude/, and the plugin
    folder itself. It fails closed when:

      - a copied source path is outside the approved allow-list;
      - the target path does not preserve source-root shape under bundle/;
      - the recomputed source SHA-256 does not equal the recomputed target
        SHA-256 (drift between source and bundle);
      - a manifest entry cannot be written.

    The script does not stage files, install the plugin, run smoke tests,
    generate diagrams, or create release artifacts. Bundle authority remains
    a projection of the canonical sources outside plugins/aisraf-copilot-plugin/.

.PARAMETER Clean
    When specified, removes plugins/aisraf-copilot-plugin/bundle/ and
    plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml before assembly.
    Use to force a clean rebuild from canonical sources.

.OUTPUTS
    Exit 0 on successful assembly with all hashes matching.
    Exit 1 on any closed-fail condition.
#>
[CmdletBinding()]
param(
    [switch]$Clean
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$packageRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$pluginRootRelative = 'plugins/aisraf-copilot-plugin'
$bundleRootRelative = "$pluginRootRelative/bundle"
$manifestRelative = "$pluginRootRelative/bundle-checksum-manifest.yaml"

$pluginRootAbs = Join-Path $packageRoot ($pluginRootRelative -replace '/', [System.IO.Path]::DirectorySeparatorChar)
$bundleRootAbs = Join-Path $packageRoot ($bundleRootRelative -replace '/', [System.IO.Path]::DirectorySeparatorChar)
$manifestAbs = Join-Path $packageRoot ($manifestRelative -replace '/', [System.IO.Path]::DirectorySeparatorChar)

# Approved bundle source surfaces. Folder entries are recursed; file entries
# are bundled exactly. These mirror the bundle source allow-list governed by
# Test-AisrafPackage.ps1 Check 16 and the K3A projection assembly contract.
$approvedSourceFolders = @(
    '.github/agents',
    '.github/skills',
    '.github/hooks',
    '.copilot-skills',
    '.agents',
    'prompts',
    'skills',
    'prototype-agents',
    'templates',
    'catalogs',
    'blueprints',
    'tools/hooks'
)
$approvedSourceFiles = @(
    'tools/Test-AisrafPackage.ps1',
    'tools/Test-AisrafBp12AReadiness.ps1',
    'tools/Test-AisrafRunProfile.ps1',
    'tools/Invoke-AisrafAm3LocalRun.ps1',
    'tools/Test-AisrafAm3Runtime.ps1'
)

# Excluded surfaces. Listed here for falsifiability; the build never copies
# from these paths because they are not in the allow-list.
$excludedSourceSurfaces = @(
    'runs/',
    'samples/',
    'validation/',
    'release/',
    'diagrams/',
    'docs/',
    '.git/',
    '.claude/',
    'plugins/aisraf-copilot-plugin/'
)

function Convert-ToRelativePath {
    param([Parameter(Mandatory = $true)][string]$AbsolutePath)
    return $AbsolutePath.Substring($packageRoot.Length + 1).Replace('\', '/')
}

function Test-PathIsApprovedSource {
    param([Parameter(Mandatory = $true)][string]$RelativePath)
    if ($approvedSourceFiles -contains $RelativePath) { return $true }
    foreach ($folder in $approvedSourceFolders) {
        if ($RelativePath.StartsWith("$folder/", [System.StringComparison]::OrdinalIgnoreCase) -or
            $RelativePath -ieq $folder) {
            return $true
        }
    }
    return $false
}

function Get-Sha256ForFile {
    param([Parameter(Mandatory = $true)][string]$AbsolutePath)
    return (Get-FileHash -LiteralPath $AbsolutePath -Algorithm SHA256).Hash.ToLowerInvariant()
}

function Stop-Build {
    param([Parameter(Mandatory = $true)][string]$Reason)
    Write-Host "FAIL  Build-AisrafCopilotPluginBundle: $Reason" -ForegroundColor Red
    exit 1
}

# Sanity: plugin scaffold must already exist (created by WP-12C-K2).
if (-not (Test-Path -LiteralPath $pluginRootAbs -PathType Container)) {
    Stop-Build "Plugin scaffold folder is missing: $pluginRootRelative"
}

# Optional clean. Removes the bundle target and the manifest only.
if ($Clean) {
    if (Test-Path -LiteralPath $bundleRootAbs -PathType Container) {
        Remove-Item -LiteralPath $bundleRootAbs -Recurse -Force
    }
    if (Test-Path -LiteralPath $manifestAbs -PathType Leaf) {
        Remove-Item -LiteralPath $manifestAbs -Force
    }
}

# Refuse to clobber an existing bundle target without -Clean.
if ((Test-Path -LiteralPath $bundleRootAbs -PathType Container) -and -not $Clean) {
    Stop-Build "Bundle target already exists at $bundleRootRelative. Re-run with -Clean to rebuild."
}
if ((Test-Path -LiteralPath $manifestAbs -PathType Leaf) -and -not $Clean) {
    Stop-Build "Bundle checksum manifest already exists at $manifestRelative. Re-run with -Clean to rebuild."
}

# Resolve the deterministic, sorted list of files to bundle.
$plannedSourceFilesAbs = New-Object System.Collections.Generic.List[string]

foreach ($folderRelative in $approvedSourceFolders) {
    $folderAbs = Join-Path $packageRoot ($folderRelative -replace '/', [System.IO.Path]::DirectorySeparatorChar)
    if (-not (Test-Path -LiteralPath $folderAbs -PathType Container)) {
        Stop-Build "Approved source folder missing on disk: $folderRelative"
    }
    foreach ($file in @(Get-ChildItem -LiteralPath $folderAbs -Recurse -Force -File -ErrorAction Stop |
            Sort-Object -Property FullName)) {
        $plannedSourceFilesAbs.Add($file.FullName)
    }
}
foreach ($fileRelative in $approvedSourceFiles) {
    $fileAbs = Join-Path $packageRoot ($fileRelative -replace '/', [System.IO.Path]::DirectorySeparatorChar)
    if (-not (Test-Path -LiteralPath $fileAbs -PathType Leaf)) {
        Stop-Build "Approved source file missing on disk: $fileRelative"
    }
    $plannedSourceFilesAbs.Add($fileAbs)
}

# Sort by relative path for deterministic manifest ordering.
$plannedEntries = New-Object System.Collections.Generic.List[hashtable]
foreach ($sourceAbs in $plannedSourceFilesAbs) {
    $sourceRelative = Convert-ToRelativePath -AbsolutePath $sourceAbs
    if (-not (Test-PathIsApprovedSource -RelativePath $sourceRelative)) {
        Stop-Build "Source path is outside the approved allow-list: $sourceRelative"
    }
    foreach ($excluded in $excludedSourceSurfaces) {
        $excludedTrimmed = $excluded.TrimEnd('/')
        if ($sourceRelative -ieq $excludedTrimmed -or $sourceRelative.StartsWith("$excludedTrimmed/", [System.StringComparison]::OrdinalIgnoreCase)) {
            Stop-Build "Source path falls under an excluded surface: $sourceRelative ($excluded)"
        }
    }
    $targetRelative = "$bundleRootRelative/$sourceRelative"
    $expectedTargetPrefix = "$bundleRootRelative/"
    if (-not $targetRelative.StartsWith($expectedTargetPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        Stop-Build "Target path does not preserve source-root shape: $targetRelative"
    }
    $plannedEntries.Add(@{ source_relative = $sourceRelative; source_absolute = $sourceAbs; target_relative = $targetRelative })
}

$plannedEntries = @($plannedEntries | Sort-Object -Property { $_['source_relative'] })

# Create the bundle root.
if (-not (Test-Path -LiteralPath $bundleRootAbs -PathType Container)) {
    [void](New-Item -ItemType Directory -Path $bundleRootAbs -Force)
}

# Copy each file and record hashes.
$manifestEntries = New-Object System.Collections.Generic.List[hashtable]
foreach ($entry in $plannedEntries) {
    $sourceAbs = $entry['source_absolute']
    $sourceRelative = $entry['source_relative']
    $targetRelative = $entry['target_relative']
    $targetAbs = Join-Path $packageRoot ($targetRelative -replace '/', [System.IO.Path]::DirectorySeparatorChar)

    $targetParent = Split-Path -Parent $targetAbs
    if (-not (Test-Path -LiteralPath $targetParent -PathType Container)) {
        [void](New-Item -ItemType Directory -Path $targetParent -Force)
    }

    $sourceSha256 = Get-Sha256ForFile -AbsolutePath $sourceAbs
    Copy-Item -LiteralPath $sourceAbs -Destination $targetAbs -Force
    $targetSha256 = Get-Sha256ForFile -AbsolutePath $targetAbs

    if ($sourceSha256 -ne $targetSha256) {
        Stop-Build "Source and target SHA-256 differ for $sourceRelative -> $targetRelative (source=$sourceSha256 target=$targetSha256)"
    }

    $manifestEntries.Add(@{
        source_path   = $sourceRelative
        target_path   = $targetRelative
        source_sha256 = $sourceSha256
        target_sha256 = $targetSha256
    })
}

# Emit the checksum manifest. Flat-scalar YAML; no external module required.
$generatedAtUtc = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
$lines = New-Object System.Collections.Generic.List[string]
[void]$lines.Add('# AISRAF Copilot Plugin Bundle Checksum Manifest (WP-12C-K3C)')
[void]$lines.Add('#')
[void]$lines.Add('# Generated by tools/Build-AisrafCopilotPluginBundle.ps1.')
[void]$lines.Add('# Source authority remains outside plugins/aisraf-copilot-plugin/.')
[void]$lines.Add('# Bundle is a projection by reference. Source and target hashes')
[void]$lines.Add('# must match for every entry; drift fails the package validator.')
[void]$lines.Add('')
[void]$lines.Add("plugin_id: aisraf-copilot-plugin")
[void]$lines.Add("work_package: WP-12C-K3C")
[void]$lines.Add("bundle_target: $bundleRootRelative")
[void]$lines.Add("manifest_path: $manifestRelative")
[void]$lines.Add("generated_at_utc: $generatedAtUtc")
[void]$lines.Add("entry_count: $($manifestEntries.Count)")
[void]$lines.Add('hash_algorithm: sha256')
[void]$lines.Add('entries:')
foreach ($entry in $manifestEntries) {
    [void]$lines.Add("  - source_path: $($entry['source_path'])")
    [void]$lines.Add("    target_path: $($entry['target_path'])")
    [void]$lines.Add("    source_sha256: $($entry['source_sha256'])")
    [void]$lines.Add("    target_sha256: $($entry['target_sha256'])")
}

[System.IO.File]::WriteAllText($manifestAbs, ($lines -join "`n") + "`n", (New-Object System.Text.UTF8Encoding($false)))

Write-Host ''
Write-Host "Build-AisrafCopilotPluginBundle  package_root=$packageRoot" -ForegroundColor Cyan
Write-Host "  bundle_target  : $bundleRootRelative" -ForegroundColor Cyan
Write-Host "  manifest_path  : $manifestRelative" -ForegroundColor Cyan
Write-Host "  entry_count    : $($manifestEntries.Count)" -ForegroundColor Cyan
Write-Host "  hash_algorithm : sha256" -ForegroundColor Cyan
Write-Host ''
Write-Host "Build-AisrafCopilotPluginBundle: PASS  $($manifestEntries.Count) files bundled, all source/target SHA-256 match." -ForegroundColor Green
exit 0
