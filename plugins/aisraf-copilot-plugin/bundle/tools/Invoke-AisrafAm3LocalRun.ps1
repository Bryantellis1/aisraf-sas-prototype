<#
.SYNOPSIS
    Create a local-only AM3 runtime scaffold under a selected output_root.

.DESCRIPTION
    Invoke-AisrafAm3LocalRun loads a run profile plus all four AM3
    contracts/schemas, validates the local-only posture, and writes only the
    AM3 runtime harness files under output_root/runtime/.

    The runner scaffolds orchestrator state, events, and AM3-01..AM3-06
    handoff request/response pairs. It does not run the full AISRAF review
    chain and does not execute prompts, skills, PRAs, adapters, Jira,
    Confluence, Lucidchart, Rovo MCP, cloud, databases, Terraform, event bus,
    telemetry, post-back, push, publish, staging, or release packaging.

    Human gates require an explicit -HumanGateDecision argument. A denial
    records a terminal stop event and exits non-zero.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$RunProfilePath,

    [Parameter(Mandatory = $true)]
    [ValidateSet('approve', 'deny')]
    [string]$HumanGateDecision,

    [ValidateSet('pre_run_approval', 'pre_output_generation_approval', 'final_review_approval', 'release_or_claim_approval', 'final_pass_partial_fail_not_applicable_decision')]
    [string]$DenyGateId = 'pre_run_approval',

    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$PackageRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$EventLines = New-Object System.Collections.Generic.List[string]
$EventOrdinal = 0
$LastCheckpointId = $null

function Resolve-PackagePath {
    param([Parameter(Mandatory = $true)][string]$RelativePath)
    return (Join-Path $script:PackageRoot ($RelativePath -replace '/', [System.IO.Path]::DirectorySeparatorChar))
}

function Normalize-RepoPath {
    param([Parameter(Mandatory = $true)][string]$PathValue)
    $normalized = $PathValue.Trim().Trim('"').Trim("'").Replace('\', '/')
    while ($normalized.StartsWith('./', [System.StringComparison]::Ordinal)) {
        $normalized = $normalized.Substring(2)
    }
    return $normalized.TrimEnd('/')
}

function ConvertFrom-FlatYaml {
    param([Parameter(Mandatory = $true)][string]$Path)
    $hash = [System.Collections.Specialized.OrderedDictionary]::new()
    $lineNo = 0
    foreach ($raw in (Get-Content -LiteralPath $Path)) {
        $lineNo++
        $trimmed = $raw -replace '\s+$', ''
        if ($trimmed -eq '') { continue }
        if ($trimmed -match '^\s*#') { continue }
        if ($trimmed -match '^\s+\S') {
            throw "Indented YAML is not supported by the flat parser at line $lineNo`: $raw"
        }
        if ($trimmed -notmatch '^([A-Za-z_][A-Za-z0-9_]*)\s*:\s*(.*)$') {
            throw "Unparseable YAML line $lineNo`: $raw"
        }
        $key = $Matches[1]
        $val = $Matches[2].Trim()
        if ($val -match '^"(.*)"\s*$') {
            $hash[$key] = $Matches[1].Replace('\\"', '"')
        }
        elseif ($val -match "^'(.*)'\s*$") {
            $hash[$key] = $Matches[1]
        }
        elseif ($val -eq 'true') {
            $hash[$key] = $true
        }
        elseif ($val -eq 'false') {
            $hash[$key] = $false
        }
        elseif ($val -eq 'null' -or $val -eq '~') {
            $hash[$key] = $null
        }
        else {
            $hash[$key] = $val
        }
    }
    return $hash
}

function Write-Utf8NoBom {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Content
    )
    $parent = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $parent -PathType Container)) {
        [void](New-Item -ItemType Directory -Path $parent -Force)
    }
    [System.IO.File]::WriteAllText($Path, $Content, (New-Object System.Text.UTF8Encoding($false)))
}

function Test-PathUnderRoot {
    param(
        [Parameter(Mandatory = $true)][string]$ChildPath,
        [Parameter(Mandatory = $true)][string]$RootPath
    )
    $childFull = [System.IO.Path]::GetFullPath($ChildPath)
    $rootFull = [System.IO.Path]::GetFullPath($RootPath).TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar
    return $childFull.StartsWith($rootFull, [System.StringComparison]::OrdinalIgnoreCase)
}

