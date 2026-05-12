<#
.SYNOPSIS
    Validate the AISRAF AM3 local runtime contracts and runtime scaffold.

.DESCRIPTION
    Test-AisrafAm3Runtime validates the WP-12C-AM3 contract files and, when
    a run profile is supplied, the local-only AM3 runtime files under that
    profile's output_root/runtime/ folder.

    ContractsOnly mode is the AM3-RUNTIME gate check. It confirms the four
    AM3 contract/schema files exist and expose the required strict enums.

    Runtime mode checks run-state.yaml, events.ndjson, AM3-01..AM3-06 handoff
    request/response pairs, strict step ordering, human gate representation,
    local path containment, sensitive-data posture, stop event validity, and
    completion event validity.

    This validator does not execute prompts, skills, PRAs, adapters, Jira,
    Confluence, Lucidchart, Rovo MCP, cloud, databases, Terraform, event bus,
    telemetry, post-back, push, publish, or release packaging.
#>
[CmdletBinding(DefaultParameterSetName = 'ContractsOnly')]
param(
    [Parameter(ParameterSetName = 'ContractsOnly')]
    [switch]$ContractsOnly,

    [Parameter(ParameterSetName = 'Runtime', Mandatory = $true)]
    [string]$RunProfilePath,

    [Parameter(ParameterSetName = 'Runtime')]
    [string]$OutputRoot
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$PackageRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Results = New-Object System.Collections.Generic.List[psobject]

function Add-Result {
    param(
        [Parameter(Mandatory = $true)][ValidateSet('PASS', 'FAIL')][string]$Status,
        [Parameter(Mandatory = $true)][string]$Check,
        [Parameter(Mandatory = $true)][string]$Detail
    )
    $script:Results.Add([pscustomobject]@{
        Status = $Status
        Check  = $Check
        Detail = $Detail
    })
}

function Resolve-PackagePath {
    param([Parameter(Mandatory = $true)][string]$RelativePath)
    return (Join-Path $script:PackageRoot ($RelativePath -replace '/', [System.IO.Path]::DirectorySeparatorChar))
}

function Convert-ToRepoPath {
    param([Parameter(Mandatory = $true)][string]$Path)
    $resolved = (Resolve-Path -LiteralPath $Path).Path
    return $resolved.Substring($script:PackageRoot.Length + 1).Replace('\', '/')
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

function ConvertFrom-SimpleYamlScalar {
    param([AllowNull()][string]$Value)
    if ($null -eq $Value) { return $null }
    $trimmed = $Value.Trim()
    if ($trimmed -eq 'null' -or $trimmed -eq '~') { return $null }
    if ($trimmed -eq '""') { return '' }
    if ($trimmed -match '^"(.*)"$') { return $Matches[1].Replace('\"', '"') }
    if ($trimmed -match "^'(.*)'$") { return $Matches[1] }
    return $trimmed
}

function Get-SimpleYamlList {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Key
    )
    $lines = @(Get-Content -LiteralPath $Path)
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        if ($line -match ('^' + [regex]::Escape($Key) + '\s*:\s*(?<value>.*)$')) {
            $inline = $Matches['value'].Trim()
            if ($inline -eq '[]') { return @() }
            if ($inline -match '^\[(?<items>.*)\]$') {
                $items = $Matches['items'].Trim()
                if ($items -eq '') { return @() }
                return @($items -split ',' | ForEach-Object { ConvertFrom-SimpleYamlScalar $_ })
            }

            $values = New-Object System.Collections.Generic.List[string]
            for ($j = $i + 1; $j -lt $lines.Count; $j++) {
                $next = $lines[$j]
                if ($next -match '^\s*$') { continue }
                if ($next -match '^\s{2}-\s*(?<item>.*)$') {
                    $values.Add((ConvertFrom-SimpleYamlScalar $Matches['item']))
                    continue
                }
                break
            }
            return @($values)
        }
    }
    throw "List key '$Key' missing from $Path"
}

function Test-StringArrayEqual {
    param(
        [AllowEmptyCollection()][string[]]$Actual = @(),
        [AllowEmptyCollection()][string[]]$Expected = @()
    )
    if ($null -eq $Actual) { $Actual = @() }
    if ($null -eq $Expected) { $Expected = @() }
    if ($Actual.Count -ne $Expected.Count) { return $false }
    for ($i = 0; $i -lt $Expected.Count; $i++) {
        if ($Actual[$i] -ne $Expected[$i]) { return $false }
    }
    return $true
}

function Get-SchemaEnumValues {
    param(
        [Parameter(Mandatory = $true)][string]$Text,
        [Parameter(Mandatory = $true)][string]$PropertyName
    )

    $lines = $Text -split "`r?`n"
    $inProperty = $false
    $inEnum = $false
    $values = New-Object System.Collections.Generic.List[string]

    foreach ($line in $lines) {
        if ($line -match ("^\s{2}" + [regex]::Escape($PropertyName) + "\s*:\s*$")) {
            $inProperty = $true
            $inEnum = $false
            continue
        }
        if ($inProperty -and $line -match '^\s{2}[A-Za-z_][A-Za-z0-9_]*\s*:\s*$' -and $line -notmatch ("^\s{2}" + [regex]::Escape($PropertyName) + "\s*:")) {
            break
        }
        if ($inProperty -and $line -match '^\s{4}enum\s*:\s*$') {
            $inEnum = $true
            continue
        }
        if ($inEnum -and $line -match '^\s{6}-\s*(?<value>[^#]+?)\s*$') {
            $values.Add($Matches['value'].Trim().Trim('"').Trim("'"))
            continue
        }
        if ($inEnum -and $line -notmatch '^\s{6}-\s*') {
            break
        }
    }

    return @($values)
}

function Test-RelativeLocalPath {
    param(
        [Parameter(Mandatory = $true)][string]$PathValue,
        [Parameter(Mandatory = $true)][string]$Name
    )
    $failures = @()
    if ([string]::IsNullOrWhiteSpace($PathValue)) {
        return @("$Name is empty")
    }
    if ($PathValue -match '\\') { $failures += "$Name uses backslash separators: $PathValue" }
    if ($PathValue -match '^[A-Za-z]:') { $failures += "$Name starts with a drive letter: $PathValue" }
    if ($PathValue.StartsWith('/')) { $failures += "$Name starts with '/': $PathValue" }
    if ($PathValue -match '(^|/)\.\.(/|$)') { $failures += "$Name contains parent traversal: $PathValue" }
    if ($PathValue -match '(?i)\bhttps?://') { $failures += "$Name contains a URL: $PathValue" }
    return @($failures)
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

function Get-RuntimeTextFiles {
    param([Parameter(Mandatory = $true)][string]$RuntimeRoot)
    if (-not (Test-Path -LiteralPath $RuntimeRoot -PathType Container)) { return @() }
    return @(Get-ChildItem -LiteralPath $RuntimeRoot -Recurse -Force -File |
        Where-Object { @('.yaml', '.yml', '.ndjson', '.json', '.txt', '.md') -contains $_.Extension.ToLowerInvariant() })
}

$ContractFiles = @(
    'config/am3.orchestrator-contract.v0_1_2.yaml',
    'config/am3.handoff-contract.v0_1_2.yaml',
    'config/am3.run-state.schema.v0_1_2.yaml',
    'config/am3.event.schema.v0_1_2.yaml'
)

$ContractText = @{}
$contractMissing = @()
foreach ($relative in $ContractFiles) {
    $absolute = Resolve-PackagePath $relative
    if (-not (Test-Path -LiteralPath $absolute -PathType Leaf)) {
        $contractMissing += $relative
        continue
    }
    $ContractText[$relative] = Get-Content -LiteralPath $absolute -Raw
}

if ($contractMissing.Count -eq 0) {
    Add-Result -Status PASS -Check '01-contract-files' -Detail 'All four AM3 contract/schema files exist.'
}
else {
    Add-Result -Status FAIL -Check '01-contract-files' -Detail ('Missing AM3 contract/schema file(s): ' + ($contractMissing -join ', '))
}

if ($contractMissing.Count -eq 0) {
    $contractLoadFailures = @()
    $expectedTokens = @(
        'am3.orchestrator-contract.v0_1_2',
        'am3.handoff-contract.v0_1_2',
        'am3.run_state.v0_1_2',
        'am3.event.v0_1_2',
        'PRA-04-LEGEND-NORMALIZER',
        'WP-12C-AM3-RUNTIME'
    )
    $allContractText = ($ContractText.Values -join "`n")
    foreach ($token in $expectedTokens) {
        if ($allContractText -notmatch [regex]::Escape($token)) {
            $contractLoadFailures += "Missing contract token: $token"
        }
    }
    if ($contractLoadFailures.Count -eq 0) {
        Add-Result -Status PASS -Check '02-contract-load' -Detail 'Contracts loaded and contain AM3 runtime, handoff, run-state, event, and PRA-04 embedded-subskill authority tokens.'
    }
    else {
        foreach ($failure in $contractLoadFailures) {
            Add-Result -Status FAIL -Check '02-contract-load' -Detail $failure
        }
    }
}

$StepEnum = @()
$EventTypeEnum = @()
if ($ContractText.ContainsKey('config/am3.event.schema.v0_1_2.yaml')) {
    $eventSchemaText = $ContractText['config/am3.event.schema.v0_1_2.yaml']
    $StepEnum = @(Get-SchemaEnumValues -Text $eventSchemaText -PropertyName 'step_id')
    $EventTypeEnum = @(Get-SchemaEnumValues -Text $eventSchemaText -PropertyName 'event_type')
}

$ExpectedStepEnum = @('AM3-INIT', 'AM3-01', 'AM3-02', 'AM3-03', 'AM3-04', 'AM3-05', 'AM3-06', 'AM3-FINAL-GATE', 'AM3-COMPLETE', 'AM3-STOPPED')
$ExpectedEventTypeEnum = @('orchestrator_decision', 'handoff_request', 'handoff_response', 'validator_outcome', 'gate_request', 'gate_decision', 'stop')

$missingStepEnum = @($ExpectedStepEnum | Where-Object { $StepEnum -notcontains $_ })
$extraStepEnum = @($StepEnum | Where-Object { $ExpectedStepEnum -notcontains $_ })
$missingEventEnum = @($ExpectedEventTypeEnum | Where-Object { $EventTypeEnum -notcontains $_ })
$extraEventEnum = @($EventTypeEnum | Where-Object { $ExpectedEventTypeEnum -notcontains $_ })
if ($missingStepEnum.Count -eq 0 -and $extraStepEnum.Count -eq 0 -and $missingEventEnum.Count -eq 0 -and $extraEventEnum.Count -eq 0) {
    Add-Result -Status PASS -Check '03-contract-enums' -Detail 'AM3 step_id and event_type enums match the runtime contract.'
}
else {
    if ($missingStepEnum.Count -gt 0 -or $extraStepEnum.Count -gt 0) {
        Add-Result -Status FAIL -Check '03-contract-enums' -Detail ("step_id enum mismatch; missing=$($missingStepEnum -join ', '); extra=$($extraStepEnum -join ', ')")
    }
    if ($missingEventEnum.Count -gt 0 -or $extraEventEnum.Count -gt 0) {
        Add-Result -Status FAIL -Check '03-contract-enums' -Detail ("event_type enum mismatch; missing=$($missingEventEnum -join ', '); extra=$($extraEventEnum -join ', ')")
    }
}

if ($ContractsOnly.IsPresent -or $PSCmdlet.ParameterSetName -eq 'ContractsOnly') {
    Add-Result -Status PASS -Check '04-contracts-only' -Detail 'ContractsOnly mode selected; runtime files are not required in this gate.'
}
else {
    if (-not (Test-Path -LiteralPath $RunProfilePath -PathType Leaf)) {
        Add-Result -Status FAIL -Check '04-run-profile' -Detail "Run profile missing: $RunProfilePath"
    }
    else {
        $profile = $null
        try {
            $profile = ConvertFrom-FlatYaml -Path $RunProfilePath
            Add-Result -Status PASS -Check '04-run-profile' -Detail 'Run profile parsed with the flat YAML parser.'
        }
        catch {
            Add-Result -Status FAIL -Check '04-run-profile' -Detail $_.Exception.Message
        }

        if ($null -ne $profile) {
            $runId = [string]$profile['run_id']
            $outputRootRelative = if ([string]::IsNullOrWhiteSpace($OutputRoot)) { [string]$profile['output_root'] } else { $OutputRoot }
            $outputRootRelative = Normalize-RepoPath $outputRootRelative
            $outputRootPathFailures = @(Test-RelativeLocalPath -PathValue $outputRootRelative -Name 'output_root')
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
                'docs',
                'release',
                'plugins/aisraf-copilot-plugin'
            )
            foreach ($prefix in $forbiddenOutputPrefixes) {
                if ($outputRootRelative -ieq $prefix -or $outputRootRelative.StartsWith("$prefix/", [System.StringComparison]::OrdinalIgnoreCase)) {
                    $outputRootPathFailures += "output_root is on a forbidden runtime write surface: $outputRootRelative"
                }
            }
            if ($outputRootPathFailures.Count -eq 0) {
                Add-Result -Status PASS -Check '05-output-root' -Detail "output_root is local and not a forbidden canonical surface: $outputRootRelative"
            }
            else {
                foreach ($failure in $outputRootPathFailures) {
                    Add-Result -Status FAIL -Check '05-output-root' -Detail $failure
                }
            }

            $outputRootAbs = Resolve-PackagePath $outputRootRelative
            $runtimeAbs = Join-Path $outputRootAbs 'runtime'
            $runStateAbs = Join-Path $runtimeAbs 'run-state.yaml'
            $eventsAbs = Join-Path $runtimeAbs 'events.ndjson'

            if (Test-Path -LiteralPath $runStateAbs -PathType Leaf) {
                Add-Result -Status PASS -Check '06-run-state-file' -Detail 'runtime/run-state.yaml exists.'
            }
            else {
                Add-Result -Status FAIL -Check '06-run-state-file' -Detail 'runtime/run-state.yaml is missing.'
            }

            if (Test-Path -LiteralPath $eventsAbs -PathType Leaf) {
                Add-Result -Status PASS -Check '07-events-file' -Detail 'runtime/events.ndjson exists.'
            }
            else {
                Add-Result -Status FAIL -Check '07-events-file' -Detail 'runtime/events.ndjson is missing.'
            }

            if (Test-Path -LiteralPath $runtimeAbs -PathType Container) {
                $runtimePathFailures = @()
                foreach ($item in @(Get-ChildItem -LiteralPath $runtimeAbs -Recurse -Force)) {
                    if (-not (Test-PathUnderRoot -ChildPath $item.FullName -RootPath $outputRootAbs)) {
                        $runtimePathFailures += (Convert-ToRepoPath $item.FullName)
                    }
                }
                if ($runtimePathFailures.Count -eq 0) {
                    Add-Result -Status PASS -Check '08-runtime-path-containment' -Detail 'Every runtime file and folder is under output_root/runtime/.'
                }
                else {
                    Add-Result -Status FAIL -Check '08-runtime-path-containment' -Detail ('Runtime path escaped output_root: ' + ($runtimePathFailures -join ', '))
                }
            }
            else {
                Add-Result -Status FAIL -Check '08-runtime-path-containment' -Detail 'runtime/ folder is missing.'
            }

            $handoffSteps = @('AM3-01', 'AM3-02', 'AM3-03', 'AM3-04', 'AM3-05', 'AM3-06')
            $handoffFailures = @()
            foreach ($step in $handoffSteps) {
                $requestPath = Join-Path $runtimeAbs "handoffs/$step/request.yaml"
                $responsePath = Join-Path $runtimeAbs "handoffs/$step/response.yaml"
                if (-not (Test-Path -LiteralPath $requestPath -PathType Leaf)) { $handoffFailures += "$step request.yaml missing" }
                if (-not (Test-Path -LiteralPath $responsePath -PathType Leaf)) { $handoffFailures += "$step response.yaml missing" }
            }
            $handoffsAbs = Join-Path $runtimeAbs 'handoffs'
            if (Test-Path -LiteralPath $handoffsAbs -PathType Container) {
                foreach ($dir in @(Get-ChildItem -LiteralPath $handoffsAbs -Force -Directory)) {
                    if ($handoffSteps -notcontains $dir.Name) {
                        $handoffFailures += "Unexpected handoff folder: $($dir.Name)"
                    }
                }
            }
            if ($handoffFailures.Count -eq 0) {
                Add-Result -Status PASS -Check '09-handoff-files' -Detail 'AM3-01 through AM3-06 request/response handoff files exist and no extra handoff folder exists.'
            }
            else {
                foreach ($failure in $handoffFailures) {
                    Add-Result -Status FAIL -Check '09-handoff-files' -Detail $failure
                }
            }

            $expectedOutputsByStep = [ordered]@{
                'AM3-01' = @("$outputRootRelative/01-input-inventory.md")
                'AM3-02' = @("$outputRootRelative/dfd/", "$outputRootRelative/02-components-rs.md", "$outputRootRelative/03-flows-rs.md", "$outputRootRelative/04-boundaries-rs.md", "$outputRootRelative/05-design-facts.md", "$outputRootRelative/06-dfd-intake-verdict.md")
                'AM3-03' = @("$outputRootRelative/07-security-stack-assessment.md", "$outputRootRelative/08-internal-review-table.md")
                'AM3-04' = @("$outputRootRelative/09-missing-facts.md", "$outputRootRelative/10-ai-action-level.md", "$outputRootRelative/11-blueprint-match.md", "$outputRootRelative/12-targeted-questions.md")
                'AM3-05' = @("$outputRootRelative/13-findings.md", "$outputRootRelative/14-recommendations.md")
                'AM3-06' = @("$outputRootRelative/15-handoff-pack.md", "$outputRootRelative/16-validation-notes.md", "$outputRootRelative/17-accuracy-score.md")
            }
            $upstreamFailures = @()
            $expectedUpstream = @()
            foreach ($step in $handoffSteps) {
                $requestPath = Join-Path $runtimeAbs "handoffs/$step/request.yaml"
                if (Test-Path -LiteralPath $requestPath -PathType Leaf) {
                    try {
                        $actualUpstream = @(Get-SimpleYamlList -Path $requestPath -Key 'upstream_artifacts')
                        if (-not (Test-StringArrayEqual -Actual $actualUpstream -Expected $expectedUpstream)) {
                            $upstreamFailures += "$step upstream_artifacts mismatch; expected=$($expectedUpstream -join ', '); actual=$($actualUpstream -join ', ')"
                        }
                    }
                    catch {
                        $upstreamFailures += "$step upstream_artifacts parse failure: $($_.Exception.Message)"
                    }
                }
                $expectedUpstream += @($expectedOutputsByStep[$step])
            }
            if ($upstreamFailures.Count -eq 0) {
                Add-Result -Status PASS -Check '09-upstream-artifacts' -Detail 'AM3-01 uses an empty upstream_artifacts array; AM3-02 through AM3-06 require the accumulated prior-step outputs.'
            }
            else {
                foreach ($failure in $upstreamFailures) {
                    Add-Result -Status FAIL -Check '09-upstream-artifacts' -Detail $failure
                }
            }

            $events = New-Object System.Collections.Generic.List[psobject]
            $eventParseFailures = @()
            if (Test-Path -LiteralPath $eventsAbs -PathType Leaf) {
                $eventLineNo = 0
                foreach ($line in (Get-Content -LiteralPath $eventsAbs)) {
                    $eventLineNo++
                    if ([string]::IsNullOrWhiteSpace($line)) {
                        $eventParseFailures += "Blank NDJSON line $eventLineNo"
                        continue
                    }
                    try {
                        $event = $line | ConvertFrom-Json -ErrorAction Stop
                        if ($event -is [array]) {
                            $eventParseFailures += "NDJSON line $eventLineNo parsed as an array"
                        }
                        else {
                            $events.Add($event)
                        }
                    }
                    catch {
                        $eventParseFailures += "NDJSON line $eventLineNo failed JSON parse: $($_.Exception.Message)"
                    }
                }
            }
            if ($eventParseFailures.Count -eq 0 -and $events.Count -gt 0) {
                Add-Result -Status PASS -Check '10-events-ndjson' -Detail "events.ndjson contains $($events.Count) parseable event line(s)."
            }
            else {
                if ($events.Count -eq 0) { $eventParseFailures += 'No events parsed from events.ndjson.' }
                foreach ($failure in $eventParseFailures) {
                    Add-Result -Status FAIL -Check '10-events-ndjson' -Detail $failure
                }
            }

            if ($events.Count -gt 0) {
                $requiredEventFields = @('schema_version', 'event_id', 'run_id', 'timestamp', 'event_type', 'step_id', 'actor', 'checkpoint_id', 'previous_state', 'next_state', 'input_ref', 'output_ref', 'validator_ref', 'policy_decision', 'human_gate_ref')
                $eventFieldFailures = @()
                $eventEnumFailures = @()
                $eventIndex = 0
                foreach ($event in $events) {
                    $eventIndex++
                    $fieldNames = @($event.PSObject.Properties | ForEach-Object { $_.Name })
                    foreach ($field in $requiredEventFields) {
                        if ($fieldNames -notcontains $field) {
                            $eventFieldFailures += "event $eventIndex missing field $field"
                        }
                    }
                    foreach ($field in $fieldNames) {
                        if ($requiredEventFields -notcontains $field) {
                            $eventFieldFailures += "event $eventIndex has extra field $field"
                        }
                    }
                    if ($EventTypeEnum -notcontains $event.event_type) {
                        $eventEnumFailures += "event $eventIndex event_type '$($event.event_type)' is outside contract enum"
                    }
                    if ($StepEnum -notcontains $event.step_id) {
                        $eventEnumFailures += "event $eventIndex step_id '$($event.step_id)' is outside AM3 enum"
                    }
                }
                if ($eventFieldFailures.Count -eq 0) {
                    Add-Result -Status PASS -Check '11-event-fields' -Detail 'Every event uses the strict AM3 event field set.'
                }
                else {
                    foreach ($failure in $eventFieldFailures) {
                        Add-Result -Status FAIL -Check '11-event-fields' -Detail $failure
                    }
                }
                if ($eventEnumFailures.Count -eq 0) {
                    Add-Result -Status PASS -Check '12-event-enums' -Detail 'All event_type and step_id values match the contract enums.'
                }
                else {
                    foreach ($failure in $eventEnumFailures) {
                        Add-Result -Status FAIL -Check '12-event-enums' -Detail $failure
                    }
                }

                $handoffRequestSteps = @($events | Where-Object { $_.event_type -eq 'handoff_request' } | ForEach-Object { [string]$_.step_id })
                $handoffResponseSteps = @($events | Where-Object { $_.event_type -eq 'handoff_response' } | ForEach-Object { [string]$_.step_id })
                $requestStepMismatch = (($handoffRequestSteps -join '|') -ne ($handoffSteps -join '|'))
                $responseStepMismatch = (($handoffResponseSteps -join '|') -ne ($handoffSteps -join '|'))
                if (-not $requestStepMismatch -and -not $responseStepMismatch) {
                    Add-Result -Status PASS -Check '13-step-order' -Detail 'Handoff request/response events cover AM3-01 through AM3-06 in strict order with no skipped or extra handoff step.'
                }
                else {
                    Add-Result -Status FAIL -Check '13-step-order' -Detail "Unexpected handoff order; request=$($handoffRequestSteps -join ', '); response=$($handoffResponseSteps -join ', ')"
                }

                $getFirstEventIndex = {
                    param(
                        [Parameter(Mandatory = $true)][string]$EventType,
                        [AllowNull()][string]$StepId,
                        [AllowNull()][string]$HumanGateRef
                    )
                    for ($idx = 0; $idx -lt $events.Count; $idx++) {
                        $candidate = $events[$idx]
                        if ([string]$candidate.event_type -ne $EventType) { continue }
                        if ($null -ne $StepId -and [string]$candidate.step_id -ne $StepId) { continue }
                        if ($null -ne $HumanGateRef -and [string]$candidate.human_gate_ref -ne $HumanGateRef) { continue }
                        return $idx
                    }
                    return -1
                }
                $eventOrderingFailures = @()
                $lastOrdinal = 0
                $lastTimestamp = [datetime]::MinValue
                for ($eventIndex = 0; $eventIndex -lt $events.Count; $eventIndex++) {
                    $event = $events[$eventIndex]
                    $eventNumber = $eventIndex + 1
                    if ([string]$event.event_id -match ('^EVT-' + [regex]::Escape($runId) + '-(?<ordinal>\d{4})$')) {
                        $ordinal = [int]$Matches['ordinal']
                        if ($ordinal -ne $eventNumber) { $eventOrderingFailures += "event $eventNumber ordinal is $ordinal" }
                        if ($ordinal -le $lastOrdinal) { $eventOrderingFailures += "event $eventNumber ordinal is not increasing" }
                        $lastOrdinal = $ordinal
                    }
                    else {
                        $eventOrderingFailures += "event $eventNumber id does not match run ordinal pattern: $($event.event_id)"
                    }
                    $parsedTimestamp = [datetime]::MinValue
                    if (-not [datetime]::TryParse([string]$event.timestamp, [ref]$parsedTimestamp)) {
                        $eventOrderingFailures += "event $eventNumber timestamp is not parseable: $($event.timestamp)"
                    }
                    elseif ($eventNumber -gt 1 -and $parsedTimestamp.ToUniversalTime() -lt $lastTimestamp.ToUniversalTime()) {
                        $eventOrderingFailures += "event $eventNumber timestamp moved backward"
                    }
                    else {
                        $lastTimestamp = $parsedTimestamp
                    }
                }

                $previousValidatorIndex = -1
                foreach ($step in $handoffSteps) {
                    $requestIndex = & $getFirstEventIndex 'handoff_request' $step $null
                    $responseIndex = & $getFirstEventIndex 'handoff_response' $step $null
                    $validatorIndex = & $getFirstEventIndex 'validator_outcome' $step $null
                    if ($requestIndex -lt 0 -or $responseIndex -lt 0 -or $validatorIndex -lt 0) {
                        $eventOrderingFailures += "$step missing request/response/validator event for ordering check"
                        continue
                    }
                    if ($requestIndex -ge $responseIndex) { $eventOrderingFailures += "$step handoff_request does not precede handoff_response" }
                    if ($responseIndex -ge $validatorIndex) { $eventOrderingFailures += "$step handoff_response does not precede validator_outcome" }
                    if ($previousValidatorIndex -ge 0 -and $requestIndex -le $previousValidatorIndex) {
                        $eventOrderingFailures += "$step handoff_request does not follow the prior step validator_outcome"
                    }
                    $previousValidatorIndex = $validatorIndex
                }
                $gateIdsForOrdering = @('pre_run_approval', 'pre_output_generation_approval', 'final_review_approval', 'release_or_claim_approval', 'final_pass_partial_fail_not_applicable_decision')
                foreach ($gate in $gateIdsForOrdering) {
                    $gateRequestIndex = & $getFirstEventIndex 'gate_request' $null $gate
                    $gateDecisionIndex = & $getFirstEventIndex 'gate_decision' $null $gate
                    if ($gateRequestIndex -ge 0 -and $gateDecisionIndex -ge 0 -and $gateRequestIndex -ge $gateDecisionIndex) {
                        $eventOrderingFailures += "$gate gate_request does not precede gate_decision"
                    }
                }
                if ($eventOrderingFailures.Count -eq 0) {
                    Add-Result -Status PASS -Check '13-event-ordering' -Detail 'Event IDs, timestamps, handoff request/response/validator sequence, and gate request/decision order are valid.'
                }
                else {
                    foreach ($failure in $eventOrderingFailures) {
                        Add-Result -Status FAIL -Check '13-event-ordering' -Detail $failure
                    }
                }

                $eventStepIds = @($events | ForEach-Object { [string]$_.step_id } | Sort-Object -Unique)
                $runtimeRequiredSteps = @('AM3-INIT', 'AM3-01', 'AM3-02', 'AM3-03', 'AM3-04', 'AM3-05', 'AM3-06', 'AM3-FINAL-GATE', 'AM3-COMPLETE')
                $missingRuntimeSteps = @($runtimeRequiredSteps | Where-Object { $eventStepIds -notcontains $_ })
                $extraRuntimeSteps = @($eventStepIds | Where-Object { $ExpectedStepEnum -notcontains $_ })
                if ($missingRuntimeSteps.Count -eq 0 -and $extraRuntimeSteps.Count -eq 0) {
                    Add-Result -Status PASS -Check '14-no-skipped-or-extra-step' -Detail 'Runtime event log represents every AM3 step and no non-AM3 step.'
                }
                else {
                    Add-Result -Status FAIL -Check '14-no-skipped-or-extra-step' -Detail "missing=$($missingRuntimeSteps -join ', '); extra=$($extraRuntimeSteps -join ', ')"
                }

                $requiredGates = @('pre_run_approval', 'pre_output_generation_approval', 'final_review_approval', 'release_or_claim_approval', 'final_pass_partial_fail_not_applicable_decision')
                $gateFailures = @()
                foreach ($gate in $requiredGates) {
                    $gateRequests = @($events | Where-Object { $_.event_type -eq 'gate_request' -and $_.human_gate_ref -eq $gate })
                    $gateDecisions = @($events | Where-Object { $_.event_type -eq 'gate_decision' -and $_.human_gate_ref -eq $gate })
                    if ($gateRequests.Count -lt 1) { $gateFailures += "$gate gate_request missing" }
                    if ($gateDecisions.Count -lt 1) { $gateFailures += "$gate gate_decision missing" }
                }
                if ($gateFailures.Count -eq 0) {
                    Add-Result -Status PASS -Check '15-human-gates' -Detail 'All AM3 human gates are represented by paired gate_request and gate_decision events.'
                }
                else {
                    foreach ($failure in $gateFailures) {
                        Add-Result -Status FAIL -Check '15-human-gates' -Detail $failure
                    }
                }

                $stopFailures = @()
                $stopEvents = @($events | Where-Object { $_.event_type -eq 'stop' })
                if ($stopEvents.Count -gt 0) {
                    foreach ($stopEvent in $stopEvents) {
                        if ($stopEvent.actor -ne 'PRA-01-SAS-REVIEW-ORCHESTRATOR') { $stopFailures += "stop event actor is not orchestrator" }
                        if ($stopEvent.next_state -ne 'AM3-STOPPED') { $stopFailures += "stop event next_state is not AM3-STOPPED" }
                        if (@('stop', 'sensitive_data_violation', 'path_guard_violation', 'external_execution_attempt', 'missing_handoff_response', 'schema_fail', 'unsupported_connector_state', 'validator_fail') -notcontains $stopEvent.policy_decision) {
                            $stopFailures += "stop event policy_decision '$($stopEvent.policy_decision)' is invalid"
                        }
                    }
                    $lastEvent = $events[$events.Count - 1]
                    if ($lastEvent.event_type -ne 'stop') { $stopFailures += 'stop event is not terminal' }
                }
                if ($stopFailures.Count -eq 0) {
                    Add-Result -Status PASS -Check '16-stop-events' -Detail 'Stop events are valid when present.'
                }
                else {
                    foreach ($failure in $stopFailures) {
                        Add-Result -Status FAIL -Check '16-stop-events' -Detail $failure
                    }
                }

                $completeEvents = @($events | Where-Object { $_.step_id -eq 'AM3-COMPLETE' -and $_.event_type -eq 'orchestrator_decision' -and $_.next_state -eq 'AM3-COMPLETE' })
                if ($completeEvents.Count -ge 1 -or $stopEvents.Count -ge 1) {
                    Add-Result -Status PASS -Check '17-completion-events' -Detail 'Completion or terminal stop event is represented with a valid AM3 event.'
                }
                else {
                    Add-Result -Status FAIL -Check '17-completion-events' -Detail 'No valid AM3-COMPLETE orchestrator decision or terminal stop event found.'
                }

                $eventPathFailures = @()
                foreach ($event in $events) {
                    foreach ($field in @('output_ref')) {
                        $value = [string]$event.$field
                        if ([string]::IsNullOrWhiteSpace($value)) { continue }
                        $pathErrors = @(Test-RelativeLocalPath -PathValue $value -Name $field)
                        if ($value -notlike "$outputRootRelative/*") {
                            $pathErrors += "$field must remain under output_root: $value"
                        }
                        foreach ($pathError in $pathErrors) {
                            $eventPathFailures += "$($event.event_id): $pathError"
                        }
                    }
                    $validatorRef = [string]$event.validator_ref
                    if (-not [string]::IsNullOrWhiteSpace($validatorRef)) {
                        if ($validatorRef -notmatch '^tools/Test-Aisraf[A-Za-z0-9]+\.ps1$') {
                            $eventPathFailures += "$($event.event_id): validator_ref is not an approved local validator path: $validatorRef"
                        }
                    }
                }
                if ($eventPathFailures.Count -eq 0) {
                    Add-Result -Status PASS -Check '18-event-paths' -Detail 'Event path references are local and output references stay under output_root.'
                }
                else {
                    foreach ($failure in $eventPathFailures) {
                        Add-Result -Status FAIL -Check '18-event-paths' -Detail $failure
                    }
                }
            }

            $pra04Failures = @()
            $runtimeTextFiles = @(Get-RuntimeTextFiles -RuntimeRoot $runtimeAbs)
            foreach ($runtimeTextFile in $runtimeTextFiles) {
                $repoPath = Convert-ToRepoPath $runtimeTextFile.FullName
                $text = Get-Content -LiteralPath $runtimeTextFile.FullName -Raw
                if ($text -match 'PRA-04-LEGEND-NORMALIZER' -and $repoPath -notmatch '/runtime/handoffs/AM3-02/(request|response)\.yaml$') {
                    $pra04Failures += "PRA-04 appears outside AM3-02 handoff file: $repoPath"
                }
            }
            $am302Request = Join-Path $runtimeAbs 'handoffs/AM3-02/request.yaml'
            $am302Response = Join-Path $runtimeAbs 'handoffs/AM3-02/response.yaml'
            $am302Text = ''
            if (Test-Path -LiteralPath $am302Request -PathType Leaf) { $am302Text += (Get-Content -LiteralPath $am302Request -Raw) }
            if (Test-Path -LiteralPath $am302Response -PathType Leaf) { $am302Text += (Get-Content -LiteralPath $am302Response -Raw) }
            if ($am302Text -notmatch 'PRA-04-LEGEND-NORMALIZER') {
                $pra04Failures += 'PRA-04 embedded subskill evidence missing from AM3-02 request/response.'
            }
            if ($pra04Failures.Count -eq 0) {
                Add-Result -Status PASS -Check '19-pra04-contained' -Detail 'PRA-04 remains embedded inside AM3-02 and is not a standalone AM3 handoff step.'
            }
            else {
                foreach ($failure in $pra04Failures) {
                    Add-Result -Status FAIL -Check '19-pra04-contained' -Detail $failure
                }
            }

            $boundaryPatterns = @(
                '(?i)\bAM4\b',
                '(?i)\bAL4\b',
                '(?i)\bjira_connector_status\b',
                '(?i)\bconfluence_connector_status\b',
                '(?i)\brovo_mcp_available\b',
                '(?i)\bmcp_execution_status\b',
                '(?i)\bdestination_ticket_url\b',
                '(?i)\bdestination_confluence_url\b',
                '(?i)\bsource_ticket_url\b',
                '(?i)\bexternal_postback_executed\b',
                '(?i)\bexecuted_by_operator\b',
                '(?i)\blucidchart\b',
                '(?i)\bcloud_resource_id\b',
                '(?i)\bdatabase_connection_string\b',
                '(?i)\bterraform_workspace\b',
                '(?i)\bevent_bus_topic\b',
                '(?i)\btelemetry_backend_endpoint\b',
                '(?i)external_execution_performed\s*:\s*true',
                '(?i)external_execution_allowed\s*:\s*true'
            )
            $sensitivePatterns = @(
                @{ Name = 'url'; Pattern = '(?i)\bhttps?://[^\s\)"''<>]+' },
                @{ Name = 'email'; Pattern = '(?i)\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b' },
                @{ Name = 'bearer-token'; Pattern = '(?i)\bBearer\s+[A-Za-z0-9._~+/\-]+=*' },
                @{ Name = 'api-key'; Pattern = '(?i)\b(api[_-]?key|x-api-key|access[_-]?token|secret|password)\b\s*[:=]' },
                @{ Name = 'private-key'; Pattern = 'BEGIN (RSA |OPENSSH |EC )?PRIVATE KEY' },
                @{ Name = 'pan-like'; Pattern = '(?<!\d)\d{16}(?!\d)' },
                @{ Name = 'ssn-like'; Pattern = '\b\d{3}-\d{2}-\d{4}\b' },
                @{ Name = 'customer-id'; Pattern = '(?i)\b(customer|cust)[-_ ]?id\b|\bCUST-[A-Z0-9-]+\b' }
            )
            $boundaryHits = @()
            $sensitiveHits = @()
            foreach ($runtimeTextFile in $runtimeTextFiles) {
                $repoPath = Convert-ToRepoPath $runtimeTextFile.FullName
                $text = Get-Content -LiteralPath $runtimeTextFile.FullName -Raw
                foreach ($pattern in $boundaryPatterns) {
                    if ($text -match $pattern) { $boundaryHits += "$repoPath [$pattern]" }
                }
                foreach ($sensitivePattern in $sensitivePatterns) {
                    if ($text -match $sensitivePattern.Pattern) { $sensitiveHits += "$repoPath [$($sensitivePattern.Name)]" }
                }
            }
            if ($boundaryHits.Count -eq 0) {
                Add-Result -Status PASS -Check '20-am3-am4-boundary' -Detail 'Runtime files contain no AM4 fields, connector posture values, or external execution true values.'
            }
            else {
                foreach ($hit in $boundaryHits) {
                    Add-Result -Status FAIL -Check '20-am3-am4-boundary' -Detail $hit
                }
            }
            if ($sensitiveHits.Count -eq 0) {
                Add-Result -Status PASS -Check '21-sensitive-data-screen' -Detail 'Runtime files contain no credentials, API keys, emails, customer IDs, URLs, or high-risk sensitive strings.'
            }
            else {
                foreach ($hit in $sensitiveHits) {
                    Add-Result -Status FAIL -Check '21-sensitive-data-screen' -Detail $hit
                }
            }
        }
    }
}

Write-Host ''
Write-Host "Test-AisrafAm3Runtime  package_root=$PackageRoot" -ForegroundColor Cyan
if ($ContractsOnly.IsPresent -or $PSCmdlet.ParameterSetName -eq 'ContractsOnly') {
    Write-Host 'mode=ContractsOnly' -ForegroundColor Cyan
}
else {
    Write-Host "mode=Runtime  run_profile=$RunProfilePath" -ForegroundColor Cyan
}
Write-Host ''

foreach ($result in $Results) {
    $color = if ($result.Status -eq 'PASS') { 'Green' } else { 'Red' }
    Write-Host ("{0,-5}  {1,-30}  {2}" -f $result.Status, $result.Check, $result.Detail) -ForegroundColor $color
}

$failCount = @($Results | Where-Object { $_.Status -eq 'FAIL' }).Count
$passCount = @($Results | Where-Object { $_.Status -eq 'PASS' }).Count
Write-Host ''
if ($failCount -eq 0) {
    Write-Host "Test-AisrafAm3Runtime: $passCount PASS, 0 FAIL" -ForegroundColor Green
    exit 0
}

Write-Host "Test-AisrafAm3Runtime: $passCount PASS, $failCount FAIL" -ForegroundColor Red
exit 1
