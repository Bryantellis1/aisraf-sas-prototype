<#
.SYNOPSIS
    Run the BP12A automated end-to-end readiness harness for AISRAF SAS Prototype v0.1.2.

.DESCRIPTION
    Test-AisrafBp12AReadiness is a read-only Build Package 12A harness. It
    validates the package surface, RUN-001 profile, adapter projection,
    registries, prompt-skill-PRA crosswalk, templates, sample fixture,
    RUN-001 fixture, security/no-drift posture, and local agent smoke
    simulation before founder manual smoke testing begins.

    The harness does not execute prompt cards, skill contracts, PRA specs, or
    .agent.md adapters. It does not create run outputs, diagrams, release
    artifacts, external post-back evidence, runtime/cloud resources, ADK/MCP
    proof, database jobs, or Terraform evidence.

    Exit code 0 when every readiness check PASSes. Exit code 1 on any FAIL.
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$PackageRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Results = New-Object System.Collections.Generic.List[psobject]
$CommandLog = New-Object System.Collections.Generic.List[psobject]
$InspectedFiles = @{}

function Add-Result {
    param(
        [Parameter(Mandatory = $true)][string]$Area,
        [Parameter(Mandatory = $true)][ValidateSet('PASS', 'FAIL')][string]$Status,
        [Parameter(Mandatory = $true)][string]$Check,
        [Parameter(Mandatory = $true)][string]$Detail
    )
    $script:Results.Add([pscustomobject]@{
        Area   = $Area
        Status = $Status
        Check  = $Check
        Detail = $Detail
    })
}

function Resolve-PackagePath {
    param([Parameter(Mandatory = $true)][string]$RelativePath)
    return (Join-Path $script:PackageRoot $RelativePath)
}