function Assert-LocalRelativePath {
    param(
        [Parameter(Mandatory = $true)][string]$PathValue,
        [Parameter(Mandatory = $true)][string]$Name
    )
    if ([string]::IsNullOrWhiteSpace($PathValue)) { throw "$Name is empty." }
    if ($PathValue -match '\\') { throw "$Name uses backslash separators: $PathValue" }
    if ($PathValue -match '^[A-Za-z]:') { throw "$Name starts with a drive letter: $PathValue" }
    if ($PathValue.StartsWith('/')) { throw "$Name starts with '/': $PathValue" }
    if ($PathValue -match '(^|/)\.\.(/|$)') { throw "$Name contains parent traversal: $PathValue" }
    if ($PathValue -match '(?i)\bhttps?://') { throw "$Name contains a URL: $PathValue" }
}

function Assert-OutputRootAllowed {
    param([Parameter(Mandatory = $true)][string]$OutputRootRelative)
    Assert-LocalRelativePath -PathValue $OutputRootRelative -Name 'output_root'
    $forbiddenOutputPrefixes = @(
        'runs/RUN-001',
        'samples',
        'prompts',
        'skills',
        'prototype-agents',
        'templates',
        'catalogs',
        'blueprints',
        '.agents',
        '.github/agents',
        '.github/skills',
        '.github/hooks',
        '.copilot-skills',
        'config',
        'projections',
        'docs',
        'release',
        'plugins/aisraf-copilot-plugin'
    )
    foreach ($prefix in $forbiddenOutputPrefixes) {
        if ($OutputRootRelative -ieq $prefix -or $OutputRootRelative.StartsWith("$prefix/", [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "output_root is a forbidden AM3 runtime write surface: $OutputRootRelative"
        }
    }
}

function Assert-NoSensitiveText {
    param(
        [Parameter(Mandatory = $true)][string]$Text,
        [Parameter(Mandatory = $true)][string]$Scope
    )
    $patterns = @(
        @{ Name = 'url'; Pattern = '(?i)\bhttps?://[^\s\)"''<>]+' },
        @{ Name = 'email'; Pattern = '(?i)\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b' },
        @{ Name = 'bearer-token'; Pattern = '(?i)\bBearer\s+[A-Za-z0-9._~+/\-]+=*' },
        @{ Name = 'api-key'; Pattern = '(?i)\b(api[_-]?key|x-api-key|access[_-]?token|secret|password)\b\s*[:=]' },
        @{ Name = 'private-key'; Pattern = 'BEGIN (RSA |OPENSSH |EC )?PRIVATE KEY' },
        @{ Name = 'pan-like'; Pattern = '(?<!\d)\d{16}(?!\d)' },
        @{ Name = 'ssn-like'; Pattern = '\b\d{3}-\d{2}-\d{4}\b' },
        @{ Name = 'customer-id'; Pattern = '(?i)\b(customer|cust)[-_ ]?id\b|\bCUST-[A-Z0-9-]+\b' }
    )
    foreach ($pattern in $patterns) {
        if ($Text -match $pattern.Pattern) {
            throw "Sensitive-data screen failed for $Scope ($($pattern.Name))."
        }
    }
}

function New-Am3Event {
    param(
        [Parameter(Mandatory = $true)][string]$RunId,
        [Parameter(Mandatory = $true)][string]$EventType,
        [Parameter(Mandatory = $true)][string]$StepId,
        [Parameter(Mandatory = $true)][string]$Actor,
        [AllowNull()][string]$PreviousState,
        [AllowNull()][string]$NextState,
        [AllowNull()][string]$InputRef,
        [AllowNull()][string]$OutputRef,
        [AllowNull()][string]$ValidatorRef,
        [AllowNull()][string]$PolicyDecision,
        [AllowNull()][string]$HumanGateRef
    )
    $script:EventOrdinal++
    $eventId = 'EVT-{0}-{1:D4}' -f $RunId, $script:EventOrdinal
    $checkpointId = 'CHK-{0}-{1:D4}' -f $RunId, $script:EventOrdinal
    $timestamp = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
    $event = [ordered]@{
        schema_version  = 'am3.event.v0_1_2'
        event_id        = $eventId
        run_id          = $RunId
        timestamp       = $timestamp
        event_type      = $EventType
        step_id         = $StepId
        actor           = $Actor
        checkpoint_id   = $checkpointId
        previous_state  = $PreviousState
        next_state      = $NextState
        input_ref       = $InputRef
        output_ref      = $OutputRef
        validator_ref   = $ValidatorRef
        policy_decision = $PolicyDecision
        human_gate_ref  = $HumanGateRef
    }
    $json = ($event | ConvertTo-Json -Compress -Depth 4)
    Assert-NoSensitiveText -Text $json -Scope $eventId
    $script:EventLines.Add($json)
    $script:LastCheckpointId = $checkpointId
}

function Format-YamlScalar {
    param([AllowNull()][object]$Value)
    if ($null -eq $Value) { return 'null' }
    if ($Value -is [bool]) { return ($(if ($Value) { 'true' } else { 'false' })) }
    $text = [string]$Value
    if ($text -eq '') { return '""' }
    if ($text -match '[:#\[\]\{\},&\*!\|\>''"%@`]' -or $text -match '\s') {
        return '"' + ($text.Replace('\', '\\').Replace('"', '\"')) + '"'
    }
    return $text
}

function Format-YamlList {
    param(
        [Parameter(Mandatory = $true)][string]$Key,
        [AllowEmptyCollection()]
        [object[]]$Values = @()
    )
    if ($null -eq $Values) { $Values = @() }
    if ($Values.Count -eq 0) { return "$Key`: []" }
    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("$Key`:")
    foreach ($value in $Values) {
        $lines.Add('  - ' + (Format-YamlScalar $value))
    }
    return ($lines -join "`n")
}

function Write-RunState {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$RunId,
        [Parameter(Mandatory = $true)][string]$CurrentStep,
        [AllowNull()][object]$LastCompletedStep,
        [AllowNull()][object]$PendingHumanGate,
        [Parameter(Mandatory = $true)][string]$Status,
        [Parameter(Mandatory = $true)][string]$CreatedAt,
        [Parameter(Mandatory = $true)][string]$OutputRootRelative
    )
    $updatedAt = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
    $lines = @(
        'schema_version: am3.run_state.v0_1_2',
        'package_version: v0.1.2',
        ('run_id: ' + (Format-YamlScalar $RunId)),
        ('current_step: ' + (Format-YamlScalar $CurrentStep)),
        ('last_completed_step: ' + (Format-YamlScalar $LastCompletedStep)),
        ('pending_human_gate: ' + (Format-YamlScalar $PendingHumanGate)),
        ('last_checkpoint_id: ' + (Format-YamlScalar $script:LastCheckpointId)),
        ('status: ' + (Format-YamlScalar $Status)),
        ('created_at: ' + (Format-YamlScalar $CreatedAt)),
        ('updated_at: ' + (Format-YamlScalar $updatedAt)),
        ('output_root: ' + (Format-YamlScalar $OutputRootRelative)),
        'event_log_path: runtime/events.ndjson'
    )
    $content = ($lines -join "`n") + "`n"
    Assert-NoSensitiveText -Text $content -Scope 'runtime/run-state.yaml'
    Write-Utf8NoBom -Path $Path -Content $content
}

function Invoke-HumanGate {
    param(
        [Parameter(Mandatory = $true)][string]$RunId,
        [Parameter(Mandatory = $true)][string]$GateId,
        [Parameter(Mandatory = $true)][string]$StepId,
        [Parameter(Mandatory = $true)][string]$PreviousState,
        [Parameter(Mandatory = $true)][string]$StopStatePath,
        [Parameter(Mandatory = $true)][string]$EventsPath,
        [Parameter(Mandatory = $true)][string]$CreatedAt,
        [Parameter(Mandatory = $true)][string]$OutputRootRelative
    )
    New-Am3Event -RunId $RunId -EventType 'gate_request' -StepId $StepId -Actor 'PRA-01-SAS-REVIEW-ORCHESTRATOR' -PreviousState $PreviousState -NextState $PreviousState -InputRef $null -OutputRef $null -ValidatorRef $null -PolicyDecision 'pause' -HumanGateRef $GateId
    if ($HumanGateDecision -eq 'deny' -and $GateId -eq $DenyGateId) {
        New-Am3Event -RunId $RunId -EventType 'gate_decision' -StepId $StepId -Actor 'human_reviewer' -PreviousState $PreviousState -NextState $PreviousState -InputRef $null -OutputRef $null -ValidatorRef $null -PolicyDecision 'deny' -HumanGateRef $GateId
        New-Am3Event -RunId $RunId -EventType 'stop' -StepId 'AM3-STOPPED' -Actor 'PRA-01-SAS-REVIEW-ORCHESTRATOR' -PreviousState $PreviousState -NextState 'AM3-STOPPED' -InputRef $null -OutputRef $null -ValidatorRef 'tools/Test-AisrafAm3Runtime.ps1' -PolicyDecision 'stop' -HumanGateRef $GateId
        Write-Utf8NoBom -Path $EventsPath -Content (($script:EventLines -join "`n") + "`n")
        Write-RunState -Path $StopStatePath -RunId $RunId -CurrentStep 'AM3-STOPPED' -LastCompletedStep $null -PendingHumanGate $GateId -Status 'stopped' -CreatedAt $CreatedAt -OutputRootRelative $OutputRootRelative
        Write-Host "STOP  AM3 human gate denied: $GateId" -ForegroundColor Red
        exit 1
    }
    New-Am3Event -RunId $RunId -EventType 'gate_decision' -StepId $StepId -Actor 'human_reviewer' -PreviousState $PreviousState -NextState $PreviousState -InputRef $null -OutputRef $null -ValidatorRef $null -PolicyDecision 'approve' -HumanGateRef $GateId
}

function Write-HandoffPair {
    param(
        [Parameter(Mandatory = $true)][hashtable]$Step,
        [Parameter(Mandatory = $true)][string]$RunId,
        [Parameter(Mandatory = $true)][string]$InputRootRelative,
        [Parameter(Mandatory = $true)][string]$OutputRootRelative,
        [AllowEmptyCollection()]
        [string[]]$UpstreamArtifacts = @(),
        [Parameter(Mandatory = $true)][string]$RuntimeRootAbs
    )
    if ($null -eq $UpstreamArtifacts) { $UpstreamArtifacts = @() }
    $stepId = $Step['step_id']
    $specialist = $Step['specialist_agent_id']
    $stepDir = Join-Path $RuntimeRootAbs "handoffs/$stepId"
    $requestPath = Join-Path $stepDir 'request.yaml'
    $responsePath = Join-Path $stepDir 'response.yaml'
    $requestRef = "$OutputRootRelative/runtime/handoffs/$stepId/request.yaml"
    $responseRef = "$OutputRootRelative/runtime/handoffs/$stepId/response.yaml"

    $allowedOutputPaths = @(
        "$OutputRootRelative/",
        "$OutputRootRelative/dfd/",
        "$OutputRootRelative/runtime/",
        "$OutputRootRelative/runtime/handoffs/$stepId/"
    )
    $requiredInputs = @($InputRootRelative)
    if ($UpstreamArtifacts.Count -gt 0) { $requiredInputs += $UpstreamArtifacts }
    $expectedOutputs = @($Step['expected_outputs'])

    $requestLines = New-Object System.Collections.Generic.List[string]
    $requestLines.Add('schema_version: am3.handoff_request.v0_1_2')
    $requestLines.Add('run_id: ' + (Format-YamlScalar $RunId))
    $requestLines.Add('step_id: ' + (Format-YamlScalar $stepId))
    $requestLines.Add('specialist_agent_id: ' + (Format-YamlScalar $specialist))
    $requestLines.Add((Format-YamlList -Key 'required_inputs' -Values $requiredInputs))
    $requestLines.Add((Format-YamlList -Key 'allowed_output_paths' -Values $allowedOutputPaths))
    $requestLines.Add((Format-YamlList -Key 'upstream_artifacts' -Values $UpstreamArtifacts))
    $requestLines.Add((Format-YamlList -Key 'expected_outputs' -Values $expectedOutputs))
    $requestLines.Add('validation_route: tools/Test-AisrafAm3Runtime.ps1')
    $requestLines.Add('human_gate_required: ' + (Format-YamlScalar ([bool]$Step['human_gate_required'])))
    $requestLines.Add('external_execution_allowed: false')
    if ($stepId -eq 'AM3-02') {
        $requestLines.Add('embedded_subskill_specialist_agent_id: PRA-04-LEGEND-NORMALIZER')
        $requestLines.Add('embedded_subskill_scope: inside_AM3_02_only')
    }
    $requestContent = ($requestLines -join "`n") + "`n"
    Assert-NoSensitiveText -Text $requestContent -Scope $requestRef
    Write-Utf8NoBom -Path $requestPath -Content $requestContent

    New-Am3Event -RunId $RunId -EventType 'handoff_request' -StepId $stepId -Actor 'PRA-01-SAS-REVIEW-ORCHESTRATOR' -PreviousState $stepId -NextState $stepId -InputRef $InputRootRelative -OutputRef $requestRef -ValidatorRef $null -PolicyDecision 'advance' -HumanGateRef $null

    $responseLines = New-Object System.Collections.Generic.List[string]
    $responseLines.Add('schema_version: am3.handoff_response.v0_1_2')
    $responseLines.Add('run_id: ' + (Format-YamlScalar $RunId))
    $responseLines.Add('step_id: ' + (Format-YamlScalar $stepId))
    $responseLines.Add('specialist_agent_id: ' + (Format-YamlScalar $specialist))
    $responseLines.Add('produced_outputs: []')
    $responseLines.Add('missing_inputs: []')
    if ($stepId -eq 'AM3-02') {
        $responseLines.Add((Format-YamlList -Key 'unknowns_preserved' -Values @('PRA-04-LEGEND-NORMALIZER remained inside AM3-02; specialist content execution deferred to AM3 smoke.')))
    }
    else {
        $responseLines.Add((Format-YamlList -Key 'unknowns_preserved' -Values @('Specialist content execution deferred to AM3 smoke.')))
    }
    $responseLines.Add('validation_status: not_applicable')
    $responseLines.Add((Format-YamlList -Key 'evidence_refs' -Values @($requestRef)))
    $responseLines.Add('next_recommended_state: advance_to_next_step')
    $responseLines.Add('external_execution_performed: false')
    $responseContent = ($responseLines -join "`n") + "`n"
    Assert-NoSensitiveText -Text $responseContent -Scope $responseRef
    Write-Utf8NoBom -Path $responsePath -Content $responseContent
    if (-not (Test-Path -LiteralPath $responsePath -PathType Leaf)) {
        throw "Missing handoff response after write: $responseRef"
    }

    New-Am3Event -RunId $RunId -EventType 'handoff_response' -StepId $stepId -Actor $specialist -PreviousState $stepId -NextState $stepId -InputRef $requestRef -OutputRef $responseRef -ValidatorRef $null -PolicyDecision 'validator_not_applicable' -HumanGateRef $null
    New-Am3Event -RunId $RunId -EventType 'validator_outcome' -StepId $stepId -Actor 'validator' -PreviousState $stepId -NextState $stepId -InputRef $responseRef -OutputRef $null -ValidatorRef 'tools/Test-AisrafAm3Runtime.ps1' -PolicyDecision 'validator_pass' -HumanGateRef $null

    return @($expectedOutputs)
}

if (-not (Test-Path -LiteralPath $RunProfilePath -PathType Leaf)) {
    throw "Run profile not found: $RunProfilePath"
}

$contractFiles = @(
    'config/am3.orchestrator-contract.v0_1_2.yaml',
    'config/am3.handoff-contract.v0_1_2.yaml',
    'config/am3.run-state.schema.v0_1_2.yaml',
    'config/am3.event.schema.v0_1_2.yaml'
)
foreach ($contractFile in $contractFiles) {
    $contractPath = Resolve-PackagePath $contractFile
    if (-not (Test-Path -LiteralPath $contractPath -PathType Leaf)) {
        throw "AM3 contract/schema file missing: $contractFile"
    }
    $contractText = Get-Content -LiteralPath $contractPath -Raw
    if ([string]::IsNullOrWhiteSpace($contractText)) {
        throw "AM3 contract/schema file is empty: $contractFile"
    }
}

$contractsResult = & pwsh -NoProfile -File (Resolve-PackagePath 'tools/Test-AisrafAm3Runtime.ps1') -ContractsOnly 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host ($contractsResult -join [Environment]::NewLine)
    throw 'AM3 contracts validator failed; runner stopped before writing runtime files.'
}

$profileResult = & pwsh -NoProfile -File (Resolve-PackagePath 'tools/Test-AisrafRunProfile.ps1') -RunProfilePath $RunProfilePath -ExecutionReady 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host ($profileResult -join [Environment]::NewLine)
    throw 'Run profile validator failed; runner stopped before writing runtime files.'
}

$profile = ConvertFrom-FlatYaml -Path $RunProfilePath
$runId = [string]$profile['run_id']
$inputRootRelative = Normalize-RepoPath ([string]$profile['input_root'])
$outputRootRelative = Normalize-RepoPath ([string]$profile['output_root'])
Assert-OutputRootAllowed -OutputRootRelative $outputRootRelative
Assert-LocalRelativePath -PathValue $inputRootRelative -Name 'input_root'

if ([string]$profile['output_destination_mode'] -ne 'local_only' -or
    [string]$profile['postback_execution_status'] -ne 'deferred' -or
    [string]$profile['jira_connector_status'] -notin @('not_required', 'unavailable') -or
    [string]$profile['confluence_connector_status'] -notin @('not_required', 'unavailable') -or
    [string]$profile['mcp_execution_status'] -notin @('not_required', 'unavailable') -or
    [bool]$profile['rovo_mcp_available'] -ne $false) {
    throw 'Unsupported connector state or external execution posture in run profile.'
}

$profileText = Get-Content -LiteralPath $RunProfilePath -Raw
Assert-NoSensitiveText -Text $profileText -Scope 'run-profile.yaml'

$outputRootAbs = Resolve-PackagePath $outputRootRelative
if (-not (Test-Path -LiteralPath $outputRootAbs -PathType Container)) {
    throw "output_root folder must already exist before AM3 runtime writes: $outputRootRelative"
}

$runtimeAbs = Join-Path $outputRootAbs 'runtime'
$runStateAbs = Join-Path $runtimeAbs 'run-state.yaml'
$eventsAbs = Join-Path $runtimeAbs 'events.ndjson'
$handoffsAbs = Join-Path $runtimeAbs 'handoffs'
if (-not (Test-PathUnderRoot -ChildPath $runtimeAbs -RootPath $outputRootAbs)) {
    throw 'Path guard violation: runtime path is outside output_root.'
}

if (Test-Path -LiteralPath $runtimeAbs -PathType Container) {
    if (-not $Force.IsPresent) {
        throw "runtime/ already exists under output_root. Re-run with -Force to rebuild only this runtime folder: $outputRootRelative/runtime"
    }
    if (-not (Test-PathUnderRoot -ChildPath $runtimeAbs -RootPath $outputRootAbs)) {
        throw 'Refusing to remove runtime path because it is outside output_root.'
    }
    Remove-Item -LiteralPath $runtimeAbs -Recurse -Force
}

[void](New-Item -ItemType Directory -Path $runtimeAbs -Force)
[void](New-Item -ItemType Directory -Path $handoffsAbs -Force)

$createdAt = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
Write-Utf8NoBom -Path $eventsAbs -Content ''
Write-RunState -Path $runStateAbs -RunId $runId -CurrentStep 'AM3-INIT' -LastCompletedStep $null -PendingHumanGate $null -Status 'initialized' -CreatedAt $createdAt -OutputRootRelative $outputRootRelative
New-Am3Event -RunId $runId -EventType 'orchestrator_decision' -StepId 'AM3-INIT' -Actor 'PRA-01-SAS-REVIEW-ORCHESTRATOR' -PreviousState $null -NextState 'AM3-INIT' -InputRef $RunProfilePath.Replace('\', '/') -OutputRef $null -ValidatorRef 'tools/Test-AisrafRunProfile.ps1' -PolicyDecision 'advance' -HumanGateRef $null
Invoke-HumanGate -RunId $runId -GateId 'pre_run_approval' -StepId 'AM3-INIT' -PreviousState 'AM3-INIT' -StopStatePath $runStateAbs -EventsPath $eventsAbs -CreatedAt $createdAt -OutputRootRelative $outputRootRelative
New-Am3Event -RunId $runId -EventType 'orchestrator_decision' -StepId 'AM3-INIT' -Actor 'PRA-01-SAS-REVIEW-ORCHESTRATOR' -PreviousState 'AM3-INIT' -NextState 'AM3-01' -InputRef $RunProfilePath.Replace('\', '/') -OutputRef $null -ValidatorRef 'tools/Test-AisrafAm3Runtime.ps1' -PolicyDecision 'advance' -HumanGateRef $null
Write-Utf8NoBom -Path $eventsAbs -Content (($EventLines -join "`n") + "`n")
Write-RunState -Path $runStateAbs -RunId $runId -CurrentStep 'AM3-01' -LastCompletedStep 'AM3-INIT' -PendingHumanGate $null -Status 'running' -CreatedAt $createdAt -OutputRootRelative $outputRootRelative

$steps = @(
    @{ step_id = 'AM3-01'; specialist_agent_id = 'PRA-02-INPUT-READER'; human_gate_required = $false; expected_outputs = @("$outputRootRelative/01-input-inventory.md") },
    @{ step_id = 'AM3-02'; specialist_agent_id = 'PRA-03-DFD-EXTRACTOR'; human_gate_required = $true; expected_outputs = @("$outputRootRelative/dfd/", "$outputRootRelative/02-components-rs.md", "$outputRootRelative/03-flows-rs.md", "$outputRootRelative/04-boundaries-rs.md", "$outputRootRelative/05-design-facts.md", "$outputRootRelative/06-dfd-intake-verdict.md") },
    @{ step_id = 'AM3-03'; specialist_agent_id = 'PRA-05-REVIEW-TABLE-BUILDER'; human_gate_required = $false; expected_outputs = @("$outputRootRelative/07-security-stack-assessment.md", "$outputRootRelative/08-internal-review-table.md") },
    @{ step_id = 'AM3-04'; specialist_agent_id = 'PRA-06-BLUEPRINT-QUESTIONER'; human_gate_required = $false; expected_outputs = @("$outputRootRelative/09-missing-facts.md", "$outputRootRelative/10-ai-action-level.md", "$outputRootRelative/11-blueprint-match.md", "$outputRootRelative/12-targeted-questions.md") },
    @{ step_id = 'AM3-05'; specialist_agent_id = 'PRA-07-FINDING-RECOMMENDER'; human_gate_required = $false; expected_outputs = @("$outputRootRelative/13-findings.md", "$outputRootRelative/14-recommendations.md") },
    @{ step_id = 'AM3-06'; specialist_agent_id = 'PRA-08-HANDOFF-QA-SCORER'; human_gate_required = $true; expected_outputs = @("$outputRootRelative/15-handoff-pack.md", "$outputRootRelative/16-validation-notes.md", "$outputRootRelative/17-accuracy-score.md") }
)

$upstream = @()
for ($i = 0; $i -lt $steps.Count; $i++) {
    $step = $steps[$i]
    $stepId = $step['step_id']
    $newExpected = @(Write-HandoffPair -Step $step -RunId $runId -InputRootRelative $inputRootRelative -OutputRootRelative $outputRootRelative -UpstreamArtifacts $upstream -RuntimeRootAbs $runtimeAbs)
    $upstream += $newExpected
    if ($stepId -eq 'AM3-02') {
        Invoke-HumanGate -RunId $runId -GateId 'pre_output_generation_approval' -StepId 'AM3-02' -PreviousState 'AM3-02' -StopStatePath $runStateAbs -EventsPath $eventsAbs -CreatedAt $createdAt -OutputRootRelative $outputRootRelative
    }
    if ($stepId -eq 'AM3-06') {
        Invoke-HumanGate -RunId $runId -GateId 'final_review_approval' -StepId 'AM3-06' -PreviousState 'AM3-06' -StopStatePath $runStateAbs -EventsPath $eventsAbs -CreatedAt $createdAt -OutputRootRelative $outputRootRelative
    }
    if ($i -lt ($steps.Count - 1)) {
        $nextStepId = $steps[$i + 1]['step_id']
        New-Am3Event -RunId $runId -EventType 'orchestrator_decision' -StepId $stepId -Actor 'PRA-01-SAS-REVIEW-ORCHESTRATOR' -PreviousState $stepId -NextState $nextStepId -InputRef $null -OutputRef $null -ValidatorRef 'tools/Test-AisrafAm3Runtime.ps1' -PolicyDecision 'advance' -HumanGateRef $null
    }
}

New-Am3Event -RunId $runId -EventType 'orchestrator_decision' -StepId 'AM3-06' -Actor 'PRA-01-SAS-REVIEW-ORCHESTRATOR' -PreviousState 'AM3-06' -NextState 'AM3-FINAL-GATE' -InputRef $null -OutputRef $null -ValidatorRef 'tools/Test-AisrafAm3Runtime.ps1' -PolicyDecision 'advance' -HumanGateRef $null
Invoke-HumanGate -RunId $runId -GateId 'release_or_claim_approval' -StepId 'AM3-FINAL-GATE' -PreviousState 'AM3-FINAL-GATE' -StopStatePath $runStateAbs -EventsPath $eventsAbs -CreatedAt $createdAt -OutputRootRelative $outputRootRelative
Invoke-HumanGate -RunId $runId -GateId 'final_pass_partial_fail_not_applicable_decision' -StepId 'AM3-FINAL-GATE' -PreviousState 'AM3-FINAL-GATE' -StopStatePath $runStateAbs -EventsPath $eventsAbs -CreatedAt $createdAt -OutputRootRelative $outputRootRelative
New-Am3Event -RunId $runId -EventType 'orchestrator_decision' -StepId 'AM3-FINAL-GATE' -Actor 'PRA-01-SAS-REVIEW-ORCHESTRATOR' -PreviousState 'AM3-FINAL-GATE' -NextState 'AM3-COMPLETE' -InputRef $null -OutputRef $null -ValidatorRef 'tools/Test-AisrafAm3Runtime.ps1' -PolicyDecision 'advance' -HumanGateRef $null
New-Am3Event -RunId $runId -EventType 'orchestrator_decision' -StepId 'AM3-COMPLETE' -Actor 'PRA-01-SAS-REVIEW-ORCHESTRATOR' -PreviousState 'AM3-COMPLETE' -NextState 'AM3-COMPLETE' -InputRef $null -OutputRef "$outputRootRelative/runtime/run-state.yaml" -ValidatorRef 'tools/Test-AisrafAm3Runtime.ps1' -PolicyDecision 'approve' -HumanGateRef $null

Write-Utf8NoBom -Path $eventsAbs -Content (($EventLines -join "`n") + "`n")
Write-RunState -Path $runStateAbs -RunId $runId -CurrentStep 'AM3-COMPLETE' -LastCompletedStep 'AM3-FINAL-GATE' -PendingHumanGate $null -Status 'complete' -CreatedAt $createdAt -OutputRootRelative $outputRootRelative

$runtimeValidation = & pwsh -NoProfile -File (Resolve-PackagePath 'tools/Test-AisrafAm3Runtime.ps1') -RunProfilePath $RunProfilePath 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host ($runtimeValidation -join [Environment]::NewLine)
    throw 'AM3 runtime validator failed after scaffold creation.'
}

Write-Host ''
Write-Host "Invoke-AisrafAm3LocalRun  package_root=$PackageRoot" -ForegroundColor Cyan
Write-Host "  run_id        : $runId" -ForegroundColor Cyan
Write-Host "  output_root   : $outputRootRelative" -ForegroundColor Cyan
Write-Host "  runtime_root  : $outputRootRelative/runtime" -ForegroundColor Cyan
Write-Host "  handoff_steps : AM3-01..AM3-06" -ForegroundColor Cyan
Write-Host ''
Write-Host 'Invoke-AisrafAm3LocalRun: PASS  local AM3 runtime scaffold created; full AM3 smoke remains not executed.' -ForegroundColor Green
exit 0
