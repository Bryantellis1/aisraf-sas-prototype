<#
.SYNOPSIS
    Scaffold a new AISRAF SAS run folder, resolved run profile, and run log.

.DESCRIPTION
    New-AisrafRun is a Build Package 03 setup helper. It prepares one local
    folder-first run scaffold:

      1. runs/<RunId>/
      2. runs/<RunId>/inputs/
      3. runs/<RunId>/dfd/
      4. runs/<RunId>/run-profile.yaml (resolved from
         config/run-profile.template.yaml)
      5. runs/<RunId>/00-run-log.md

    The script does not run prompt cards, skills, PRAs, .agent.md adapters,
    Jira, Confluence, Rovo, MCP, scoring, diagram generation, or release
    export. It does not modify the old reference workspace. It refuses to
    overwrite an existing runs/<RunId>/ folder.

.PARAMETER RunId
    Required. Pattern ^RUN-[A-Z0-9][A-Z0-9-]*$, length 5-64.

.PARAMETER SampleId
    Optional. Default sample-001-dfd-crop. Pattern ^sample-[0-9]{3}[a-z0-9-]*$,
    length 11-64.

.PARAMETER Mode
    Optional. One of the six v0.1.2 modes. Default folder_first_test.

.PARAMETER CopySampleInputs
    Switch. When set, copy files from samples/<SampleId>/inputs/ into
    runs/<RunId>/inputs/. When the sample inputs folder is missing, warn and
    leave inputs/ empty.

.EXAMPLE
    .\tools\New-AisrafRun.ps1 -RunId RUN-LOCAL-001

.EXAMPLE
    .\tools\New-AisrafRun.ps1 -RunId RUN-LOCAL-001 -CopySampleInputs

.EXAMPLE
    .\tools\New-AisrafRun.ps1 -RunId RUN-LOCAL-001 -Mode folder_first_review -WhatIf