function Convert-ToRepoPath {
    param([Parameter(Mandatory = $true)][string]$Path)
    $fullPath = (Resolve-Path -LiteralPath $Path).Path
    return $fullPath.Substring($script:PackageRoot.Length + 1).Replace('\', '/')
}

function Add-InspectedFile {
    param([Parameter(Mandatory = $true)][string]$RelativePath)
    $normalized = $RelativePath.Replace('\', '/')
    $script:InspectedFiles[$normalized] = $true
}

function Get-RepoText {
    param([Parameter(Mandatory = $true)][string]$RelativePath)
    $absolutePath = Resolve-PackagePath $RelativePath
    Add-InspectedFile $RelativePath
    return (Get-Content -LiteralPath $absolutePath -Raw)
}

function Test-RepoFileExists {
    param([Parameter(Mandatory = $true)][string]$RelativePath)
    Add-InspectedFile $RelativePath
    return (Test-Path -LiteralPath (Resolve-PackagePath $RelativePath) -PathType Leaf)
}

function Test-RepoDirExists {
    param([Parameter(Mandatory = $true)][string]$RelativePath)
    return (Test-Path -LiteralPath (Resolve-PackagePath $RelativePath) -PathType Container)
}

function Normalize-ForCompare {
    param([Parameter(Mandatory = $true)][string]$PathValue)
    return $PathValue.Trim().Trim('"').Replace('\', '/').TrimEnd('/')
}

function Invoke-LoggedCommand {
    param(
        [Parameter(Mandatory = $true)][string]$FilePath,
        [Parameter(Mandatory = $true)][string[]]$ArgumentList
    )
    $commandLine = ($FilePath + ' ' + ($ArgumentList -join ' ')).Trim()
    $outputLines = & $FilePath @ArgumentList 2>&1
    $exitCode = $LASTEXITCODE
    $outputText = ($outputLines | ForEach-Object { $_.ToString() }) -join [Environment]::NewLine
    $script:CommandLog.Add([pscustomobject]@{
        Command  = $commandLine
        ExitCode = $exitCode
    })
    return [pscustomobject]@{
        Command  = $commandLine
        ExitCode = $exitCode
        Output   = $outputText
    }
}

function Get-RegexValues {
    param(
        [Parameter(Mandatory = $true)][string]$Text,
        [Parameter(Mandatory = $true)][string]$Pattern,
        [Parameter(Mandatory = $true)][string]$GroupName
    )
    $values = New-Object System.Collections.Generic.List[string]
    foreach ($match in [regex]::Matches($Text, $Pattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)) {
        $values.Add($match.Groups[$GroupName].Value.Trim().Trim('"').Trim("'"))
    }
    return @($values | Sort-Object -Unique)
}

function Compare-Set {
    param(
        [Parameter(Mandatory = $true)][string]$Area,
        [Parameter(Mandatory = $true)][string]$Check,
        [Parameter(Mandatory = $true)][string[]]$Expected,
        [Parameter(Mandatory = $true)][string[]]$Actual,
        [Parameter(Mandatory = $true)][string]$PassDetail
    )
    $missing = @($Expected | Where-Object { $Actual -notcontains $_ })
    $extra = @($Actual | Where-Object { $Expected -notcontains $_ })
    if ($missing.Count -eq 0 -and $extra.Count -eq 0) {
        Add-Result -Area $Area -Status PASS -Check $Check -Detail $PassDetail
    }
    else {
        $parts = @()
        if ($missing.Count -gt 0) { $parts += ('missing=' + ($missing -join ', ')) }
        if ($extra.Count -gt 0) { $parts += ('extra=' + ($extra -join ', ')) }
        Add-Result -Area $Area -Status FAIL -Check $Check -Detail ($parts -join '; ')
    }
}

function Assert-FilesExist {
    param(
        [Parameter(Mandatory = $true)][string]$Area,
        [Parameter(Mandatory = $true)][string]$Check,
        [Parameter(Mandatory = $true)][string[]]$RelativePaths,
        [Parameter(Mandatory = $true)][string]$PassDetail
    )
    $missing = @()
    foreach ($relativePath in $RelativePaths) {
        if (-not (Test-RepoFileExists $relativePath)) { $missing += $relativePath }
    }
    if ($missing.Count -eq 0) {
        Add-Result -Area $Area -Status PASS -Check $Check -Detail $PassDetail
    }
    else {
        Add-Result -Area $Area -Status FAIL -Check $Check -Detail ('Missing file(s): ' + ($missing -join ', '))
    }
}

function Get-TextFixtureFiles {
    $fixtureRoots = @(
        (Resolve-PackagePath 'samples/sample-001-dfd-crop'),
        (Resolve-PackagePath 'runs/RUN-001')
    )
    $files = New-Object System.Collections.Generic.List[System.IO.FileInfo]
    foreach ($fixtureRoot in $fixtureRoots) {
        foreach ($fixtureFile in @(Get-ChildItem -LiteralPath $fixtureRoot -Recurse -Force -File)) {
            if ($fixtureFile.Extension -ieq '.png') { continue }
            $files.Add($fixtureFile)
        }
    }
    return @($files)
}

$Bp12bApprovedRunRootRsOutputs = @(
    '01-input-inventory.md',
    '02-visible-dfd-objects.md',
    '03-legend-normalization.md',
    '04-components.md',
    '05-flows.md',
    '06-boundaries.md',
    '07-security-stack-assessment.md',
    '08-internal-review-table.md',
    '09-missing-facts.md',
    '10-ai-action-level.md',
    '11-blueprint-match.md',
    '12-targeted-questions.md',
    '13-findings.md',
    '14-recommendations.md',
    '15-handoff-pack.md',
    '16-validation-notes.md',
    '17-accuracy-score.md'
)

$Bp12bApprovedRunDfdOutputs = @(
    '01-intake-quality-check.md',
    '02-boundary-catalog.md',
    '03-component-catalog.md',
    '04-flow-inventory.md',
    '05-annotation-resolution.md',
    '06-boundary-crossings.md',
    '07-control-signals.md',
    '08-confidence-score.md',
    '09-extraction-summary.md'
)

function Get-UnauthorizedRunOutputs {
    $runRoot = Resolve-PackagePath 'runs/RUN-001'
    if (-not (Test-Path -LiteralPath $runRoot -PathType Container)) { return @('runs/RUN-001 missing') }
    $allowedRootChildren = @('README.md', 'run-profile.yaml', '00-run-log.md', 'inputs', 'dfd')
    $unauthorized = New-Object System.Collections.Generic.List[string]
    foreach ($child in @(Get-ChildItem -LiteralPath $runRoot -Force)) {
        if ($allowedRootChildren -contains $child.Name) { continue }
        if ((-not $child.PSIsContainer) -and ($script:Bp12bApprovedRunRootRsOutputs -contains $child.Name)) { continue }
        $unauthorized.Add(('runs/RUN-001/' + $child.Name + ($(if ($child.PSIsContainer) { '/' } else { '' }))))
    }
    $dfdRoot = Resolve-PackagePath 'runs/RUN-001/dfd'
    if (Test-Path -LiteralPath $dfdRoot -PathType Container) {
        foreach ($dfdChild in @(Get-ChildItem -LiteralPath $dfdRoot -Force)) {
            if ($dfdChild.Name -eq '.gitkeep') { continue }
            if ((-not $dfdChild.PSIsContainer) -and ($script:Bp12bApprovedRunDfdOutputs -contains $dfdChild.Name)) { continue }
            $unauthorized.Add(('runs/RUN-001/dfd/' + $dfdChild.Name + ($(if ($dfdChild.PSIsContainer) { '/' } else { '' }))))
        }
    }
    return @($unauthorized)
}

function Test-PositiveExecutionClaim {
    param([Parameter(Mandatory = $true)][string]$Text)
    $claimPatterns = @(
        'runtime_deployed:\s*true',
        'adk_deployed:\s*true',
        'cloud_resources_created:\s*true',
        'database_jobs_created:\s*true',
        'mcp_execution_available:\s*true',
        'jira_confluence_execution_available:\s*true',
        '(?m)^\s*postback_execution_status:\s*["'']?executed_by_operator["'']?\s*$',
        '(?m)^\s*output_destination_mode:\s*["'']?external_postback_executed["'']?\s*$',
        '\bJira post-back executed\b',
        '\bConfluence publication executed\b',
        '\bTerraform applied\b',
        '(?im)^\s*(?:ai_action_level|selected_ai_action_level|level)\s*:\s*["'']?AAL-L4\b',
        '(?i)\b(?:AAL-L4[^\r\n]{0,80}autonomous|autonomous[^\r\n]{0,80}AAL-L4)\b'
    )
    foreach ($claimPattern in $claimPatterns) {
        if ($Text -match $claimPattern) { return $claimPattern }
    }
    return $null
}

$ApprovedAdapters = @(
    [pscustomobject]@{ Agent = 'AISRAF Orchestrator'; File = 'aisraf-orchestrator.agent.md'; AdapterPath = '.agents/aisraf-orchestrator.agent.md'; ProjectionPath = '.github/agents/aisraf-orchestrator.agent.md'; PraFiles = @('prototype-agents/PRA-01-SAS-REVIEW-ORCHESTRATOR.md'); SkillRequired = $false },
    [pscustomobject]@{ Agent = 'AISRAF Input Reader'; File = 'aisraf-input-reader.agent.md'; AdapterPath = '.agents/aisraf-input-reader.agent.md'; ProjectionPath = '.github/agents/aisraf-input-reader.agent.md'; PraFiles = @('prototype-agents/PRA-02-INPUT-READER.md'); SkillRequired = $true },
    [pscustomobject]@{ Agent = 'AISRAF DFD Extractor'; File = 'aisraf-dfd-extractor.agent.md'; AdapterPath = '.agents/aisraf-dfd-extractor.agent.md'; ProjectionPath = '.github/agents/aisraf-dfd-extractor.agent.md'; PraFiles = @('prototype-agents/PRA-03-DFD-EXTRACTOR.md', 'prototype-agents/PRA-04-LEGEND-NORMALIZER.md'); SkillRequired = $true },
    [pscustomobject]@{ Agent = 'AISRAF Review Table Builder'; File = 'aisraf-review-table-builder.agent.md'; AdapterPath = '.agents/aisraf-review-table-builder.agent.md'; ProjectionPath = '.github/agents/aisraf-review-table-builder.agent.md'; PraFiles = @('prototype-agents/PRA-05-REVIEW-TABLE-BUILDER.md'); SkillRequired = $true },
    [pscustomobject]@{ Agent = 'AISRAF Blueprint Questioner'; File = 'aisraf-blueprint-questioner.agent.md'; AdapterPath = '.agents/aisraf-blueprint-questioner.agent.md'; ProjectionPath = '.github/agents/aisraf-blueprint-questioner.agent.md'; PraFiles = @('prototype-agents/PRA-06-BLUEPRINT-QUESTIONER.md'); SkillRequired = $true },
    [pscustomobject]@{ Agent = 'AISRAF Finding Recommender'; File = 'aisraf-finding-recommender.agent.md'; AdapterPath = '.agents/aisraf-finding-recommender.agent.md'; ProjectionPath = '.github/agents/aisraf-finding-recommender.agent.md'; PraFiles = @('prototype-agents/PRA-07-FINDING-RECOMMENDER.md'); SkillRequired = $true },
    [pscustomobject]@{ Agent = 'AISRAF Handoff QA Scorer'; File = 'aisraf-handoff-qa-scorer.agent.md'; AdapterPath = '.agents/aisraf-handoff-qa-scorer.agent.md'; ProjectionPath = '.github/agents/aisraf-handoff-qa-scorer.agent.md'; PraFiles = @('prototype-agents/PRA-08-HANDOFF-QA-SCORER.md'); SkillRequired = $true }
)

$ExpectedPromptFiles = @(
    'prompts/rs/00-run-full-chain.prompt.md',
    'prompts/rs/01-input-package-read.prompt.md',
    'prompts/rs/02-dfd-visual-read.prompt.md',
    'prompts/rs/03-legend-normalization.prompt.md',
    'prompts/rs/04-design-fact-extract.prompt.md',
    'prompts/rs/05-boundary-stack-detect.prompt.md',
    'prompts/rs/06-review-table-build.prompt.md',
    'prompts/rs/07-missing-fact-question-generate.prompt.md',
    'prompts/rs/08-ai-action-level-classify.prompt.md',
    'prompts/rs/09-blueprint-match.prompt.md',
    'prompts/rs/10-finding-recommendation-write.prompt.md',
    'prompts/rs/11-handoff-pack-build.prompt.md',
    'prompts/rs/12-validation-note-write.prompt.md',
    'prompts/rs/13-accuracy-score.prompt.md',
    'prompts/dfd/02-dfd-intake-quality-check.prompt.md',
    'prompts/dfd/03-boundary-extract.prompt.md',
    'prompts/dfd/04-component-extract.prompt.md',
    'prompts/dfd/05-flow-extract.prompt.md',
    'prompts/dfd/06-annotation-resolve.prompt.md',
    'prompts/dfd/07-boundary-crossing-detect.prompt.md',
    'prompts/dfd/08-control-signal-detect.prompt.md',
    'prompts/dfd/09-confidence-score.prompt.md',
    'prompts/dfd/10-dfd-extraction-summarize.prompt.md'
)

$ExpectedRsSkillFiles = @(
    'skills/rs/SK-INPUT-PACKAGE-READ.md',
    'skills/rs/SK-DFD-VISUAL-READ.md',
    'skills/rs/SK-LEGEND-NORMALIZE.md',
    'skills/rs/SK-COMPONENT-EXTRACT.md',
    'skills/rs/SK-FLOW-EXTRACT.md',
    'skills/rs/SK-BOUNDARY-CROSSING-DETECT.md',
    'skills/rs/SK-SECURITY-STACK-ASSESS.md',
    'skills/rs/SK-DATA-FLOW-TABLE-BUILD.md',
    'skills/rs/SK-MISSING-FACT-IDENTIFY.md',
    'skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md',
    'skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md',
    'skills/rs/SK-TARGETED-QUESTION-GENERATE.md',
    'skills/rs/SK-FINDING-CLASSIFY.md',
    'skills/rs/SK-RECOMMENDATION-WRITE.md',
    'skills/rs/SK-HANDOFF-PACK-BUILD.md',
    'skills/rs/SK-VALIDATION-NOTE-WRITE.md',
    'skills/rs/SK-ACCURACY-SCORE.md'
)

$ExpectedDfdSkillFiles = @(
    'skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md',
    'skills/dfd/SK-DFD-02-BOUNDARY-EXTRACT.md',
    'skills/dfd/SK-DFD-03-COMPONENT-EXTRACT.md',
    'skills/dfd/SK-DFD-04-FLOW-EXTRACT.md',
    'skills/dfd/SK-DFD-05-ANNOTATION-RESOLVE.md',
    'skills/dfd/SK-DFD-06-BOUNDARY-CROSSING-DETECT.md',
    'skills/dfd/SK-DFD-07-CONTROL-SIGNAL-DETECT.md',
    'skills/dfd/SK-DFD-08-CONFIDENCE-SCORE.md',
    'skills/dfd/SK-DFD-09-EXTRACTION-SUMMARIZE.md'
)

$ExpectedSkillFiles = @($ExpectedRsSkillFiles + $ExpectedDfdSkillFiles)
$ExpectedAdapterFiles = @($ApprovedAdapters | ForEach-Object { $_.File })
$ExpectedPraFiles = @($ApprovedAdapters | ForEach-Object { $_.PraFiles } | Select-Object -Unique)

$UnauthorizedBefore = @(Get-UnauthorizedRunOutputs)

# 1. Git and workspace state.
$manifestText = Get-RepoText 'PACKAGE-MANIFEST.yaml'
$manifestRootMatch = [regex]::Match($manifestText, '(?m)^active_workspace:\s*(?<path>.+)$')
$manifestRoot = if ($manifestRootMatch.Success) { Normalize-ForCompare $manifestRootMatch.Groups['path'].Value } else { '' }
$gitRootResult = Invoke-LoggedCommand -FilePath 'git' -ArgumentList @('rev-parse', '--show-toplevel')
$gitRoot = Normalize-ForCompare $gitRootResult.Output
$packageRootNormalized = Normalize-ForCompare $PackageRoot
if ($gitRootResult.ExitCode -eq 0 -and $gitRoot -eq $packageRootNormalized -and $manifestRoot -eq $packageRootNormalized) {
    Add-Result -Area '01-git-workspace' -Status PASS -Check 'repo-root' -Detail "Repo root, Git top-level, and manifest active_workspace agree: $packageRootNormalized"
}
else {
    Add-Result -Area '01-git-workspace' -Status FAIL -Check 'repo-root' -Detail "packageRoot=$packageRootNormalized gitRoot=$gitRoot manifestRoot=$manifestRoot"
}

$branchResult = Invoke-LoggedCommand -FilePath 'git' -ArgumentList @('branch', '--show-current')
$branch = $branchResult.Output.Trim()
if ($branchResult.ExitCode -eq 0 -and $branch.Length -gt 0) {
    Add-Result -Area '01-git-workspace' -Status PASS -Check 'branch' -Detail "Current branch: $branch"
}
else {
    Add-Result -Area '01-git-workspace' -Status FAIL -Check 'branch' -Detail 'Unable to resolve current branch.'
}

$statusResult = Invoke-LoggedCommand -FilePath 'git' -ArgumentList @('status', '--short')
if ($statusResult.ExitCode -eq 0) {
    $statusLines = @($statusResult.Output -split "`r?`n" | Where-Object { $_.Trim().Length -gt 0 })
    Add-Result -Area '01-git-workspace' -Status PASS -Check 'git-status' -Detail ("git status --short returned {0} row(s): {1}" -f $statusLines.Count, ($(if ($statusLines.Count -gt 0) { $statusLines -join ' | ' } else { 'clean' })))
}
else {
    Add-Result -Area '01-git-workspace' -Status FAIL -Check 'git-status' -Detail 'git status --short failed.'
}

$stagedResult = Invoke-LoggedCommand -FilePath 'git' -ArgumentList @('diff', '--cached', '--name-only')
$stagedFiles = @($stagedResult.Output -split "`r?`n" | Where-Object { $_.Trim().Length -gt 0 })
if ($stagedResult.ExitCode -eq 0 -and $stagedFiles.Count -eq 0) {
    Add-Result -Area '01-git-workspace' -Status PASS -Check 'no-staged-files' -Detail 'No files are staged.'
}
else {
    Add-Result -Area '01-git-workspace' -Status FAIL -Check 'no-staged-files' -Detail ('Staged file(s): ' + ($stagedFiles -join ', '))
}

$claudeTrackedResult = Invoke-LoggedCommand -FilePath 'git' -ArgumentList @('ls-files', '--', '.claude')
$claudeStagedResult = Invoke-LoggedCommand -FilePath 'git' -ArgumentList @('diff', '--cached', '--name-only', '--', '.claude')
$claudeTracked = @($claudeTrackedResult.Output -split "`r?`n" | Where-Object { $_.Trim().Length -gt 0 })
$claudeStaged = @($claudeStagedResult.Output -split "`r?`n" | Where-Object { $_.Trim().Length -gt 0 })
if ($claudeTracked.Count -eq 0 -and $claudeStaged.Count -eq 0) {
    Add-Result -Area '01-git-workspace' -Status PASS -Check 'claude-excluded' -Detail '.claude/ is not tracked or staged; exclude it from commit planning.'
}
else {
    Add-Result -Area '01-git-workspace' -Status FAIL -Check 'claude-excluded' -Detail '.claude/ is tracked or staged.'
}

$trackedDiffResult = Invoke-LoggedCommand -FilePath 'git' -ArgumentList @('diff', '--name-only')
$trackedDiffFiles = @($trackedDiffResult.Output -split "`r?`n" | Where-Object { $_.Trim().Length -gt 0 })
$bp12bApprovedExpectedBaselineRefreshDrift = @(
    'samples/sample-001-dfd-crop/expected/expected-01-input-inventory.md',
    'samples/sample-001-dfd-crop/expected/expected-10-ai-action-level.md',
    'samples/sample-001-dfd-crop/expected/expected-11-blueprint-match.md',
    'samples/sample-001-dfd-crop/expected/expected-12-targeted-questions.md',
    'samples/sample-001-dfd-crop/expected/expected-13-findings.md',
    'samples/sample-001-dfd-crop/expected/expected-14-recommendations.md',
    'samples/sample-001-dfd-crop/expected/expected-15-handoff-pack.md',
    'samples/sample-001-dfd-crop/expected/expected-16-validation-notes.md',
    'samples/sample-001-dfd-crop/expected/expected-17-accuracy-score.md'
)
$bp12bApprovedPostExecutionRunLogDrift = @(
    'runs/RUN-001/00-run-log.md'
)
$allowedTrackedDrift = @('tools/Test-AisrafPackage.ps1', 'tools/Test-AisrafBp12AReadiness.ps1', 'tools/README.md') + $bp12bApprovedExpectedBaselineRefreshDrift + $bp12bApprovedPostExecutionRunLogDrift
$unexpectedTrackedDiff = @($trackedDiffFiles | Where-Object { $allowedTrackedDrift -notcontains $_ })
if ($trackedDiffResult.ExitCode -eq 0 -and $unexpectedTrackedDiff.Count -eq 0) {
    Add-Result -Area '01-git-workspace' -Status PASS -Check 'tracked-drift' -Detail ("Tracked drift restricted to governed tooling support, BP12B approved expected-baseline refresh paths, and BP12B approved post-execution run-log appendage: {0}" -f ($(if ($trackedDiffFiles.Count -gt 0) { $trackedDiffFiles -join ', ' } else { 'none' })))
}
else {
    Add-Result -Area '01-git-workspace' -Status FAIL -Check 'tracked-drift' -Detail ('Unexpected tracked drift: ' + ($unexpectedTrackedDiff -join ', '))
}

# 2. Package surface and 3. Run profile.
$profileValidator = Invoke-LoggedCommand -FilePath 'pwsh' -ArgumentList @('-NoProfile', '-File', (Resolve-PackagePath 'tools/Test-AisrafRunProfile.ps1'), '-RunProfilePath', (Resolve-PackagePath 'runs/RUN-001/run-profile.yaml'), '-ExecutionReady')
if ($profileValidator.ExitCode -eq 0 -and $profileValidator.Output -match '12 PASS, 0 FAIL') {
    Add-Result -Area '03-run-profile' -Status PASS -Check 'execution-ready' -Detail 'Test-AisrafRunProfile.ps1 returned 12 PASS, 0 FAIL for RUN-001.'
}
else {
    Add-Result -Area '03-run-profile' -Status FAIL -Check 'execution-ready' -Detail ($profileValidator.Output -replace "`r?`n", ' | ')
}

$packageValidator = Invoke-LoggedCommand -FilePath 'pwsh' -ArgumentList @('-NoProfile', '-File', (Resolve-PackagePath 'tools/Test-AisrafPackage.ps1'))
if ($packageValidator.ExitCode -eq 0 -and $packageValidator.Output -match '0 FAIL') {
    $summaryMatch = [regex]::Match($packageValidator.Output, 'Test-AisrafPackage:\s*(?<summary>[^\r\n]+)')
    $summary = if ($summaryMatch.Success) { $summaryMatch.Groups['summary'].Value } else { '0 FAIL' }
    Add-Result -Area '02-package-surface' -Status PASS -Check 'package-validator' -Detail "Test-AisrafPackage.ps1 returned $summary."
}
else {
    Add-Result -Area '02-package-surface' -Status FAIL -Check 'package-validator' -Detail ($packageValidator.Output -replace "`r?`n", ' | ')
}

# 4. Agent discovery projection.
$canonicalAgentFiles = @()
if (Test-RepoDirExists '.agents') {
    $canonicalAgentFiles = @(Get-ChildItem -LiteralPath (Resolve-PackagePath '.agents') -Force -File -Filter '*.agent.md' | ForEach-Object { $_.Name } | Sort-Object)
}
Compare-Set -Area '04-agent-projection' -Check 'canonical-adapters' -Expected $ExpectedAdapterFiles -Actual $canonicalAgentFiles -PassDetail '.agents/ contains exactly the 7 approved adapter files.'

$githubProjectionExists = Test-RepoDirExists '.github/agents'
$rootProjectionExists = Test-RepoDirExists 'agents'
if ($githubProjectionExists -and -not $rootProjectionExists) {
    Add-Result -Area '04-agent-projection' -Status PASS -Check 'projection-location' -Detail '.github/agents/ projection exists; root agents/ projection absent.'
}
elseif ($rootProjectionExists -and -not $githubProjectionExists) {
    Add-Result -Area '04-agent-projection' -Status PASS -Check 'projection-location' -Detail 'agents/ projection exists; .github/agents/ projection absent.'
}
else {
    Add-Result -Area '04-agent-projection' -Status FAIL -Check 'projection-location' -Detail "Expected exactly one projection folder; .github/agents=$githubProjectionExists agents=$rootProjectionExists"
}

$projectionRoot = if ($githubProjectionExists) { '.github/agents' } else { 'agents' }
$projectionFiles = @()
if (Test-RepoDirExists $projectionRoot) {
    $projectionFiles = @(Get-ChildItem -LiteralPath (Resolve-PackagePath $projectionRoot) -Force -File -Filter '*.agent.md' | ForEach-Object { $_.Name } | Sort-Object)
}
Compare-Set -Area '04-agent-projection' -Check 'projection-adapters' -Expected $ExpectedAdapterFiles -Actual $projectionFiles -PassDetail "$projectionRoot/ contains exactly the 7 approved projection files."

$allAgentMd = @(Get-ChildItem -LiteralPath $PackageRoot -Recurse -Force -File -Filter '*.agent.md' |
    Where-Object { $_.FullName -notlike '*\.git\*' } |
    ForEach-Object { Convert-ToRepoPath $_.FullName } |
    Sort-Object)
$allowedAgentMd = @($ExpectedAdapterFiles | ForEach-Object { ".agents/$_" }) + @($ExpectedAdapterFiles | ForEach-Object { "$projectionRoot/$_" })
Compare-Set -Area '04-agent-projection' -Check 'unknown-agent-files' -Expected $allowedAgentMd -Actual $allAgentMd -PassDetail 'No unknown .agent.md files exist outside canonical/projection surfaces.'

$projectionDiffs = @()
foreach ($adapterFile in $ExpectedAdapterFiles) {
    $canonicalPath = Resolve-PackagePath (".agents/$adapterFile")
    $projectionPath = Resolve-PackagePath ("$projectionRoot/$adapterFile")
    if ((Test-Path -LiteralPath $canonicalPath -PathType Leaf) -and (Test-Path -LiteralPath $projectionPath -PathType Leaf)) {
        $canonicalHash = (Get-FileHash -LiteralPath $canonicalPath -Algorithm SHA256).Hash
        $projectionHash = (Get-FileHash -LiteralPath $projectionPath -Algorithm SHA256).Hash
        if ($canonicalHash -ne $projectionHash) { $projectionDiffs += $adapterFile }
    }
}
if ($projectionDiffs.Count -eq 0) {
    Add-Result -Area '04-agent-projection' -Status PASS -Check 'byte-identical' -Detail 'Projection files are SHA-256 byte-identical to .agents/ canonical adapters.'
}
else {
    Add-Result -Area '04-agent-projection' -Status FAIL -Check 'byte-identical' -Detail ('Projection mismatch: ' + ($projectionDiffs -join ', '))
}

$prototypeRegistryText = Get-RepoText 'prototype-agents/prototype-agent-registry.yaml'
if ($prototypeRegistryText -match 'PRA-04-LEGEND-NORMALIZER' -and $prototypeRegistryText -match 'has_dedicated_adapter:\s*false' -and $prototypeRegistryText -match 'mapped_adapter:\s*\.agents/aisraf-dfd-extractor\.agent\.md') {
    Add-Result -Area '04-agent-projection' -Status PASS -Check 'pra-04-exception' -Detail 'PRA-04 has no dedicated adapter and is governed through AISRAF DFD Extractor.'
}
else {
    Add-Result -Area '04-agent-projection' -Status FAIL -Check 'pra-04-exception' -Detail 'PRA-04 adapter exception is missing or ambiguous.'
}

# 5. Prompt registry.
$promptRegistryText = Get-RepoText 'prompts/prompt-registry.yaml'
$promptFilesInRegistry = Get-RegexValues -Text $promptRegistryText -Pattern '^\s*prompt_file:\s*(?<path>\S+)' -GroupName 'path'
Compare-Set -Area '05-prompt-registry' -Check 'prompt-files' -Expected $ExpectedPromptFiles -Actual $promptFilesInRegistry -PassDetail 'prompt-registry.yaml resolves all 23 prompt files.'
Assert-FilesExist -Area '05-prompt-registry' -Check 'prompt-file-presence' -RelativePaths $ExpectedPromptFiles -PassDetail 'All 23 prompt files exist on disk.'

$expectedRsPromptIds = @(1..13 | ForEach-Object { 'PR-RS-{0:D2}' -f $_ })
$rsPromptIdFailures = @()
foreach ($promptId in $expectedRsPromptIds) {
    if ($promptRegistryText -notmatch ("prompt_id:\s*$promptId\b")) { $rsPromptIdFailures += $promptId }
}
if ($rsPromptIdFailures.Count -eq 0) {
    Add-Result -Area '05-prompt-registry' -Status PASS -Check 'rs-01-through-13' -Detail 'RS prompts PR-RS-01 through PR-RS-13 are registered.'
}
else {
    Add-Result -Area '05-prompt-registry' -Status FAIL -Check 'rs-01-through-13' -Detail ('Missing RS prompt id(s): ' + ($rsPromptIdFailures -join ', '))
}

$expectedDfdPromptIds = @(2..10 | ForEach-Object { 'PR-DFD-{0:D2}' -f $_ })
$dfdPromptIdFailures = @()
foreach ($promptId in $expectedDfdPromptIds) {
    if ($promptRegistryText -notmatch ("prompt_id:\s*$promptId\b")) { $dfdPromptIdFailures += $promptId }
}
if ($dfdPromptIdFailures.Count -eq 0) {
    Add-Result -Area '05-prompt-registry' -Status PASS -Check 'dfd-prompts' -Detail 'DFD prompts PR-DFD-02 through PR-DFD-10 are registered.'
}
else {
    Add-Result -Area '05-prompt-registry' -Status FAIL -Check 'dfd-prompts' -Detail ('Missing DFD prompt id(s): ' + ($dfdPromptIdFailures -join ', '))
}

if ($promptRegistryText -match 'prompt_id:\s*PR-RS-00' -and $promptRegistryText -match 'status:\s*planned' -and $promptRegistryText -match 'Wrapper card') {
    Add-Result -Area '05-prompt-registry' -Status PASS -Check 'wrapper-exception' -Detail 'PR-RS-00 is registered as a planned wrapper and not treated as an orphan active prompt.'
}
else {
    Add-Result -Area '05-prompt-registry' -Status FAIL -Check 'wrapper-exception' -Detail 'PR-RS-00 planned wrapper evidence missing.'
}

# 6. Skill registry.
$skillRegistryText = Get-RepoText 'skills/skill-registry.yaml'
$skillFilesInRegistry = Get-RegexValues -Text $skillRegistryText -Pattern '^\s*skill_file:\s*(?<path>\S+)' -GroupName 'path'
Compare-Set -Area '06-skill-registry' -Check 'skill-files' -Expected $ExpectedSkillFiles -Actual $skillFilesInRegistry -PassDetail 'skill-registry.yaml resolves all 26 active skills.'
Assert-FilesExist -Area '06-skill-registry' -Check 'skill-file-presence' -RelativePaths $ExpectedSkillFiles -PassDetail 'All 26 skill files exist on disk.'

$actualRsSkillFiles = @(Get-ChildItem -LiteralPath (Resolve-PackagePath 'skills/rs') -Force -File -Filter 'SK-*.md' | ForEach-Object { 'skills/rs/' + $_.Name } | Sort-Object)
$actualDfdSkillFiles = @(Get-ChildItem -LiteralPath (Resolve-PackagePath 'skills/dfd') -Force -File -Filter 'SK-DFD-0*.md' | ForEach-Object { 'skills/dfd/' + $_.Name } | Sort-Object)
Compare-Set -Area '06-skill-registry' -Check 'rs-skills-count' -Expected $ExpectedRsSkillFiles -Actual $actualRsSkillFiles -PassDetail '17 RS skill contracts exist.'
Compare-Set -Area '06-skill-registry' -Check 'dfd-skills-count' -Expected $ExpectedDfdSkillFiles -Actual $actualDfdSkillFiles -PassDetail '9 DFD skill contracts exist.'
if ($skillRegistryText -match 'planned_skill_id:\s*SK-CHAIN-WRAPPER' -and $skillRegistryText -match 'status:\s*deferred' -and -not (Test-RepoFileExists 'skills/rs/SK-CHAIN-WRAPPER.md') -and -not (Test-RepoFileExists 'skills/dfd/SK-CHAIN-WRAPPER.md')) {
    Add-Result -Area '06-skill-registry' -Status PASS -Check 'chain-wrapper-deferred' -Detail 'SK-CHAIN-WRAPPER remains deferred and is not counted as active.'
}
else {
    Add-Result -Area '06-skill-registry' -Status FAIL -Check 'chain-wrapper-deferred' -Detail 'SK-CHAIN-WRAPPER deferral evidence failed.'
}

# 7. Prompt-skill-agent crosswalk.
$crosswalkStart = $prototypeRegistryText.IndexOf('prompt_skill_agent_crosswalk:')
$crosswalkText = if ($crosswalkStart -ge 0) { $prototypeRegistryText.Substring($crosswalkStart) } else { '' }
$crosswalkPromptIds = Get-RegexValues -Text $crosswalkText -Pattern '^\s*-\s*prompt_id:\s*(?<id>\S+)' -GroupName 'id'
$expectedPromptIds = @('PR-RS-00') + $expectedRsPromptIds + $expectedDfdPromptIds
Compare-Set -Area '07-crosswalk' -Check 'prompt-to-skill-agent' -Expected $expectedPromptIds -Actual $crosswalkPromptIds -PassDetail 'Every prompt maps through the prompt-skill-agent crosswalk or governed wrapper exception.'

$crosswalkSkills = Get-RegexValues -Text $crosswalkText -Pattern '^\s*-\s*(?<path>skills/(?:rs|dfd)/[^\s]+\.md)' -GroupName 'path'
Compare-Set -Area '07-crosswalk' -Check 'active-skills-owned' -Expected $ExpectedSkillFiles -Actual $crosswalkSkills -PassDetail 'Every active skill maps to an owning PRA in the crosswalk.'

$registryAdapterFiles = Get-RegexValues -Text $prototypeRegistryText -Pattern '^\s*adapter_file:\s*(?<path>\.agents/[^\s]+\.agent\.md)' -GroupName 'path'
$expectedAdapterPaths = @($ExpectedAdapterFiles | ForEach-Object { ".agents/$_" })
Compare-Set -Area '07-crosswalk' -Check 'adapter-registry' -Expected $expectedAdapterPaths -Actual $registryAdapterFiles -PassDetail 'No orphan adapters are registered; all 7 adapter files map to PRAs.'

if ($prototypeRegistryText -match 'PRA-04-LEGEND-NORMALIZER' -and $prototypeRegistryText -match 'has_dedicated_adapter:\s*false' -and $prototypeRegistryText -match 'adapter_consolidation_note' -and $skillRegistryText -match 'prompt_registry_placeholder:\s*SK-DFD-LEGEND-NORMALIZE' -and $skillRegistryText -match 'prompt_registry_placeholder:\s*SK-SECURITY-STACK-DETECT') {
    Add-Result -Area '07-crosswalk' -Status PASS -Check 'governed-exceptions' -Detail 'PRA-04 adapter consolidation and frozen placeholder names are governed by registry notes.'
}
else {
    Add-Result -Area '07-crosswalk' -Status FAIL -Check 'governed-exceptions' -Detail 'Governed exception evidence missing from prototype-agent registry.'
}

if ($skillRegistryText -match 'prompt_registry_placeholder:\s*SK-DFD-LEGEND-NORMALIZE' -and $skillRegistryText -match 'canonical_package_05_skill:\s*SK-LEGEND-NORMALIZE' -and $skillRegistryText -match 'prompt_registry_placeholder:\s*SK-SECURITY-STACK-DETECT' -and $skillRegistryText -match 'canonical_package_05_skill:\s*SK-SECURITY-STACK-ASSESS') {
    Add-Result -Area '07-crosswalk' -Status PASS -Check 'placeholder-resolution' -Detail 'Frozen placeholder names resolve through the Package 05 governance crosswalk.'
}
else {
    Add-Result -Area '07-crosswalk' -Status FAIL -Check 'placeholder-resolution' -Detail 'Placeholder resolution pairs are missing.'
}

# 8. Templates and expected baselines.
$templateRegistryText = Get-RepoText 'templates/template-registry.yaml'
$templateFilesInRegistry = Get-RegexValues -Text $templateRegistryText -Pattern '^\s*template_file:\s*(?<path>\S+)' -GroupName 'path'
$actualTemplateFiles = @(Get-ChildItem -LiteralPath (Resolve-PackagePath 'templates') -Recurse -Force -File -Filter '*-template.md' | ForEach-Object { Convert-ToRepoPath $_.FullName } | Sort-Object)
Compare-Set -Area '08-template-sample-mirror' -Check 'template-registry-files' -Expected $actualTemplateFiles -Actual $templateFilesInRegistry -PassDetail 'templates/template-registry.yaml resolves every Package 09 template.'

$outputTemplateFiles = @($templateFilesInRegistry | Where-Object { $_ -like 'templates/output/output-*-template.md' })
if ($outputTemplateFiles.Count -eq 27) {
    Add-Result -Area '08-template-sample-mirror' -Status PASS -Check 'output-template-count' -Detail '27 output templates exist, including output-00-run-log-template.md.'
}
else {
    Add-Result -Area '08-template-sample-mirror' -Status FAIL -Check 'output-template-count' -Detail "Expected 27 output templates; found $($outputTemplateFiles.Count)."
}

$expectedBaselineFiles = @()
foreach ($templatePath in $outputTemplateFiles) {
    $templateName = Split-Path -Path $templatePath -Leaf
    if ($templateName -eq 'output-00-run-log-template.md') { continue }
    $expectedName = ($templateName -replace '^output-', 'expected-' -replace '-template\.md$', '.md')
    $expectedBaselineFiles += "samples/sample-001-dfd-crop/expected/$expectedName"
}
$actualBaselineFiles = @(Get-ChildItem -LiteralPath (Resolve-PackagePath 'samples/sample-001-dfd-crop/expected') -Force -File -Filter '*.md' | ForEach-Object { 'samples/sample-001-dfd-crop/expected/' + $_.Name } | Sort-Object)
Compare-Set -Area '08-template-sample-mirror' -Check 'expected-baseline-mirror' -Expected $expectedBaselineFiles -Actual $actualBaselineFiles -PassDetail 'Sample expected baselines mirror the 26 Package 09 output templates excluding run-log support.'
if (-not (Test-RepoFileExists 'samples/sample-001-dfd-crop/expected/expected-00-run-log.md')) {
    Add-Result -Area '08-template-sample-mirror' -Status PASS -Check 'run-log-support-only' -Detail 'output-00-run-log-template.md is not mirrored as a sample expected baseline.'
}
else {
    Add-Result -Area '08-template-sample-mirror' -Status FAIL -Check 'run-log-support-only' -Detail 'Forbidden expected-00-run-log.md exists.'
}

# 9. Sample fixture.
$expectedInputFiles = @('cloud-triage-notes.md', 'dfd-crop.mmd', 'dfd-crop.png', 'dfd-legend-excerpt.md', 'intake-ticket.md', 'review-transcript.md')
$actualInputFiles = @(Get-ChildItem -LiteralPath (Resolve-PackagePath 'samples/sample-001-dfd-crop/inputs') -Force -File | ForEach-Object { $_.Name } | Sort-Object)
Compare-Set -Area '09-sample-fixture' -Check 'sample-inputs' -Expected $expectedInputFiles -Actual $actualInputFiles -PassDetail 'sample-001 inputs count = 6 and the approved input set is present.'

$dfdMmdText = Get-RepoText 'samples/sample-001-dfd-crop/inputs/dfd-crop.mmd'
if ((Test-RepoFileExists 'samples/sample-001-dfd-crop/inputs/dfd-crop.mmd') -and (Test-RepoFileExists 'samples/sample-001-dfd-crop/inputs/dfd-crop.png')) {
    Add-Result -Area '09-sample-fixture' -Status PASS -Check 'dfd-source-and-render' -Detail 'dfd-crop.mmd and dfd-crop.png exist.'
}
else {
    Add-Result -Area '09-sample-fixture' -Status FAIL -Check 'dfd-source-and-render' -Detail 'dfd-crop.mmd or dfd-crop.png missing.'
}

if ($dfdMmdText -match '(?m)^\s*subgraph\s+LEGEND\b') {
    Add-Result -Area '09-sample-fixture' -Status PASS -Check 'embedded-legend' -Detail 'Embedded LEGEND subgraph exists in dfd-crop.mmd.'
}
else {
    Add-Result -Area '09-sample-fixture' -Status FAIL -Check 'embedded-legend' -Detail 'Embedded LEGEND subgraph missing.'
}

$flowLabels = New-Object System.Collections.Generic.List[string]
foreach ($line in ($dfdMmdText -split "`r?`n")) {
    if ($line -match '--\s*"(?<label>[^"]+)"\s*-->') { $flowLabels.Add($Matches['label']) }
}
$badFlowLabels = @($flowLabels | Where-Object { $_ -notmatch '^[^/]+ / C[0-9]+,T[0-9]+,(IA[0-9]+|SA[0-9]+|CA[0-9]+),(AZ[0-9]+|AZ\?)$' })
if ($flowLabels.Count -gt 0 -and $badFlowLabels.Count -eq 0) {
    Add-Result -Area '09-sample-fixture' -Status PASS -Check 'flow-grammar' -Detail "$($flowLabels.Count) visible DFD flows use the 4-token grammar."
}
else {
    Add-Result -Area '09-sample-fixture' -Status FAIL -Check 'flow-grammar' -Detail ('Bad flow label(s): ' + ($badFlowLabels -join ' | '))
}

$leakedExtractionLabels = New-Object System.Collections.Generic.List[string]
foreach ($line in ($dfdMmdText -split "`r?`n")) {
    if ($line -match '^\s*subgraph\s+"?(?<label>BND-[0-9]{2}|CMP-[0-9]{2}|F[0-9]+|BC-[0-9]{2})\b') { $leakedExtractionLabels.Add($Matches['label']) }
    if ($line -match '\["?(?<label>[^"\]]+)"?\]' -and $Matches['label'] -match '^(BND-[0-9]{2}|CMP-[0-9]{2}|F[0-9]+|BC-[0-9]{2})\b') { $leakedExtractionLabels.Add($Matches['label']) }
}
if ($leakedExtractionLabels.Count -eq 0) {
    Add-Result -Area '09-sample-fixture' -Status PASS -Check 'no-extraction-id-leak' -Detail 'No BND-NN/CMP-NN/F#/BC-NN extraction IDs leak into primary visual labels.'
}
else {
    Add-Result -Area '09-sample-fixture' -Status FAIL -Check 'no-extraction-id-leak' -Detail ('Leaked label(s): ' + ($leakedExtractionLabels -join ', '))
}

$jsonBaselines = @(Get-ChildItem -LiteralPath (Resolve-PackagePath 'samples/sample-001-dfd-crop/expected') -Force -File -Filter '*.json')
if ($actualBaselineFiles.Count -eq 26 -and $jsonBaselines.Count -eq 0 -and -not (Test-RepoFileExists 'samples/sample-001-dfd-crop/expected/expected-00-run-log.md')) {
    Add-Result -Area '09-sample-fixture' -Status PASS -Check 'expected-baselines' -Detail 'Expected baselines count = 26; no JSON baselines; no expected-00-run-log.md.'
}
else {
    Add-Result -Area '09-sample-fixture' -Status FAIL -Check 'expected-baselines' -Detail "md=$($actualBaselineFiles.Count) json=$($jsonBaselines.Count) expected-00-run-log=$(Test-RepoFileExists 'samples/sample-001-dfd-crop/expected/expected-00-run-log.md')"
}

# 10. RUN-001 fixture.
$runRequiredFiles = @('runs/RUN-001/README.md', 'runs/RUN-001/run-profile.yaml', 'runs/RUN-001/00-run-log.md')
Assert-FilesExist -Area '10-run-001-fixture' -Check 'run-required-files' -RelativePaths $runRequiredFiles -PassDetail 'RUN-001 exists with README.md, run-profile.yaml, and 00-run-log.md.'
$runInputFiles = @(Get-ChildItem -LiteralPath (Resolve-PackagePath 'runs/RUN-001/inputs') -Force -File | ForEach-Object { $_.Name } | Sort-Object)
Compare-Set -Area '10-run-001-fixture' -Check 'run-inputs' -Expected $expectedInputFiles -Actual $runInputFiles -PassDetail 'runs/RUN-001/inputs has the approved 6 byte-copy fixture files.'
$unauthorizedRunOutputs = @(Get-UnauthorizedRunOutputs)
if ($unauthorizedRunOutputs.Count -eq 0 -and $UnauthorizedBefore.Count -eq 0) {
    Add-Result -Area '10-run-001-fixture' -Status PASS -Check 'no-run-outputs' -Detail 'runs/RUN-001/ contents fall within the BP12B post-execution allow-list (BP11 fixture surface plus the 17 RS chain outputs at root and the 9 DFD chain outputs under dfd/, with .gitkeep permitted as a BP12 reservation marker).'
}
else {
    Add-Result -Area '10-run-001-fixture' -Status FAIL -Check 'no-run-outputs' -Detail ('Unauthorized run output(s): ' + (($UnauthorizedBefore + $unauthorizedRunOutputs | Sort-Object -Unique) -join ', '))
}

# 11. Security/no-drift.
$sensitiveHits = New-Object System.Collections.Generic.List[string]
$urlHits = New-Object System.Collections.Generic.List[string]
$claimHits = New-Object System.Collections.Generic.List[string]
$sensitivePatterns = @(
    [pscustomobject]@{ Name = 'ssn'; Pattern = '\b\d{3}-\d{2}-\d{4}\b' },
    [pscustomobject]@{ Name = 'private-key'; Pattern = '-----BEGIN (?:RSA |DSA |EC |OPENSSH |PGP )?PRIVATE KEY-----' },
    [pscustomobject]@{ Name = 'secret-assignment'; Pattern = '(?i)(api[_-]?key|secret[_-]?key|password|bearer token)\s*[:=]\s*["'']?[A-Za-z0-9_\-]{8,}' },
    [pscustomobject]@{ Name = 'payment-card-label'; Pattern = '(?i)(pan|payment card|credit card)[^\r\n]{0,50}\b(?:\d[ -]*?){13,19}\b' },
    [pscustomobject]@{ Name = 'non-example-email'; Pattern = '(?i)\b[A-Z0-9._%+-]+@(?!example\.|example-|localhost|local\b)[A-Z0-9.-]+\.[A-Z]{2,}\b' }
)
foreach ($fixtureFile in @(Get-TextFixtureFiles)) {
    $relativeFixturePath = Convert-ToRepoPath $fixtureFile.FullName
    Add-InspectedFile $relativeFixturePath
    $fixtureText = Get-Content -LiteralPath $fixtureFile.FullName -Raw
    foreach ($sensitivePattern in $sensitivePatterns) {
        if ($fixtureText -match $sensitivePattern.Pattern) { $sensitiveHits.Add("$relativeFixturePath [$($sensitivePattern.Name)]") }
    }
    foreach ($urlMatch in [regex]::Matches($fixtureText, 'https?://[^\s\)\]"''<>]+', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)) {
        $url = $urlMatch.Value
        if ($url -notmatch '(?i)(example|localhost|127\.0\.0\.1|0\.0\.0\.0|\.local|\.test)') { $urlHits.Add("$relativeFixturePath [$url]") }
    }
    $claimPattern = Test-PositiveExecutionClaim -Text $fixtureText
    if ($null -ne $claimPattern) { $claimHits.Add("$relativeFixturePath [$claimPattern]") }
}
if ($sensitiveHits.Count -eq 0 -and $urlHits.Count -eq 0) {
    Add-Result -Area '11-security-no-drift' -Status PASS -Check 'fixture-sensitive-data' -Detail 'No high-risk PII/PAN/SSN/PHI/secrets/production endpoint patterns found in sample or RUN-001 fixture text files.'
}
else {
    Add-Result -Area '11-security-no-drift' -Status FAIL -Check 'fixture-sensitive-data' -Detail (('Sensitive hits: ' + ($sensitiveHits -join ', ') + '; URL hits: ' + ($urlHits -join ', ')).Trim())
}
if ($claimHits.Count -eq 0) {
    Add-Result -Area '11-security-no-drift' -Status PASS -Check 'fixture-execution-claims' -Detail 'No runtime/cloud/ADK/MCP/Jira/Confluence/Rovo/database/Terraform, external post-back, or AL4 autonomous execution claims found in fixtures.'
}
else {
    Add-Result -Area '11-security-no-drift' -Status FAIL -Check 'fixture-execution-claims' -Detail ('Claim hit(s): ' + ($claimHits -join ', '))
}

$sealedPrefixes = @('prompts/', 'skills/', 'prototype-agents/', 'catalogs/', 'blueprints/', 'templates/', 'config/', 'samples/', 'runs/', '.agents/')
$sealedTrackedDiff = @($trackedDiffFiles | Where-Object {
    $trackedPath = $_
    $isBp12BApprovedExpectedBaselineRefreshPath = $bp12bApprovedExpectedBaselineRefreshDrift -contains $trackedPath
    $isBp12BApprovedPostExecutionRunLogPath = $bp12bApprovedPostExecutionRunLogDrift -contains $trackedPath
    (-not $isBp12BApprovedExpectedBaselineRefreshPath) -and (-not $isBp12BApprovedPostExecutionRunLogPath) -and ($sealedPrefixes | Where-Object { $trackedPath.StartsWith($_, [System.StringComparison]::OrdinalIgnoreCase) })
})
if ($sealedTrackedDiff.Count -eq 0) {
    Add-Result -Area '11-security-no-drift' -Status PASS -Check 'sealed-surface-drift' -Detail 'No unauthorized tracked drift detected under sealed source or fixture surfaces; BP12B approved expected-baseline refresh paths and BP12B approved post-execution run-log appendage are exact-path allowed.'
}
else {
    Add-Result -Area '11-security-no-drift' -Status FAIL -Check 'sealed-surface-drift' -Detail ('Sealed tracked drift: ' + ($sealedTrackedDiff -join ', '))
}

# 12. Agent read-only smoke automation.
foreach ($adapter in $ApprovedAdapters) {
    $adapterText = Get-RepoText $adapter.AdapterPath
    $adapterFailures = New-Object System.Collections.Generic.List[string]
    if ($adapterText -notmatch [regex]::Escape(('name: "' + $adapter.Agent + '"'))) { $adapterFailures.Add('display name not identified') }
    foreach ($praFile in $adapter.PraFiles) {
        if ($adapterText -notmatch [regex]::Escape($praFile)) { $adapterFailures.Add("PRA reference missing: $praFile") }
    }
    if ($adapterText -notmatch 'prompts/(rs|dfd)/') { $adapterFailures.Add('prompt references missing') }
    if ($adapter.SkillRequired -and $adapterText -notmatch 'skills/(rs|dfd)/') { $adapterFailures.Add('skill references missing') }
    if (-not $adapter.SkillRequired -and $adapterText -notmatch 'owns no skill') { $adapterFailures.Add('orchestrator skill exception missing') }
    if ($adapterText -notmatch 'runs/\{\{run_id\}\}/run-profile\.yaml' -and $adapterText -notmatch 'Run-Profile Variables Required') { $adapterFailures.Add('allowed read path evidence missing') }
    if ($adapterText -notmatch '## 8\. Allowed Writes' -or $adapterText -notmatch '\{\{output_root\}\}') { $adapterFailures.Add('allowed write paths missing') }
    if ($adapterText -notmatch '## 11\. Stop Conditions') { $adapterFailures.Add('stop conditions missing') }
    if ($adapterText -notmatch 'Local-only; no runtime, cloud, ADK, MCP, Jira') { $adapterFailures.Add('local-only/no-runtime claim missing') }
    $positiveClaimPattern = Test-PositiveExecutionClaim -Text $adapterText
    if ($null -ne $positiveClaimPattern) { $adapterFailures.Add("positive execution claim pattern found: $positiveClaimPattern") }
    if ($adapterFailures.Count -eq 0) {
        Add-Result -Area '12-agent-smoke' -Status PASS -Check $adapter.Agent -Detail 'Read-only static smoke confirms PRA, prompt, skill/read-path evidence, allowed writes, stop conditions, no writes performed, and no runtime/cloud/post-back/autonomous execution claim.'
    }
    else {
        Add-Result -Area '12-agent-smoke' -Status FAIL -Check $adapter.Agent -Detail ($adapterFailures -join '; ')
    }
}

$UnauthorizedAfter = @(Get-UnauthorizedRunOutputs)
if (($UnauthorizedBefore | Sort-Object -Unique) -join '|' -eq ($UnauthorizedAfter | Sort-Object -Unique) -join '|') {
    Add-Result -Area '12-agent-smoke' -Status PASS -Check 'smoke-read-only' -Detail 'Agent smoke automation used static inspection only and created no RUN-001 outputs.'
}
else {
    Add-Result -Area '12-agent-smoke' -Status FAIL -Check 'smoke-read-only' -Detail 'RUN-001 output shape changed during smoke automation.'
}

Write-Host "Test-AisrafBp12AReadiness  package_root=$PackageRoot" -ForegroundColor Cyan
Write-Host ''
foreach ($result in $Results) {
    $color = if ($result.Status -eq 'PASS') { 'Green' } else { 'Red' }
    Write-Host ("{0,-5}  {1,-26}  {2,-28}  {3}" -f $result.Status, $result.Area, $result.Check, $result.Detail) -ForegroundColor $color
}

$passCount = @($Results | Where-Object { $_.Status -eq 'PASS' }).Count
$failCount = @($Results | Where-Object { $_.Status -eq 'FAIL' }).Count
Write-Host ''
Write-Host 'Commands run:' -ForegroundColor Cyan
foreach ($loggedCommand in $CommandLog) {
    Write-Host ("- {0} (exit {1})" -f $loggedCommand.Command, $loggedCommand.ExitCode)
}
Write-Host ("Files inspected: {0}" -f $InspectedFiles.Keys.Count) -ForegroundColor Cyan

if ($failCount -eq 0) {
    Write-Host ''
    Write-Host "Test-AisrafBp12AReadiness: $passCount PASS, 0 FAIL" -ForegroundColor Green
    Write-Host 'STATUS: BP12A_AUTOMATED_TEST_HARNESS_PASS' -ForegroundColor Green
    exit 0
}

Write-Host ''
Write-Host "Test-AisrafBp12AReadiness: $passCount PASS, $failCount FAIL" -ForegroundColor Red
Write-Host 'STATUS: PARTIAL_WITH_ISSUES' -ForegroundColor Red
exit 1