#>
[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
param(
    [Parameter(Mandatory = $true)]
    [string]$RunId,

    [string]$SampleId = 'sample-001-dfd-crop',

    [ValidateSet(
        'folder_first_test',
        'folder_first_review',
        'integration_assisted_intake',
        'integration_assisted_postback',
        'dry_run_revalidation',
        'live_reviewer_run'
    )]
    [string]$Mode = 'folder_first_test',

    [switch]$CopySampleInputs
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Stop-Setup {
    param([Parameter(Mandatory = $true)][string]$Message)
    throw "New-AisrafRun: $Message"
}

function Assert-RelativeForwardSlashPath {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$Value
    )
    if ($Value -match '\\') {
        Stop-Setup "$Name must use forward slashes only (got '$Value')."
    }
    if ($Value -match '^[A-Za-z]:') {
        Stop-Setup "$Name must not begin with a drive letter (got '$Value')."
    }
    if ($Value.StartsWith('/')) {
        Stop-Setup "$Name must not begin with '/' (got '$Value')."
    }
    if ($Value -match '(^|/)\.\.(/|$)') {
        Stop-Setup "$Name must not contain '..' segments (got '$Value')."
    }
}

function Assert-WorkspaceChild {
    param(
        [Parameter(Mandatory = $true)][string]$WorkspaceRoot,
        [Parameter(Mandatory = $true)][string]$ChildPath,
        [Parameter(Mandatory = $true)][string]$Description
    )
    $rootFull = [System.IO.Path]::GetFullPath($WorkspaceRoot)
    $sep = [System.IO.Path]::DirectorySeparatorChar
    if (-not $rootFull.EndsWith($sep)) {
        $rootFull = $rootFull + $sep
    }
    $childFull = [System.IO.Path]::GetFullPath($ChildPath)
    if (-not $childFull.StartsWith($rootFull, [System.StringComparison]::OrdinalIgnoreCase)) {
        Stop-Setup "$Description resolves outside the active workspace: $childFull"
    }
}

function Set-YamlScalarValue {
    param(
        [Parameter(Mandatory = $true)][string]$Content,
        [Parameter(Mandatory = $true)][string]$Key,
        [AllowEmptyString()][string]$Value,
        [switch]$Unquoted
    )
    $escapedKey = [regex]::Escape($Key)
    if ($Content -notmatch "(?m)^$escapedKey\s*:") {
        Stop-Setup "Template key '$Key' not found in config/run-profile.template.yaml."
    }
    if ($Unquoted) {
        $rendered = $Value
    }
    else {
        $safe = $Value.Replace('\', '\\').Replace('"', '\"')
        $rendered = '"' + $safe + '"'
    }
    $newLine = "${Key}: $rendered"
    return [regex]::Replace(
        $Content,
        "(?m)^$escapedKey\s*:.*$",
        [System.Text.RegularExpressions.MatchEvaluator] { param($m) $newLine }
    )
}

if ($RunId -notmatch '^RUN-[A-Z0-9][A-Z0-9-]*$' -or $RunId.Length -lt 5 -or $RunId.Length -gt 64) {
    Stop-Setup "Invalid RunId '$RunId'. Pattern ^RUN-[A-Z0-9][A-Z0-9-]*$, length 5-64."
}
if ($SampleId -notmatch '^sample-[0-9]{3}[a-z0-9-]*$' -or $SampleId.Length -lt 11 -or $SampleId.Length -gt 64) {
    Stop-Setup "Invalid SampleId '$SampleId'. Pattern ^sample-[0-9]{3}[a-z0-9-]*$, length 11-64."
}

$packageRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$templatePath = Join-Path $packageRoot 'config/run-profile.template.yaml'
$runsRoot = Join-Path $packageRoot 'runs'
$runFolder = Join-Path $runsRoot $RunId
$inputsFolder = Join-Path $runFolder 'inputs'
$dfdFolder = Join-Path $runFolder 'dfd'
$profilePath = Join-Path $runFolder 'run-profile.yaml'
$logPath = Join-Path $runFolder '00-run-log.md'

Assert-WorkspaceChild -WorkspaceRoot $packageRoot -ChildPath $runFolder -Description 'Run folder'
Assert-WorkspaceChild -WorkspaceRoot $runsRoot -ChildPath $runFolder -Description 'Run folder under runs/'

if (-not (Test-Path -LiteralPath $templatePath -PathType Leaf)) {
    Stop-Setup "Template not found: $templatePath"
}
if (Test-Path -LiteralPath $runFolder) {
    Stop-Setup "Run folder already exists: $runFolder. Choose a different -RunId; -Force is not implemented in Build Package 03."
}

$inputRootValue = "runs/$RunId/inputs"
$expectedRootValue = "samples/$SampleId/expected"
$outputRootValue = "runs/$RunId"
$createdAt = [DateTime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ")

Assert-RelativeForwardSlashPath -Name 'input_root' -Value $inputRootValue
Assert-RelativeForwardSlashPath -Name 'expected_root' -Value $expectedRootValue
Assert-RelativeForwardSlashPath -Name 'output_root' -Value $outputRootValue

$template = Get-Content -LiteralPath $templatePath -Raw
$profile = $template
$profile = Set-YamlScalarValue -Content $profile -Key 'run_id'          -Value $RunId
$profile = Set-YamlScalarValue -Content $profile -Key 'sample_id'       -Value $SampleId
$profile = Set-YamlScalarValue -Content $profile -Key 'mode'            -Value $Mode
$profile = Set-YamlScalarValue -Content $profile -Key 'input_root'      -Value $inputRootValue
$profile = Set-YamlScalarValue -Content $profile -Key 'expected_root'   -Value $expectedRootValue
$profile = Set-YamlScalarValue -Content $profile -Key 'output_root'     -Value $outputRootValue
$profile = Set-YamlScalarValue -Content $profile -Key 'created_at'      -Value $createdAt

$sampleInputsSource = Join-Path $packageRoot "samples/$SampleId/inputs"
$copyInputsRequested = $CopySampleInputs.IsPresent
$sampleInputsAvailable = $copyInputsRequested -and (Test-Path -LiteralPath $sampleInputsSource -PathType Container)
if ($copyInputsRequested -and -not $sampleInputsAvailable) {
    Write-Warning "samples/$SampleId/inputs/ not found at $sampleInputsSource. inputs/ will be created empty; tool does not invent inputs."
}

$logBody = @"
# AISRAF SAS Run Log

run_id: $RunId
sample_id: $SampleId
mode: $Mode
input_root: $inputRootValue
expected_root: $expectedRootValue
output_root: $outputRootValue
package_version: v0.1.2
created_at: $createdAt
created_by: tools/New-AisrafRun.ps1 (Build Package 03)

## Setup posture

Build Package 03 created the run scaffold only.

- No prompt ran.
- No skill ran.
- No PRA (Prototype Review Agent) ran.
- No ``.agent.md`` adapter ran.
- No Jira, Confluence, Rovo, or MCP execution happened.
- No scoring happened.
- No diagram or release artifact was generated.

The operator must flip ``sensitive_data_confirmed_redacted`` from ``false`` to ``true`` in ``run-profile.yaml`` after confirming inputs are clean per ``config/sensitive-data-rules.md``. Tools refuse to claim execution of any kind on the operator's behalf.

## Step ledger

| Timestamp UTC | Step | Output file | Source prompt/skill/PRA | Reviewer gate | Status | Critical miss? | Notes |
|---|---|---|---|---|---|---|---|
| (none yet) | - | - | - | - | - | - | Build Package 03 setup only |
"@

if ($PSCmdlet.ShouldProcess($runFolder, 'Create run folder')) {
    $null = New-Item -ItemType Directory -Path $runFolder -Force
}
if ($PSCmdlet.ShouldProcess($inputsFolder, 'Create inputs folder')) {
    $null = New-Item -ItemType Directory -Path $inputsFolder -Force
}
if ($PSCmdlet.ShouldProcess($dfdFolder, 'Create dfd folder')) {
    $null = New-Item -ItemType Directory -Path $dfdFolder -Force
}
if ($PSCmdlet.ShouldProcess($profilePath, 'Write resolved run-profile.yaml')) {
    Set-Content -LiteralPath $profilePath -Value $profile -Encoding UTF8
}
if ($PSCmdlet.ShouldProcess($logPath, 'Initialize 00-run-log.md')) {
    Set-Content -LiteralPath $logPath -Value $logBody -Encoding UTF8
}

$copiedFileCount = 0
if ($sampleInputsAvailable) {
    if ($PSCmdlet.ShouldProcess($inputsFolder, "Copy sample inputs from samples/$SampleId/inputs/")) {
        $items = @(Get-ChildItem -LiteralPath $sampleInputsSource -Force)
        foreach ($item in $items) {
            Copy-Item -LiteralPath $item.FullName -Destination $inputsFolder -Recurse -Force
        }
        if (Test-Path -LiteralPath $inputsFolder -PathType Container) {
            $copiedFileCount = @(Get-ChildItem -LiteralPath $inputsFolder -File -Recurse -Force).Count
        }
    }
}

Write-Host ''
Write-Host 'AISRAF SAS run scaffold ready.' -ForegroundColor Green
Write-Host "  run_id                  : $RunId"
Write-Host "  sample_id               : $SampleId"
Write-Host "  mode                    : $Mode"
Write-Host "  input_root              : $inputRootValue"
Write-Host "  expected_root           : $expectedRootValue"
Write-Host "  output_root             : $outputRootValue"
Write-Host "  created_at              : $createdAt"
Write-Host "  copy_sample_inputs      : $copyInputsRequested"
Write-Host "  files_copied_to_inputs  : $copiedFileCount"
Write-Host "  run-profile             : $profilePath"
Write-Host "  run-log                 : $logPath"
Write-Host ''
Write-Host 'Next: validate the profile with tools/Test-AisrafRunProfile.ps1 -RunProfilePath ' -NoNewline -ForegroundColor Cyan
Write-Host "$profilePath" -ForegroundColor Cyan
Write-Host 'Operator must set sensitive_data_confirmed_redacted: true in run-profile.yaml before any later run begins.' -ForegroundColor Yellow
