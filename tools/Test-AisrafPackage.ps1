<#
.SYNOPSIS
    Smoke-test the Build Package 01-13 surface of AISRAF SAS Prototype v0.1.2 (with corrective patch 10A on the sample side and 11A on the run side; BP12-SAMPLE-DFD-BLOCKER fully resolved; BP13 first public visual pack active).

.DESCRIPTION
    Test-AisrafPackage is the active package validator. It confirms:

      - required root files exist;
      - required root folders and folder READMEs exist;
      - Build Package 02 config files exist;
      - Build Package 02 validation file exists;
            - Build Package 03 tool files and the governed BP12A readiness harness exist;
      - Build Package 03 validation file exists;
      - Build Package 04 prompt registry, family READMEs, and prompt cards exist
        and match the approved naming pattern under prompts/rs/ and prompts/dfd/;
      - Build Package 04 validation files exist;
      - Build Package 05 skill registry, family READMEs, and skill contracts exist
        and match the approved naming pattern under skills/rs/ (17 files) and
        skills/dfd/ (9 files);
      - Build Package 05 validation files exist;
      - Build Package 06 prototype-agents/ surface matches the approved layout
        (README.md, prototype-agent-registry.yaml, prototype-agent-template.md,
        and 8 PRA-0[1-8]-*.md files) and .agents/ contains exactly the 7
        approved aisraf-*.agent.md files plus README.md;
      - Build Package 06 validation files exist;
      - Build Package 07 catalogs/ surface matches the approved layout
        (README.md, catalog-registry.yaml, 7 family folders each with README.md
        and only the listed YAML files; 24 controlled-vocabulary YAML catalogs
        in total);
      - Build Package 07 validation files exist;
      - Build Package 08 blueprints/ surface matches the approved layout
        (README.md, blueprint-registry.yaml, blueprint-template.yaml, two
        category folders each with README.md and only the listed YAML files;
        9 controlled YAML blueprints in total);
      - Build Package 08 validation files exist;
      - Build Package 09 templates/ surface matches the approved layout
        (README.md, template-registry.yaml, four family folders each with
        README.md and only the listed Markdown templates; 31 controlled
        Markdown templates in total: 27 output + 1 jira + 1 confluence + 2
        run);
      - Build Package 09 validation files exist;
      - Build Package 10 samples/ surface matches the approved layout
        (README.md, sample-registry.yaml, sample-001-dfd-crop/README.md
        with inputs/ holding exactly 6 files and expected/ holding exactly
        26 Markdown baselines: 17 RS + 9 DFD; no expected-00-run-log.md;
        no JSON baselines; no sample-002 through sample-008 folders);
      - Build Package 10 validation files exist;
      - Build Package 11 runs/ surface matches the approved layout
        (README.md, runs/RUN-001/ with README.md, run-profile.yaml,
        00-run-log.md, inputs/ holding exactly 6 byte-copied files,
        and an empty dfd/ folder; the 17 RS chain outputs at the
        run-folder root and the 9 DFD outputs under dfd/ are permitted
        when the operator executes the chain but are NOT required by
        Build Package 11);
      - Build Package 11 validation files exist;
      - Build Package 12 validation framework files exist (10 new
        BP12 checklists added to validation/ allow-list; runs/RUN-001/dfd/
        permits .gitkeep as a fresh-clone reservation marker);
            - Build Package 12C operator-experience files exist (.copilot-skills/
                carries 7 thin skill wrappers plus 7 operator cards and README.md;
                .github/skills/ carries 7 provider Agent Skills packages with
                SKILL.md files; .github/hooks/ carries the provider hook JSON;
                tools/hooks/ carries 4 conservative hook scripts, README.md, and
                hook-allow-list.yaml; validation/ carries the 3 BP12C implementation
                checklists plus the manual operator test guide plus the 5 WP-12C-I
                solution-package alignment artifacts: solution-package-architecture,
                agent-spec-template, capability-agent-traceability-register,
                platform-projection-matrix, and plugin-roadmap);
            - no forbidden later-package artifacts exist (DOCX/PDF/PPTX/ZIP,
                release content beyond folder README placeholder; diagrams/ is open
                only through the exact WP-13 first-public-visual-pack allow-list);
      - the old reference workspace path is acknowledged as read-only.

    The test does not run prompts, skills, PRAs, .agent.md adapters, Jira,
    Confluence, Rovo, MCP, scoring, diagram generation, or release export.

    runs/RUN-001/ is the first canonical governed run fixture and is
    validated by Check 08i-runs-content-limits. Other runs/RUN-* folders
    generate WARN rows only; the Package 03 validation checklist requires
    any smoke run folder to be removed before human git stage.

    Exit code 0 when there is no FAIL row (WARN rows are allowed). Exit code 1
    on any FAIL.
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$packageRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$results = New-Object System.Collections.Generic.List[psobject]

function Add-Result {
    param(
        [Parameter(Mandatory = $true)][ValidateSet('PASS', 'WARN', 'FAIL')][string]$Status,
        [Parameter(Mandatory = $true)][string]$Check,
        [Parameter(Mandatory = $true)][string]$Detail
    )
    $results.Add([pscustomobject]@{ Status = $Status; Check = $Check; Detail = $Detail })
}

function Resolve-PackagePath {
    param([Parameter(Mandatory = $true)][string]$Relative)
    return (Join-Path $packageRoot $Relative)
}

function Convert-ToPackageRelativePath {
    param([Parameter(Mandatory = $true)][string]$AbsolutePath)
    return $AbsolutePath.Substring($packageRoot.Length + 1).Replace('\', '/')
}

function Normalize-RepoRelativePath {
    param([Parameter(Mandatory = $true)][string]$PathValue)
    $normalized = $PathValue.Trim().Trim('"').Trim("'").Replace('\', '/')
    while ($normalized.StartsWith('./', [System.StringComparison]::Ordinal)) {
        $normalized = $normalized.Substring(2)
    }
    return $normalized.TrimEnd('/')
}

function Test-PackageFile {
    param(
        [Parameter(Mandatory = $true)][string]$Relative,
        [Parameter(Mandatory = $true)][string]$Check
    )
    $p = Resolve-PackagePath $Relative
    if (Test-Path -LiteralPath $p -PathType Leaf) {
        Add-Result -Status PASS -Check $Check -Detail "$Relative present."
    }
    else {
        Add-Result -Status FAIL -Check $Check -Detail "$Relative missing."
    }
}

function Test-PackageDir {
    param(
        [Parameter(Mandatory = $true)][string]$Relative,
        [Parameter(Mandatory = $true)][string]$Check
    )
    $p = Resolve-PackagePath $Relative
    if (Test-Path -LiteralPath $p -PathType Container) {
        Add-Result -Status PASS -Check $Check -Detail "$Relative present."
    }
    else {
        Add-Result -Status FAIL -Check $Check -Detail "$Relative missing."
    }
}

function Test-PathUnderAnyPrefix {
    param(
        [Parameter(Mandatory = $true)][string]$RelativePath,
        [Parameter(Mandatory = $true)][string[]]$AllowedPrefixes
    )
    foreach ($allowedPrefix in $AllowedPrefixes) {
        if ($RelativePath.StartsWith($allowedPrefix, [System.StringComparison]::OrdinalIgnoreCase)) {
            return $true
        }
    }
    return $false
}

function Test-ApprovedBundleSourcePath {
    param([Parameter(Mandatory = $true)][string]$RelativePath)
    $allowedBundleSourcePrefixes = @(
        '.github/agents/',
        '.github/skills/',
        '.github/hooks/',
        '.copilot-skills/',
        '.agents/',
        'prompts/',
        'skills/',
        'prototype-agents/',
        'templates/',
        'catalogs/',
        'blueprints/',
        'tools/hooks/'
    )
    $allowedBundleSourceFiles = @(
        'tools/Test-AisrafPackage.ps1',
        'tools/Test-AisrafBp12AReadiness.ps1',
        'tools/Test-AisrafRunProfile.ps1',
        'tools/Invoke-AisrafAm3LocalRun.ps1',
        'tools/Test-AisrafAm3Runtime.ps1'
    )
    return (($allowedBundleSourceFiles -contains $RelativePath) -or (Test-PathUnderAnyPrefix -RelativePath $RelativePath -AllowedPrefixes $allowedBundleSourcePrefixes))
}

function Get-PluginCanonicalBodyDuplicationHits {
    param([Parameter(Mandatory = $true)][string]$PluginRootRelativePath)

    $pluginRootAbsolutePath = Resolve-PackagePath $PluginRootRelativePath
    $hits = New-Object System.Collections.Generic.List[string]
    if (-not (Test-Path -LiteralPath $pluginRootAbsolutePath -PathType Container)) {
        return @($hits)
    }

    $comparableExtensions = @('.md', '.yaml', '.yml', '.json', '.ps1')
    $pluginMetadataFiles = @(Get-ChildItem -LiteralPath $pluginRootAbsolutePath -Force -File -ErrorAction SilentlyContinue |
        Where-Object { $comparableExtensions -contains $_.Extension.ToLowerInvariant() })

    $canonicalSourceRoots = @(
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
    $canonicalFiles = New-Object System.Collections.Generic.List[System.IO.FileInfo]
    foreach ($canonicalSourceRoot in $canonicalSourceRoots) {
        $canonicalSourceRootAbsolutePath = Resolve-PackagePath $canonicalSourceRoot
        if (-not (Test-Path -LiteralPath $canonicalSourceRootAbsolutePath -PathType Container)) { continue }
        foreach ($canonicalFile in @(Get-ChildItem -LiteralPath $canonicalSourceRootAbsolutePath -Recurse -Force -File -ErrorAction SilentlyContinue |
            Where-Object { $comparableExtensions -contains $_.Extension.ToLowerInvariant() })) {
            $canonicalFiles.Add($canonicalFile)
        }
    }

    foreach ($pluginMetadataFile in $pluginMetadataFiles) {
        $pluginText = (Get-Content -LiteralPath $pluginMetadataFile.FullName -Raw).Replace("`r`n", "`n")
        if ($pluginText.Length -lt 200) { continue }

        $pluginChunks = [System.Collections.Generic.HashSet[string]]::new()
        for ($pluginChunkStart = 0; $pluginChunkStart -le ($pluginText.Length - 200); $pluginChunkStart++) {
            $pluginChunk = $pluginText.Substring($pluginChunkStart, 200)
            if (($pluginChunk -replace '\s', '').Length -ge 120) {
                [void]$pluginChunks.Add($pluginChunk)
            }
        }

        foreach ($canonicalFile in $canonicalFiles) {
            $canonicalText = (Get-Content -LiteralPath $canonicalFile.FullName -Raw).Replace("`r`n", "`n")
            if ($canonicalText.Length -lt 200) { continue }

            $copiedBodyFound = $false
            for ($canonicalChunkStart = 0; $canonicalChunkStart -le ($canonicalText.Length - 200); $canonicalChunkStart++) {
                $canonicalChunk = $canonicalText.Substring($canonicalChunkStart, 200)
                if (($canonicalChunk -replace '\s', '').Length -lt 120) { continue }
                if ($pluginChunks.Contains($canonicalChunk)) {
                    $pluginRelativePath = Convert-ToPackageRelativePath $pluginMetadataFile.FullName
                    $canonicalRelativePath = Convert-ToPackageRelativePath $canonicalFile.FullName
                    $hits.Add("$pluginRelativePath contains a 200+ character canonical body block copied from $canonicalRelativePath")
                    $copiedBodyFound = $true
                    break
                }
            }
            if ($copiedBodyFound) { break }
        }
    }

    return @($hits)
}

function Read-BundleChecksumManifestEntries {
    param([Parameter(Mandatory = $true)][string]$ManifestAbsolutePath)

    $entries = New-Object System.Collections.Generic.List[hashtable]
    $currentEntry = @{}
    foreach ($manifestLine in @(Get-Content -LiteralPath $ManifestAbsolutePath)) {
        if ($manifestLine -match '^\s*-\s*(?<key>source_path|target_path|source_sha256|target_sha256)\s*:\s*(?<value>.*?)\s*$') {
            if ($currentEntry.Count -gt 0) {
                $entries.Add($currentEntry)
                $currentEntry = @{}
            }
            $currentEntry[$Matches['key']] = Normalize-RepoRelativePath $Matches['value']
            continue
        }
        if ($manifestLine -match '^\s*(?<key>source_path|target_path|source_sha256|target_sha256)\s*:\s*(?<value>.*?)\s*$') {
            $currentEntry[$Matches['key']] = Normalize-RepoRelativePath $Matches['value']
        }
    }
    if ($currentEntry.Count -gt 0) {
        $entries.Add($currentEntry)
    }
    return @($entries)
}

function Test-ObjectHasExactProperty {
    param(
        [Parameter(Mandatory = $true)][psobject]$InputObject,
        [Parameter(Mandatory = $true)][string]$PropertyName
    )
    return @($InputObject.PSObject.Properties | Where-Object { $_.Name -ceq $PropertyName }).Count -eq 1
}

function Get-ExactPropertyValue {
    param(
        [Parameter(Mandatory = $true)][psobject]$InputObject,
        [Parameter(Mandatory = $true)][string]$PropertyName
    )
    $propertyMatches = @($InputObject.PSObject.Properties | Where-Object { $_.Name -ceq $PropertyName })
    if ($propertyMatches.Count -ne 1) { return $null }
    return $propertyMatches[0].Value
}

# 1. Required root files
$rootFiles = @('README.md', 'START-HERE.md', 'PACKAGE-MANIFEST.yaml', 'PROTOTYPE-CHARTER.md', 'FOLDER-CONTRACTS.md', 'BUILD-ORDER.md')
foreach ($f in $rootFiles) {
    Test-PackageFile -Relative $f -Check '01-root-files'
}

# 2. Required root folders
$rootFolders = @('.github', '.agents', '.copilot-skills', 'config', 'tools', 'prompts', 'skills', 'prototype-agents', 'catalogs', 'blueprints', 'templates', 'samples', 'runs', 'diagrams', 'docs', 'validation', 'release', 'authoring-agents')
foreach ($d in $rootFolders) {
    Test-PackageDir -Relative $d -Check '02-root-folders'
}

# 3. Folder READMEs / .github copilot-instructions
Test-PackageFile -Relative '.github/copilot-instructions.md' -Check '03-folder-readmes'
$readmeFolders = @('.agents', '.copilot-skills', 'config', 'tools', 'prompts', 'skills', 'prototype-agents', 'catalogs', 'blueprints', 'templates', 'samples', 'runs', 'diagrams', 'docs', 'validation', 'release', 'authoring-agents')
foreach ($d in $readmeFolders) {
    Test-PackageFile -Relative ("$d/README.md") -Check '03-folder-readmes'
}

# 4. Build Package 02 config files
$pkg02ConfigFiles = @(
    'config/run-profile.schema.yaml',
    'config/run-profile.template.yaml',
    'config/run-profile.sample.folder-first.yaml',
    'config/run-profile.sample.integration.yaml',
    'config/run-profile.field-catalog.md',
    'config/run-profile.validation-rules.md',
    'config/path-resolution-rules.md',
    'config/integration-fields.md',
    'config/sensitive-data-rules.md'
)
foreach ($f in $pkg02ConfigFiles) {
    Test-PackageFile -Relative $f -Check '04-package-02-config'
}
Test-PackageFile -Relative 'validation/package-02-config-checklist.md' -Check '04-package-02-config'

# 5. Build Package 03 tools and checklist
$pkg03Tools = @(
    'tools/New-AisrafRun.ps1',
    'tools/Test-AisrafRunProfile.ps1',
    'tools/Test-AisrafPackage.ps1',
    'tools/Test-AisrafBp12AReadiness.ps1',
    'tools/README.md'
)
foreach ($f in $pkg03Tools) {
    Test-PackageFile -Relative $f -Check '05-package-03-tools'
}
Test-PackageFile -Relative 'validation/package-03-tools-checklist.md' -Check '05-package-03-tools'

# 6. Forbidden release-binary artifacts anywhere
$binaryGlobs = @('*.docx', '*.pdf', '*.pptx', '*.zip')
$binaryHits = @()
foreach ($g in $binaryGlobs) {
    $found = Get-ChildItem -LiteralPath $packageRoot -Recurse -Force -File -Filter $g -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notlike "*\.git\*" }
    foreach ($f in $found) { $binaryHits += $f.FullName.Substring($packageRoot.Length + 1) }
}
if ($binaryHits.Count -gt 0) {
    foreach ($h in $binaryHits) { Add-Result -Status FAIL -Check '06-no-release-binaries' -Detail "Forbidden binary artifact: $h" }
}
else {
    Add-Result -Status PASS -Check '06-no-release-binaries' -Detail "No DOCX/PDF/PPTX/ZIP artifacts found."
}

# 7. Build Package 06 .agent.md adapter surface.
# Allowed under .agents/: README.md plus exactly 7 approved aisraf-*.agent.md adapter files.
# Allowed under .github/agents/: BP06A Copilot discovery projection files for the same
# 7 approved adapters, byte-identical to their canonical .agents/ counterparts.
# Allowed under plugins/aisraf-copilot-plugin/bundle/: K3C bundle projection
# copies only, validated by Check 16 / 16b under the exact approved bundle prefix.
# FAIL: any other *.agent.md anywhere in the workspace; any file under .agents/ that
# is not in the approved adapter list or README.md; any approved adapter file missing;
# any .github/agents projection file that is not approved or does not match .agents/.
$approvedAdapters = @(
    'aisraf-orchestrator.agent.md',
    'aisraf-input-reader.agent.md',
    'aisraf-dfd-extractor.agent.md',
    'aisraf-review-table-builder.agent.md',
    'aisraf-blueprint-questioner.agent.md',
    'aisraf-finding-recommender.agent.md',
    'aisraf-handoff-qa-scorer.agent.md'
)
$approvedBundleProjectionPrefix = 'plugins/aisraf-copilot-plugin/bundle/'
$agentMd = @(Get-ChildItem -LiteralPath $packageRoot -Recurse -Force -File -Filter '*.agent.md' -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notlike "*\.git\*" })
$agentsAbs = Resolve-PackagePath '.agents'
$agentsAbsNormalized = $agentsAbs.TrimEnd('\','/')
$githubAgentsAbs = Resolve-PackagePath '.github/agents'
$githubAgentsAbsNormalized = $githubAgentsAbs.TrimEnd('\','/')
foreach ($a in $agentMd) {
    $relativeAgentPath = Convert-ToPackageRelativePath $a.FullName
    if ($relativeAgentPath.StartsWith($approvedBundleProjectionPrefix, [System.StringComparison]::Ordinal)) {
        continue
    }

    $parent = Split-Path -Parent $a.FullName
    $parentNormalized = $parent.TrimEnd('\','/')
    if ($parentNormalized -ieq $agentsAbsNormalized) {
        if (-not ($approvedAdapters -contains $a.Name)) {
            Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Forbidden adapter in .agents/ (not in the 7 approved Build Package 06 adapters): .agents/$($a.Name)"
        }
    }
    elseif ($parentNormalized -ieq $githubAgentsAbsNormalized) {
        if (-not ($approvedAdapters -contains $a.Name)) {
            Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Forbidden Copilot projection in .github/agents/ (not one of the 7 approved Build Package 06 adapters): .github/agents/$($a.Name)"
            continue
        }
        $canonical = Join-Path $agentsAbs $a.Name
        if (-not (Test-Path -LiteralPath $canonical -PathType Leaf)) {
            Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Copilot projection has no canonical .agents/ source: .github/agents/$($a.Name)"
            continue
        }
        $canonicalHash = (Get-FileHash -LiteralPath $canonical -Algorithm SHA256).Hash
        $projectionHash = (Get-FileHash -LiteralPath $a.FullName -Algorithm SHA256).Hash
        if ($canonicalHash -ne $projectionHash) {
            Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Copilot projection differs from canonical adapter: .github/agents/$($a.Name)"
        }
    }
    else {
        Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Forbidden *.agent.md outside .agents/, .github/agents/ projection, or exact approved bundle target: $relativeAgentPath"
    }
}
foreach ($name in $approvedAdapters) {
    $expected = Join-Path $agentsAbs $name
    if (-not (Test-Path -LiteralPath $expected -PathType Leaf)) {
        Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Required Build Package 06 adapter missing: .agents/$name"
    }
}
if (Test-Path -LiteralPath $agentsAbs -PathType Container) {
    foreach ($child in @(Get-ChildItem -LiteralPath $agentsAbs -Force)) {
        if ($child.PSIsContainer) {
            Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Forbidden subfolder in .agents/ (Build Package 06 disallows nested folders): .agents/$($child.Name)/"
            continue
        }
        if ($child.Name -eq 'README.md') { continue }
        if (-not ($approvedAdapters -contains $child.Name)) {
            Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Forbidden file in .agents/ (only README.md and the 7 approved aisraf-*.agent.md adapters are allowed): .agents/$($child.Name)"
        }
    }
}
if (Test-Path -LiteralPath $githubAgentsAbs -PathType Container) {
    foreach ($child in @(Get-ChildItem -LiteralPath $githubAgentsAbs -Force)) {
        if ($child.PSIsContainer) {
            Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Forbidden subfolder in .github/agents/ (BP06A projection disallows nested folders): .github/agents/$($child.Name)/"
            continue
        }
        if (-not ($approvedAdapters -contains $child.Name)) {
            Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Forbidden file in .github/agents/ (only the 7 approved aisraf-*.agent.md projection files are allowed): .github/agents/$($child.Name)"
        }
    }
}
$adapterFails = @($results | Where-Object { $_.Check -eq '07-package-06-adapters' -and $_.Status -eq 'FAIL' }).Count
if ($adapterFails -eq 0) {
    Add-Result -Status PASS -Check '07-package-06-adapters' -Detail ".agents/ contains exactly the 7 approved Build Package 06 adapters plus README.md; .github/agents/ projections, when present, are approved and byte-identical; bundle copies under plugins/aisraf-copilot-plugin/bundle/ are delegated to Check 16 / 16b."
}

# 8. Folder content limits — only README.md allowed before owning Build Package
# prompts/ is owned by Build Package 04 (active); see Check 08b for the prompts/ allowed surface.
# skills/ is owned by Build Package 05 (active); see Check 08c for the skills/ allowed surface.
# prototype-agents/ is owned by Build Package 06 (active); see Check 08d for the prototype-agents/ allowed surface.
# .agents/ is owned by Build Package 06 (active); see Check 07 for the adapter surface.
# catalogs/ is owned by Build Package 07 (active); see Check 08e for the catalogs/ allowed surface.
# blueprints/ is owned by Build Package 08 (active); see Check 08f for the blueprints/ allowed surface.
# templates/ is owned by Build Package 09 (active); see Check 08g for the templates/ allowed surface.
# diagrams/ is opened by Build Package 13 only for the exact first public
# visual pack paths listed below; no broad diagram-folder allowance is introduced.
# docs/ is partially opened by Build Package 12C-REL0-B, WP-13 links, and
# WP-12C-REL0-GITHUB-PRERELEASE-STAKEHOLDER-ASSET-PACK for the 6 approved release
# docs files; remaining docs surface stays reserved for later packages.
$readmeOnlyFolders = @{
    'release'          = 'Build Package 15'
}
foreach ($folder in $readmeOnlyFolders.Keys) {
    $abs = Resolve-PackagePath $folder
    if (-not (Test-Path -LiteralPath $abs -PathType Container)) { continue }
    $children = @(Get-ChildItem -LiteralPath $abs -Force)
    foreach ($c in $children) {
        if ($c.Name -ne 'README.md') {
            $rel = "$folder/$($c.Name)"
            Add-Result -Status FAIL -Check '08-folder-content-limits' -Detail "Forbidden content in $folder/ (owned by $($readmeOnlyFolders[$folder])): $rel"
        }
    }
}
$diagramsAbs = Resolve-PackagePath 'diagrams'
$wp13DiagramAllowedDirs = @(
    'diagrams/release-v0.1.2',
    'diagrams/release-v0.1.2/png',
    'diagrams/release-v0.1.2/source',
    'diagrams/release-v0.1.2/svg',
    'diagrams/release-v0.1.2/thumbnails'
)
$wp13DiagramAllowedFiles = @(
    'diagrams/README.md',
    'diagrams/diagram-registry.yaml',
    'diagrams/release-v0.1.2/README.md',
    'diagrams/release-v0.1.2/png/M1-CTX-Mode-1-Local-Review-Context.png',
    'diagrams/release-v0.1.2/png/M1-DFD-Mode-1-Input-to-Output-DFD.png',
    'diagrams/release-v0.1.2/png/M1-SEQ-Mode-1-Operator-Run-Sequence.png',
    'diagrams/release-v0.1.2/png/M2-FLOW-Mode-2-Runtime-Evidence-Flow.png',
    'diagrams/release-v0.1.2/png/M3-FLOW-Mode-3-Commit-Gate-Flow.png',
    'diagrams/release-v0.1.2/png/M4-BND-Mode-4-Future-Boundary-and-Non-Claim.png',
    'diagrams/release-v0.1.2/png/V-00-AISRAF-Customer-Story-Flow.png',
    'diagrams/release-v0.1.2/png/V-02-AISRAF-Package-Map-Read-Order.png',
    'diagrams/release-v0.1.2/png/V-03-Stakeholder-Reading-Path.png',
    'diagrams/release-v0.1.2/png/V-04-Evidence-Pack-vs-Capability-Roadmap-vs-Drift-Baseline.png',
    'diagrams/release-v0.1.2/png/V-10-DFD-Annotation-Legend-Card.png',
    'diagrams/release-v0.1.2/png/V-11-Annotated-DFD-Example.png',
    'diagrams/release-v0.1.2/png/V-23-Release-Package-Structure.png',
    'diagrams/release-v0.1.2/png/V-24-Validation-Ladder.png',
    'diagrams/release-v0.1.2/png/V-25-Publication-and-License-Boundary.png',
    'diagrams/release-v0.1.2/source/README.md',
    'diagrams/release-v0.1.2/svg/README.md',
    'diagrams/release-v0.1.2/thumbnails/M1-CTX-Mode-1-Local-Review-Context.png',
    'diagrams/release-v0.1.2/thumbnails/M1-DFD-Mode-1-Input-to-Output-DFD.png',
    'diagrams/release-v0.1.2/thumbnails/M1-SEQ-Mode-1-Operator-Run-Sequence.png',
    'diagrams/release-v0.1.2/thumbnails/M2-FLOW-Mode-2-Runtime-Evidence-Flow.png',
    'diagrams/release-v0.1.2/thumbnails/M3-FLOW-Mode-3-Commit-Gate-Flow.png',
    'diagrams/release-v0.1.2/thumbnails/M4-BND-Mode-4-Future-Boundary-and-Non-Claim.png',
    'diagrams/release-v0.1.2/thumbnails/V-00-AISRAF-Customer-Story-Flow.png',
    'diagrams/release-v0.1.2/thumbnails/V-02-AISRAF-Package-Map-Read-Order.png',
    'diagrams/release-v0.1.2/thumbnails/V-03-Stakeholder-Reading-Path.png',
    'diagrams/release-v0.1.2/thumbnails/V-04-Evidence-Pack-vs-Capability-Roadmap-vs-Drift-Baseline.png',
    'diagrams/release-v0.1.2/thumbnails/V-10-DFD-Annotation-Legend-Card.png',
    'diagrams/release-v0.1.2/thumbnails/V-11-Annotated-DFD-Example.png',
    'diagrams/release-v0.1.2/thumbnails/V-23-Release-Package-Structure.png',
    'diagrams/release-v0.1.2/thumbnails/V-24-Validation-Ladder.png',
    'diagrams/release-v0.1.2/thumbnails/V-25-Publication-and-License-Boundary.png'
)
if (Test-Path -LiteralPath $diagramsAbs -PathType Container) {
    foreach ($diagramDir in @(Get-ChildItem -LiteralPath $diagramsAbs -Recurse -Force -Directory -ErrorAction SilentlyContinue)) {
        $diagramDirRelativePath = Convert-ToPackageRelativePath $diagramDir.FullName
        if (-not ($wp13DiagramAllowedDirs -contains $diagramDirRelativePath)) {
            Add-Result -Status FAIL -Check '08-folder-content-limits' -Detail "Forbidden diagram folder outside exact WP-13 allow-list: $diagramDirRelativePath/"
        }
    }
    foreach ($diagramFile in @(Get-ChildItem -LiteralPath $diagramsAbs -Recurse -Force -File -ErrorAction SilentlyContinue)) {
        $diagramFileRelativePath = Convert-ToPackageRelativePath $diagramFile.FullName
        if (-not ($wp13DiagramAllowedFiles -contains $diagramFileRelativePath)) {
            Add-Result -Status FAIL -Check '08-folder-content-limits' -Detail "Forbidden diagram file outside exact WP-13 allow-list: $diagramFileRelativePath"
        }
    }
    foreach ($diagramAllowedDir in $wp13DiagramAllowedDirs) {
        if (-not (Test-Path -LiteralPath (Resolve-PackagePath $diagramAllowedDir) -PathType Container)) {
            Add-Result -Status FAIL -Check '08-folder-content-limits' -Detail "Required WP-13 diagram folder missing: $diagramAllowedDir/"
        }
    }
    foreach ($diagramAllowedFile in $wp13DiagramAllowedFiles) {
        if (-not (Test-Path -LiteralPath (Resolve-PackagePath $diagramAllowedFile) -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08-folder-content-limits' -Detail "Required WP-13 diagram file missing: $diagramAllowedFile"
        }
    }
}
$docsAbs = Resolve-PackagePath 'docs'
$docsAllowedFiles = @(
    'README.md',
    'AISRAF-PRIMER.md',
    'PROMPTS-SKILLS-AGENTS-TESTING-GUIDE.md',
    'OPERATOR-QUICKSTART.md',
    'SECURITY-REVIEW-WORKFLOW.md',
    'ARCHITECTURE-OVERVIEW.md',
    'ROADMAP.md',
    'PRODUCT-FLOW-ROADMAP.md',
    'CONNECTED-REVIEW-FLOW-PLAN.md',
    'THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md',
    'PLUGIN-INSTALL-UX-PLAN.md',
    'BRANCH-RELEASE-STRATEGY.md',
    'COMMANDS.md'
)
if (Test-Path -LiteralPath $docsAbs -PathType Container) {
    foreach ($c in @(Get-ChildItem -LiteralPath $docsAbs -Force)) {
        if ($c.PSIsContainer) {
            Add-Result -Status FAIL -Check '08-folder-content-limits' -Detail "Forbidden subfolder in docs/ (BP12C-REL0-B and WP-12C-REL0-GITHUB-PRERELEASE-STAKEHOLDER-ASSET-PACK disallow nested folders; remaining docs surface is reserved for Build Package 14): docs/$($c.Name)/"
            continue
        }
        if (-not ($docsAllowedFiles -contains $c.Name)) {
            Add-Result -Status FAIL -Check '08-folder-content-limits' -Detail "Forbidden content in docs/ (BP12C-REL0-B, WP-12C-REL0-GITHUB-PRERELEASE-STAKEHOLDER-ASSET-PACK, WP-12C-REL0-PRODUCT-FLOW-ADAPTER-ROADMAP-REBASE, and WP-12C-REL0-CROSS-SHELL-COMMAND-UX fix the docs/ inventory at README.md plus the 12 approved release docs files; remaining docs surface is reserved for Build Package 14): docs/$($c.Name)"
        }
    }
}
$folderLimitFails = @($results | Where-Object { $_.Check -eq '08-folder-content-limits' -and $_.Status -eq 'FAIL' }).Count
if ($folderLimitFails -eq 0) {
    Add-Result -Status PASS -Check '08-folder-content-limits' -Detail "Read-me-only folders contain only README.md; diagrams/ contains only exact WP-13 first-public-visual-pack paths; docs/ contains README.md plus the 12 approved release docs files (BP12C-REL0-B 5 release docs, the WP-12C-REL0-GITHUB-PRERELEASE-STAKEHOLDER-ASSET-PACK guide, the WP-12C-REL0-PRODUCT-FLOW-ADAPTER-ROADMAP-REBASE 5 planning docs, and the WP-12C-REL0-CROSS-SHELL-COMMAND-UX cross-shell command reference)."
}

# 8a. Build Package 12C Copilot skill-wrapper content limits.
$copilotSkillsAbs = Resolve-PackagePath '.copilot-skills'
$copilotSkillWrapperFiles = @(
    'aisraf-orchestration.skill.md',
    'aisraf-input-read.skill.md',
    'aisraf-dfd-extraction.skill.md',
    'aisraf-review-table-build.skill.md',
    'aisraf-blueprint-questioning.skill.md',
    'aisraf-finding-recommendation.skill.md',
    'aisraf-handoff-qa-score.skill.md'
)
$copilotSkillOperatorCards = @(
    'aisraf-orchestration.operator-card.md',
    'aisraf-input-read.operator-card.md',
    'aisraf-dfd-extraction.operator-card.md',
    'aisraf-review-table-build.operator-card.md',
    'aisraf-blueprint-questioning.operator-card.md',
    'aisraf-finding-recommendation.operator-card.md',
    'aisraf-handoff-qa-score.operator-card.md'
)
$copilotSkillAllowed = @('README.md') + $copilotSkillWrapperFiles + $copilotSkillOperatorCards
if (Test-Path -LiteralPath $copilotSkillsAbs -PathType Container) {
    foreach ($child in @(Get-ChildItem -LiteralPath $copilotSkillsAbs -Force)) {
        if ($child.PSIsContainer) {
            Add-Result -Status FAIL -Check '08a-copilot-skills-content-limits' -Detail "Forbidden subfolder in .copilot-skills/ (BP12C allows only flat wrapper and operator-card files): .copilot-skills/$($child.Name)/"
            continue
        }
        if (-not ($copilotSkillAllowed -contains $child.Name)) {
            Add-Result -Status FAIL -Check '08a-copilot-skills-content-limits' -Detail "Forbidden file in .copilot-skills/ (BP12C fixes the wrapper/card inventory): .copilot-skills/$($child.Name)"
        }
    }
    foreach ($name in $copilotSkillAllowed) {
        if (-not (Test-Path -LiteralPath (Join-Path $copilotSkillsAbs $name) -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08a-copilot-skills-content-limits' -Detail "Required BP12C skill-wrapper surface file missing: .copilot-skills/$name"
        }
    }
    foreach ($name in $copilotSkillWrapperFiles) {
        $wrapperText = Get-Content -LiteralPath (Join-Path $copilotSkillsAbs $name) -Raw
        $expectedName = $name -replace '\.skill\.md$', ''
        if ($wrapperText -notmatch [regex]::Escape("name: $expectedName")) {
            Add-Result -Status FAIL -Check '08a-copilot-skills-content-limits' -Detail "Skill wrapper frontmatter name mismatch: .copilot-skills/$name"
        }
        if ($wrapperText -notmatch '\.agents/aisraf-.*\.agent\.md' -or $wrapperText -notmatch 'prototype-agents/PRA-' -or $wrapperText -notmatch 'runs/\{\{run_id\}\}/') {
            Add-Result -Status FAIL -Check '08a-copilot-skills-content-limits' -Detail "Skill wrapper is missing canonical adapter/PRA/run path references: .copilot-skills/$name"
        }
    }
}
else {
    Add-Result -Status FAIL -Check '08a-copilot-skills-content-limits' -Detail ".copilot-skills/ folder is missing."
}
$copilotSkillFails = @($results | Where-Object { $_.Check -eq '08a-copilot-skills-content-limits' -and $_.Status -eq 'FAIL' }).Count
if ($copilotSkillFails -eq 0) {
    Add-Result -Status PASS -Check '08a-copilot-skills-content-limits' -Detail ".copilot-skills/ contains README.md, 7 thin AISRAF skill wrappers, and 7 operator cards with canonical references."
}

# 8a-1. Build Package 12C-H provider Agent Skills content limits.
# VS Code/Copilot Agent Skills are folder packages at .github/skills/<name>/SKILL.md.
# Directory name must match the SKILL.md frontmatter name. These files are thin
# provider projections; canonical authority remains in registries, PRAs, prompts,
# skills, templates, validation, run profiles, and tools/Test-*.ps1.
$providerSkillNames = @(
    'aisraf-orchestration',
    'aisraf-input-read',
    'aisraf-dfd-extraction',
    'aisraf-review-table-build',
    'aisraf-blueprint-questioning',
    'aisraf-finding-recommendation',
    'aisraf-handoff-qa-score'
)
$githubSkillsAbs = Resolve-PackagePath '.github/skills'
if (Test-Path -LiteralPath $githubSkillsAbs -PathType Container) {
    foreach ($entry in @(Get-ChildItem -LiteralPath $githubSkillsAbs -Force)) {
        if (-not $entry.PSIsContainer) {
            Add-Result -Status FAIL -Check '08a1-provider-skills-content-limits' -Detail "Forbidden file at .github/skills/ root (only skill package folders are allowed): .github/skills/$($entry.Name)"
            continue
        }
        if (-not ($providerSkillNames -contains $entry.Name)) {
            Add-Result -Status FAIL -Check '08a1-provider-skills-content-limits' -Detail "Forbidden provider skill folder: .github/skills/$($entry.Name)/"
            continue
        }
        foreach ($child in @(Get-ChildItem -LiteralPath $entry.FullName -Force)) {
            if ($child.PSIsContainer -or $child.Name -ne 'SKILL.md') {
                Add-Result -Status FAIL -Check '08a1-provider-skills-content-limits' -Detail "Forbidden content in provider skill package (only SKILL.md allowed): .github/skills/$($entry.Name)/$($child.Name)"
            }
        }
    }

    foreach ($skillName in $providerSkillNames) {
        $skillPath = Join-Path $githubSkillsAbs "$skillName/SKILL.md"
        if (-not (Test-Path -LiteralPath $skillPath -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08a1-provider-skills-content-limits' -Detail "Required provider Agent Skill missing: .github/skills/$skillName/SKILL.md"
            continue
        }
        $skillText = Get-Content -LiteralPath $skillPath -Raw
        if ($skillText -notmatch [regex]::Escape("name: $skillName")) {
            Add-Result -Status FAIL -Check '08a1-provider-skills-content-limits' -Detail "Provider skill frontmatter name mismatch: .github/skills/$skillName/SKILL.md"
        }
        if ($skillText -notmatch [regex]::Escape(".copilot-skills/$skillName.skill.md") -or $skillText -notmatch '\.agents/aisraf-.*\.agent\.md' -or $skillText -notmatch 'prototype-agents/PRA-' -or $skillText -notmatch 'runs/\{\{run_id\}\}/') {
            Add-Result -Status FAIL -Check '08a1-provider-skills-content-limits' -Detail "Provider skill is missing local wrapper, canonical adapter/PRA, or run path references: .github/skills/$skillName/SKILL.md"
        }
    }
}
else {
    Add-Result -Status FAIL -Check '08a1-provider-skills-content-limits' -Detail ".github/skills/ folder is missing."
}
$providerSkillFails = @($results | Where-Object { $_.Check -eq '08a1-provider-skills-content-limits' -and $_.Status -eq 'FAIL' }).Count
if ($providerSkillFails -eq 0) {
    Add-Result -Status PASS -Check '08a1-provider-skills-content-limits' -Detail ".github/skills/ contains 7 folder-based Agent Skills packages with SKILL.md files and canonical references."
}

# 8a-2. Build Package 12C-H provider hook config content limits.
$githubHooksAbs = Resolve-PackagePath '.github/hooks'
$githubHookAllowed = @('aisraf-guardrails.json')
if (Test-Path -LiteralPath $githubHooksAbs -PathType Container) {
    foreach ($entry in @(Get-ChildItem -LiteralPath $githubHooksAbs -Force)) {
        if ($entry.PSIsContainer) {
            Add-Result -Status FAIL -Check '08a2-provider-hooks-content-limits' -Detail "Forbidden subfolder in .github/hooks/: .github/hooks/$($entry.Name)/"
            continue
        }
        if (-not ($githubHookAllowed -contains $entry.Name)) {
            Add-Result -Status FAIL -Check '08a2-provider-hooks-content-limits' -Detail "Forbidden provider hook file: .github/hooks/$($entry.Name)"
        }
    }
    foreach ($hookName in $githubHookAllowed) {
        $hookPath = Join-Path $githubHooksAbs $hookName
        if (-not (Test-Path -LiteralPath $hookPath -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08a2-provider-hooks-content-limits' -Detail "Required provider hook config missing: .github/hooks/$hookName"
            continue
        }
        $hookJsonText = Get-Content -LiteralPath $hookPath -Raw
        try {
            $null = $hookJsonText | ConvertFrom-Json -ErrorAction Stop
        }
        catch {
            Add-Result -Status FAIL -Check '08a2-provider-hooks-content-limits' -Detail "Provider hook config is not valid JSON: .github/hooks/$hookName"
        }
        foreach ($requiredToken in @('"hooks"', '"PreToolUse"', '"PostToolUse"', '"Stop"', 'tools/hooks/aisraf-allowed-path-prewrite-guard.ps1', 'tools/hooks/aisraf-focused-validator-postwrite.ps1', 'tools/hooks/aisraf-session-stop-summary.ps1')) {
            if ($hookJsonText -notmatch [regex]::Escape($requiredToken)) {
                Add-Result -Status FAIL -Check '08a2-provider-hooks-content-limits' -Detail "Provider hook config missing token '$requiredToken': .github/hooks/$hookName"
            }
        }
    }
}
else {
    Add-Result -Status FAIL -Check '08a2-provider-hooks-content-limits' -Detail ".github/hooks/ folder is missing."
}
$providerHookFails = @($results | Where-Object { $_.Check -eq '08a2-provider-hooks-content-limits' -and $_.Status -eq 'FAIL' }).Count
if ($providerHookFails -eq 0) {
    Add-Result -Status PASS -Check '08a2-provider-hooks-content-limits' -Detail ".github/hooks/ contains the AISRAF provider hook config with documented lifecycle events and reusable tools/hooks/ script references."
}

# 8b. Build Package 04 prompts content limits.
# Allowed under prompts/: README.md, prompt-registry.yaml, rs/, dfd/.
# Allowed under prompts/rs/: README.md plus *.prompt.md matching ^[0-9]{2}-[a-z0-9-]+\.prompt\.md$.
# Allowed under prompts/dfd/: same naming rule.
# FAIL anything else: unexpected subfolders, unexpected file extensions,
# .agent.md files, generated outputs, run artifacts, diagrams, binaries.
$promptsAbs = Resolve-PackagePath 'prompts'
$promptsTopAllowedFiles = @('README.md', 'prompt-registry.yaml')
$promptsTopAllowedDirs  = @('rs', 'dfd')
$promptCardPattern      = '^[0-9]{2}-[a-z0-9-]+\.prompt\.md$'
if (Test-Path -LiteralPath $promptsAbs -PathType Container) {
    foreach ($entry in @(Get-ChildItem -LiteralPath $promptsAbs -Force)) {
        if ($entry.PSIsContainer) {
            if (-not ($promptsTopAllowedDirs -contains $entry.Name)) {
                Add-Result -Status FAIL -Check '08b-prompts-content-limits' -Detail "Forbidden subfolder in prompts/ (Build Package 04 allows only rs/ and dfd/): prompts/$($entry.Name)/"
            }
        }
        else {
            if (-not ($promptsTopAllowedFiles -contains $entry.Name)) {
                Add-Result -Status FAIL -Check '08b-prompts-content-limits' -Detail "Forbidden file at prompts/ root (Build Package 04 allows only README.md and prompt-registry.yaml here): prompts/$($entry.Name)"
            }
        }
    }
    foreach ($family in $promptsTopAllowedDirs) {
        $familyAbs = Join-Path $promptsAbs $family
        if (-not (Test-Path -LiteralPath $familyAbs -PathType Container)) { continue }
        foreach ($child in @(Get-ChildItem -LiteralPath $familyAbs -Force)) {
            if ($child.PSIsContainer) {
                Add-Result -Status FAIL -Check '08b-prompts-content-limits' -Detail "Forbidden subfolder in prompts/$family/ (Build Package 04 disallows nested folders): prompts/$family/$($child.Name)/"
                continue
            }
            if ($child.Name -eq 'README.md') { continue }
            if ($child.Name -notmatch $promptCardPattern) {
                Add-Result -Status FAIL -Check '08b-prompts-content-limits' -Detail "Forbidden file in prompts/$family/ (only README.md and *.prompt.md cards matching '$promptCardPattern' allowed): prompts/$family/$($child.Name)"
            }
        }
    }
    $promptFails = @($results | Where-Object { $_.Check -eq '08b-prompts-content-limits' -and $_.Status -eq 'FAIL' }).Count
    if ($promptFails -eq 0) {
        Add-Result -Status PASS -Check '08b-prompts-content-limits' -Detail "prompts/ surface matches Build Package 04 contract (README.md, prompt-registry.yaml, rs/, dfd/, with *.prompt.md cards under each family)."
    }
}
else {
    Add-Result -Status FAIL -Check '08b-prompts-content-limits' -Detail "prompts/ folder is missing."
}

# 8c. Build Package 05 skills content limits.
# Allowed under skills/: README.md, skill-registry.yaml, rs/, dfd/.
# Allowed under skills/rs/: README.md plus 17 RS skill contracts matching ^SK-[A-Z0-9-]+\.md$ (excluding any SK-DFD-* prefix).
# Allowed under skills/dfd/: README.md plus 9 DFD subskill contracts matching ^SK-DFD-0[1-9]-[A-Z0-9-]+\.md$.
# FAIL anything else: unexpected subfolders, unexpected file extensions, .agent.md files, generated outputs.
$skillsAbs = Resolve-PackagePath 'skills'
$skillsTopAllowedFiles = @('README.md', 'skill-registry.yaml')
$skillsTopAllowedDirs  = @('rs', 'dfd')
$rsSkillPattern  = '^SK-[A-Z0-9-]+\.md$'
$dfdSkillPattern = '^SK-DFD-0[1-9]-[A-Z0-9-]+\.md$'
if (Test-Path -LiteralPath $skillsAbs -PathType Container) {
    foreach ($entry in @(Get-ChildItem -LiteralPath $skillsAbs -Force)) {
        if ($entry.PSIsContainer) {
            if (-not ($skillsTopAllowedDirs -contains $entry.Name)) {
                Add-Result -Status FAIL -Check '08c-skills-content-limits' -Detail "Forbidden subfolder in skills/ (Build Package 05 allows only rs/ and dfd/): skills/$($entry.Name)/"
            }
        }
        else {
            if (-not ($skillsTopAllowedFiles -contains $entry.Name)) {
                Add-Result -Status FAIL -Check '08c-skills-content-limits' -Detail "Forbidden file at skills/ root (Build Package 05 allows only README.md and skill-registry.yaml here): skills/$($entry.Name)"
            }
        }
    }
    # skills/rs/ — README.md + 17 SK-*.md (excluding SK-DFD-* which belongs in skills/dfd/)
    $rsAbs = Join-Path $skillsAbs 'rs'
    if (Test-Path -LiteralPath $rsAbs -PathType Container) {
        foreach ($child in @(Get-ChildItem -LiteralPath $rsAbs -Force)) {
            if ($child.PSIsContainer) {
                Add-Result -Status FAIL -Check '08c-skills-content-limits' -Detail "Forbidden subfolder in skills/rs/ (Build Package 05 disallows nested folders): skills/rs/$($child.Name)/"
                continue
            }
            if ($child.Name -eq 'README.md') { continue }
            if ($child.Name -match '^SK-DFD-0[1-9]-') {
                Add-Result -Status FAIL -Check '08c-skills-content-limits' -Detail "Numbered DFD subskill belongs under skills/dfd/, not skills/rs/: skills/rs/$($child.Name)"
                continue
            }
            if ($child.Name -notmatch $rsSkillPattern) {
                Add-Result -Status FAIL -Check '08c-skills-content-limits' -Detail "Forbidden file in skills/rs/ (only README.md and SK-*.md matching '$rsSkillPattern' allowed): skills/rs/$($child.Name)"
            }
        }
    }
    # skills/dfd/ — README.md + 9 SK-DFD-0[1-9]-*.md
    $dfdAbs = Join-Path $skillsAbs 'dfd'
    if (Test-Path -LiteralPath $dfdAbs -PathType Container) {
        foreach ($child in @(Get-ChildItem -LiteralPath $dfdAbs -Force)) {
            if ($child.PSIsContainer) {
                Add-Result -Status FAIL -Check '08c-skills-content-limits' -Detail "Forbidden subfolder in skills/dfd/ (Build Package 05 disallows nested folders): skills/dfd/$($child.Name)/"
                continue
            }
            if ($child.Name -eq 'README.md') { continue }
            if ($child.Name -notmatch $dfdSkillPattern) {
                Add-Result -Status FAIL -Check '08c-skills-content-limits' -Detail "Forbidden file in skills/dfd/ (only README.md and SK-DFD-0[1-9]-*.md matching '$dfdSkillPattern' allowed): skills/dfd/$($child.Name)"
            }
        }
    }
    $skillFails = @($results | Where-Object { $_.Check -eq '08c-skills-content-limits' -and $_.Status -eq 'FAIL' }).Count
    if ($skillFails -eq 0) {
        Add-Result -Status PASS -Check '08c-skills-content-limits' -Detail "skills/ surface matches Build Package 05 contract (README.md, skill-registry.yaml, rs/, dfd/, with 17 SK-*.md under rs/ and 9 SK-DFD-0[1-9]-*.md under dfd/)."
    }
}
else {
    Add-Result -Status FAIL -Check '08c-skills-content-limits' -Detail "skills/ folder is missing."
}

# 8d. Build Package 06 prototype-agents content limits.
# Allowed under prototype-agents/: README.md, prototype-agent-registry.yaml,
# prototype-agent-template.md, and exactly 8 PRA-0[1-8]-*.md files matching
# ^PRA-0[1-8]-[A-Z0-9-]+\.md$.
# FAIL: unexpected subfolders, unexpected file extensions, missing required PRAs,
# extra PRA files outside the 8 approved IDs.
$praAbs = Resolve-PackagePath 'prototype-agents'
$praTopAllowedFiles = @('README.md', 'prototype-agent-registry.yaml', 'prototype-agent-template.md')
$approvedPraFiles = @(
    'PRA-01-SAS-REVIEW-ORCHESTRATOR.md',
    'PRA-02-INPUT-READER.md',
    'PRA-03-DFD-EXTRACTOR.md',
    'PRA-04-LEGEND-NORMALIZER.md',
    'PRA-05-REVIEW-TABLE-BUILDER.md',
    'PRA-06-BLUEPRINT-QUESTIONER.md',
    'PRA-07-FINDING-RECOMMENDER.md',
    'PRA-08-HANDOFF-QA-SCORER.md'
)
$praPattern = '^PRA-0[1-8]-[A-Z0-9-]+\.md$'
if (Test-Path -LiteralPath $praAbs -PathType Container) {
    foreach ($entry in @(Get-ChildItem -LiteralPath $praAbs -Force)) {
        if ($entry.PSIsContainer) {
            Add-Result -Status FAIL -Check '08d-prototype-agents-content-limits' -Detail "Forbidden subfolder in prototype-agents/ (Build Package 06 disallows nested folders): prototype-agents/$($entry.Name)/"
            continue
        }
        if ($praTopAllowedFiles -contains $entry.Name) { continue }
        if ($entry.Name -notmatch $praPattern) {
            Add-Result -Status FAIL -Check '08d-prototype-agents-content-limits' -Detail "Forbidden file in prototype-agents/ (only README.md, prototype-agent-registry.yaml, prototype-agent-template.md, and PRA-0[1-8]-*.md files allowed): prototype-agents/$($entry.Name)"
            continue
        }
        if (-not ($approvedPraFiles -contains $entry.Name)) {
            Add-Result -Status FAIL -Check '08d-prototype-agents-content-limits' -Detail "Forbidden PRA file in prototype-agents/ (Build Package 06 fixes the PRA inventory at 8 named files): prototype-agents/$($entry.Name)"
        }
    }
    foreach ($name in $approvedPraFiles) {
        $expected = Join-Path $praAbs $name
        if (-not (Test-Path -LiteralPath $expected -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08d-prototype-agents-content-limits' -Detail "Required Build Package 06 PRA spec missing: prototype-agents/$name"
        }
    }
    foreach ($name in $praTopAllowedFiles) {
        $expected = Join-Path $praAbs $name
        if (-not (Test-Path -LiteralPath $expected -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08d-prototype-agents-content-limits' -Detail "Required Build Package 06 file missing: prototype-agents/$name"
        }
    }
    $praFails = @($results | Where-Object { $_.Check -eq '08d-prototype-agents-content-limits' -and $_.Status -eq 'FAIL' }).Count
    if ($praFails -eq 0) {
        Add-Result -Status PASS -Check '08d-prototype-agents-content-limits' -Detail "prototype-agents/ surface matches Build Package 06 contract (README.md, prototype-agent-registry.yaml, prototype-agent-template.md, and 8 PRA-0[1-8]-*.md files)."
    }
}
else {
    Add-Result -Status FAIL -Check '08d-prototype-agents-content-limits' -Detail "prototype-agents/ folder is missing."
}

# 8e. Build Package 07 catalogs content limits.
# Allowed under catalogs/: README.md, catalog-registry.yaml, and exactly 7 family folders.
# Each family folder must contain README.md plus exactly the approved YAML catalog files.
# FAIL: unexpected files at catalogs/ root, unexpected family folders, missing required YAML
# catalogs, extra YAML catalogs, nested folders, or non-YAML/non-README files inside families.
$catalogsAbs = Resolve-PackagePath 'catalogs'
$catalogsTopAllowedFiles = @('README.md', 'catalog-registry.yaml')
$catalogFamilyAllowedFiles = @{
    'components'      = @(
        'README.md',
        'component-type-catalog.yaml',
        'component-role-catalog.yaml',
        'component-evidence-rule-catalog.yaml'
    )
    'interactions'    = @(
        'README.md',
        'interaction-type-catalog.yaml',
        'flow-direction-catalog.yaml',
        'flow-evidence-rule-catalog.yaml'
    )
    'boundaries'      = @(
        'README.md',
        'boundary-type-catalog.yaml',
        'boundary-crossing-rule-catalog.yaml',
        'trust-zone-catalog.yaml'
    )
    'identity-access' = @(
        'README.md',
        'authentication-catalog.yaml',
        'authorization-catalog.yaml',
        'identity-evidence-rule-catalog.yaml'
    )
    'data-protection' = @(
        'README.md',
        'data-class-catalog.yaml',
        'transport-protection-catalog.yaml',
        'at-rest-protection-catalog.yaml',
        'confidence-level-catalog.yaml'
    )
    'security-stacks' = @(
        'README.md',
        'security-stack-marker-catalog.yaml',
        'control-signal-catalog.yaml',
        'proof-vs-signal-rule-catalog.yaml'
    )
    'review'          = @(
        'README.md',
        'finding-category-catalog.yaml',
        'severity-catalog.yaml',
        'recommendation-type-catalog.yaml',
        'ai-action-level-catalog.yaml',
        'review-status-catalog.yaml'
    )
}
if (Test-Path -LiteralPath $catalogsAbs -PathType Container) {
    foreach ($entry in @(Get-ChildItem -LiteralPath $catalogsAbs -Force)) {
        if ($entry.PSIsContainer) {
            if (-not ($catalogFamilyAllowedFiles.ContainsKey($entry.Name))) {
                Add-Result -Status FAIL -Check '08e-catalogs-content-limits' -Detail "Forbidden subfolder in catalogs/ (Build Package 07 allows only the 7 approved family folders): catalogs/$($entry.Name)/"
            }
        }
        else {
            if (-not ($catalogsTopAllowedFiles -contains $entry.Name)) {
                Add-Result -Status FAIL -Check '08e-catalogs-content-limits' -Detail "Forbidden file at catalogs/ root (Build Package 07 allows only README.md and catalog-registry.yaml here): catalogs/$($entry.Name)"
            }
        }
    }
    foreach ($family in $catalogFamilyAllowedFiles.Keys) {
        $familyAbs = Join-Path $catalogsAbs $family
        if (-not (Test-Path -LiteralPath $familyAbs -PathType Container)) {
            Add-Result -Status FAIL -Check '08e-catalogs-content-limits' -Detail "Required Build Package 07 catalog family folder missing: catalogs/$family/"
            continue
        }
        $approvedNames = $catalogFamilyAllowedFiles[$family]
        $observedNames = @()
        foreach ($child in @(Get-ChildItem -LiteralPath $familyAbs -Force)) {
            if ($child.PSIsContainer) {
                Add-Result -Status FAIL -Check '08e-catalogs-content-limits' -Detail "Forbidden subfolder in catalogs/$family/ (Build Package 07 disallows nested folders): catalogs/$family/$($child.Name)/"
                continue
            }
            $observedNames += $child.Name
            if (-not ($approvedNames -contains $child.Name)) {
                Add-Result -Status FAIL -Check '08e-catalogs-content-limits' -Detail "Forbidden file in catalogs/$family/ (Build Package 07 fixes the catalog inventory at the approved YAML file list): catalogs/$family/$($child.Name)"
            }
        }
        foreach ($name in $approvedNames) {
            if (-not ($observedNames -contains $name)) {
                Add-Result -Status FAIL -Check '08e-catalogs-content-limits' -Detail "Required Build Package 07 catalog file missing: catalogs/$family/$name"
            }
        }
    }
    foreach ($name in $catalogsTopAllowedFiles) {
        $expected = Join-Path $catalogsAbs $name
        if (-not (Test-Path -LiteralPath $expected -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08e-catalogs-content-limits' -Detail "Required Build Package 07 catalog file missing: catalogs/$name"
        }
    }
    $catalogFails = @($results | Where-Object { $_.Check -eq '08e-catalogs-content-limits' -and $_.Status -eq 'FAIL' }).Count
    if ($catalogFails -eq 0) {
        Add-Result -Status PASS -Check '08e-catalogs-content-limits' -Detail "catalogs/ surface matches Build Package 07 contract (README.md, catalog-registry.yaml, 7 family folders each with README.md and the approved YAML catalog files; 24 controlled-vocabulary catalogs total)."
    }
}
else {
    Add-Result -Status FAIL -Check '08e-catalogs-content-limits' -Detail "catalogs/ folder is missing."
}

# 8f. Build Package 08 blueprints content limits.
# Allowed under blueprints/: README.md, blueprint-registry.yaml,
# blueprint-template.yaml, and exactly 2 category folders.
# Each category folder must contain README.md plus exactly the approved
# BP-*.yaml blueprint files.
# FAIL: unexpected files at blueprints/ root, unexpected category folders,
# missing required BP-*.yaml files, extra BP-*.yaml files, nested folders,
# or non-YAML/non-README files inside categories.
$blueprintsAbs = Resolve-PackagePath 'blueprints'
$blueprintsTopAllowedFiles = @('README.md', 'blueprint-registry.yaml', 'blueprint-template.yaml')
$blueprintCategoryAllowedFiles = @{
    'platform-independent' = @(
        'README.md',
        'BP-NON-AI-DATAFLOW-BASELINE.yaml',
        'BP-RAG-RETRIEVAL.yaml',
        'BP-MODEL-ENDPOINT-CALL.yaml',
        'BP-TOOL-USING-AGENT.yaml',
        'BP-API-WRITEBACK.yaml',
        'BP-HITL-APPROVAL.yaml',
        'BP-AGENT-TO-AGENT.yaml',
        'BP-AI-WORKFLOW.yaml'
    )
    'cloud-patterns'       = @(
        'README.md',
        'BP-AI-SAAS-INTEGRATION.yaml'
    )
}
if (Test-Path -LiteralPath $blueprintsAbs -PathType Container) {
    foreach ($entry in @(Get-ChildItem -LiteralPath $blueprintsAbs -Force)) {
        if ($entry.PSIsContainer) {
            if (-not ($blueprintCategoryAllowedFiles.ContainsKey($entry.Name))) {
                Add-Result -Status FAIL -Check '08f-blueprints-content-limits' -Detail "Forbidden subfolder in blueprints/ (Build Package 08 allows only the 2 approved category folders): blueprints/$($entry.Name)/"
            }
        }
        else {
            if (-not ($blueprintsTopAllowedFiles -contains $entry.Name)) {
                Add-Result -Status FAIL -Check '08f-blueprints-content-limits' -Detail "Forbidden file at blueprints/ root (Build Package 08 allows only README.md, blueprint-registry.yaml, and blueprint-template.yaml here): blueprints/$($entry.Name)"
            }
        }
    }
    foreach ($category in $blueprintCategoryAllowedFiles.Keys) {
        $categoryAbs = Join-Path $blueprintsAbs $category
        if (-not (Test-Path -LiteralPath $categoryAbs -PathType Container)) {
            Add-Result -Status FAIL -Check '08f-blueprints-content-limits' -Detail "Required Build Package 08 blueprint category folder missing: blueprints/$category/"
            continue
        }
        $approvedNames = $blueprintCategoryAllowedFiles[$category]
        $observedNames = @()
        foreach ($child in @(Get-ChildItem -LiteralPath $categoryAbs -Force)) {
            if ($child.PSIsContainer) {
                Add-Result -Status FAIL -Check '08f-blueprints-content-limits' -Detail "Forbidden subfolder in blueprints/$category/ (Build Package 08 disallows nested folders): blueprints/$category/$($child.Name)/"
                continue
            }
            $observedNames += $child.Name
            if (-not ($approvedNames -contains $child.Name)) {
                Add-Result -Status FAIL -Check '08f-blueprints-content-limits' -Detail "Forbidden file in blueprints/$category/ (Build Package 08 fixes the blueprint inventory at the approved YAML file list): blueprints/$category/$($child.Name)"
            }
        }
        foreach ($name in $approvedNames) {
            if (-not ($observedNames -contains $name)) {
                Add-Result -Status FAIL -Check '08f-blueprints-content-limits' -Detail "Required Build Package 08 blueprint file missing: blueprints/$category/$name"
            }
        }
    }
    foreach ($name in $blueprintsTopAllowedFiles) {
        $expected = Join-Path $blueprintsAbs $name
        if (-not (Test-Path -LiteralPath $expected -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08f-blueprints-content-limits' -Detail "Required Build Package 08 blueprint file missing: blueprints/$name"
        }
    }
    $blueprintFails = @($results | Where-Object { $_.Check -eq '08f-blueprints-content-limits' -and $_.Status -eq 'FAIL' }).Count
    if ($blueprintFails -eq 0) {
        Add-Result -Status PASS -Check '08f-blueprints-content-limits' -Detail "blueprints/ surface matches Build Package 08 contract (README.md, blueprint-registry.yaml, blueprint-template.yaml, 2 category folders each with README.md and the approved BP-*.yaml files; 9 controlled blueprints total)."
    }
}
else {
    Add-Result -Status FAIL -Check '08f-blueprints-content-limits' -Detail "blueprints/ folder is missing."
}

# 8g. Build Package 09 templates content limits.
# Allowed under templates/: README.md, template-registry.yaml, and exactly 4 family folders.
# Each family folder must contain README.md plus exactly the approved Markdown template files.
# FAIL: unexpected files at templates/ root, unexpected family folders, missing required
# template files, extra template files, nested folders, or non-Markdown files inside families.
$templatesAbs = Resolve-PackagePath 'templates'
$templatesTopAllowedFiles = @('README.md', 'template-registry.yaml')
$templateFamilyAllowedFiles = @{
    'output'     = @(
        'README.md',
        'output-00-run-log-template.md',
        'output-01-input-inventory-template.md',
        'output-02-visible-dfd-objects-template.md',
        'output-03-legend-normalization-template.md',
        'output-04-components-template.md',
        'output-05-flows-template.md',
        'output-06-boundaries-template.md',
        'output-07-security-stack-assessment-template.md',
        'output-08-internal-review-table-template.md',
        'output-09-missing-facts-template.md',
        'output-10-ai-action-level-template.md',
        'output-11-blueprint-match-template.md',
        'output-12-targeted-questions-template.md',
        'output-13-findings-template.md',
        'output-14-recommendations-template.md',
        'output-15-handoff-pack-template.md',
        'output-16-validation-notes-template.md',
        'output-17-accuracy-score-template.md',
        'output-dfd-01-intake-quality-check-template.md',
        'output-dfd-02-boundary-catalog-template.md',
        'output-dfd-03-component-catalog-template.md',
        'output-dfd-04-flow-inventory-template.md',
        'output-dfd-05-annotation-resolution-template.md',
        'output-dfd-06-boundary-crossings-template.md',
        'output-dfd-07-control-signals-template.md',
        'output-dfd-08-confidence-score-template.md',
        'output-dfd-09-extraction-summary-template.md'
    )
    'jira'       = @(
        'README.md',
        'jira-ticket-draft-template.md'
    )
    'confluence' = @(
        'README.md',
        'confluence-page-draft-template.md'
    )
    'run'        = @(
        'README.md',
        'run-log-entry-row-template.md',
        'postback-log-entry-row-template.md'
    )
}
if (Test-Path -LiteralPath $templatesAbs -PathType Container) {
    foreach ($entry in @(Get-ChildItem -LiteralPath $templatesAbs -Force)) {
        if ($entry.PSIsContainer) {
            if (-not ($templateFamilyAllowedFiles.ContainsKey($entry.Name))) {
                Add-Result -Status FAIL -Check '08g-templates-content-limits' -Detail "Forbidden subfolder in templates/ (Build Package 09 allows only the 4 approved family folders): templates/$($entry.Name)/"
            }
        }
        else {
            if (-not ($templatesTopAllowedFiles -contains $entry.Name)) {
                Add-Result -Status FAIL -Check '08g-templates-content-limits' -Detail "Forbidden file at templates/ root (Build Package 09 allows only README.md and template-registry.yaml here): templates/$($entry.Name)"
            }
        }
    }
    foreach ($family in $templateFamilyAllowedFiles.Keys) {
        $familyAbs = Join-Path $templatesAbs $family
        if (-not (Test-Path -LiteralPath $familyAbs -PathType Container)) {
            Add-Result -Status FAIL -Check '08g-templates-content-limits' -Detail "Required Build Package 09 template family folder missing: templates/$family/"
            continue
        }
        $approvedNames = $templateFamilyAllowedFiles[$family]
        $observedNames = @()
        foreach ($child in @(Get-ChildItem -LiteralPath $familyAbs -Force)) {
            if ($child.PSIsContainer) {
                Add-Result -Status FAIL -Check '08g-templates-content-limits' -Detail "Forbidden subfolder in templates/$family/ (Build Package 09 disallows nested folders): templates/$family/$($child.Name)/"
                continue
            }
            $observedNames += $child.Name
            if (-not ($approvedNames -contains $child.Name)) {
                Add-Result -Status FAIL -Check '08g-templates-content-limits' -Detail "Forbidden file in templates/$family/ (Build Package 09 fixes the template inventory at the approved Markdown file list): templates/$family/$($child.Name)"
            }
        }
        foreach ($name in $approvedNames) {
            if (-not ($observedNames -contains $name)) {
                Add-Result -Status FAIL -Check '08g-templates-content-limits' -Detail "Required Build Package 09 template file missing: templates/$family/$name"
            }
        }
    }
    foreach ($name in $templatesTopAllowedFiles) {
        $expected = Join-Path $templatesAbs $name
        if (-not (Test-Path -LiteralPath $expected -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08g-templates-content-limits' -Detail "Required Build Package 09 template file missing: templates/$name"
        }
    }
    $templateFails = @($results | Where-Object { $_.Check -eq '08g-templates-content-limits' -and $_.Status -eq 'FAIL' }).Count
    if ($templateFails -eq 0) {
        Add-Result -Status PASS -Check '08g-templates-content-limits' -Detail "templates/ surface matches Build Package 09 contract (README.md, template-registry.yaml, 4 family folders each with README.md and the approved Markdown template files; 31 controlled templates total: 27 output + 1 jira + 1 confluence + 2 run)."
    }
}
else {
    Add-Result -Status FAIL -Check '08g-templates-content-limits' -Detail "templates/ folder is missing."
}

# 9. samples/ — Build Package 10 surface (Check 08h-samples-content-limits)
$samplesAbs = Resolve-PackagePath 'samples'
$samplesTopAllowedFiles = @('README.md', 'sample-registry.yaml')
$samplesTopAllowedDirs = @('sample-001-dfd-crop')
$sample001InputsAllowed = @('dfd-crop.png', 'dfd-crop.mmd', 'dfd-legend-excerpt.md', 'cloud-triage-notes.md', 'review-transcript.md', 'intake-ticket.md')
$sample001ExpectedAllowed = @(
    'expected-01-input-inventory.md',
    'expected-02-visible-dfd-objects.md',
    'expected-03-legend-normalization.md',
    'expected-04-components.md',
    'expected-05-flows.md',
    'expected-06-boundaries.md',
    'expected-07-security-stack-assessment.md',
    'expected-08-internal-review-table.md',
    'expected-09-missing-facts.md',
    'expected-10-ai-action-level.md',
    'expected-11-blueprint-match.md',
    'expected-12-targeted-questions.md',
    'expected-13-findings.md',
    'expected-14-recommendations.md',
    'expected-15-handoff-pack.md',
    'expected-16-validation-notes.md',
    'expected-17-accuracy-score.md',
    'expected-dfd-01-intake-quality-check.md',
    'expected-dfd-02-boundary-catalog.md',
    'expected-dfd-03-component-catalog.md',
    'expected-dfd-04-flow-inventory.md',
    'expected-dfd-05-annotation-resolution.md',
    'expected-dfd-06-boundary-crossings.md',
    'expected-dfd-07-control-signals.md',
    'expected-dfd-08-confidence-score.md',
    'expected-dfd-09-extraction-summary.md'
)
if (Test-Path -LiteralPath $samplesAbs -PathType Container) {
    # Top-level files
    foreach ($c in @(Get-ChildItem -LiteralPath $samplesAbs -Force -File)) {
        if (-not ($samplesTopAllowedFiles -contains $c.Name)) {
            Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Forbidden file in samples/: samples/$($c.Name). Build Package 10 fixes the top-level inventory at README.md and sample-registry.yaml."
        }
    }
    foreach ($name in $samplesTopAllowedFiles) {
        if (-not (Test-Path -LiteralPath (Join-Path $samplesAbs $name) -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Required Build Package 10 sample file missing: samples/$name"
        }
    }
    # Top-level subfolders
    foreach ($d in @(Get-ChildItem -LiteralPath $samplesAbs -Force -Directory)) {
        if (-not ($samplesTopAllowedDirs -contains $d.Name)) {
            Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Forbidden subfolder in samples/: samples/$($d.Name). Build Package 10 builds only sample-001-dfd-crop; samples 002-008 are registry-only entries (founder decision Q8)."
        }
    }
    # sample-001 README and inputs/expected
    $sample001Abs = Join-Path $samplesAbs 'sample-001-dfd-crop'
    if (Test-Path -LiteralPath $sample001Abs -PathType Container) {
        # README required
        if (-not (Test-Path -LiteralPath (Join-Path $sample001Abs 'README.md') -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Required Build Package 10 sample file missing: samples/sample-001-dfd-crop/README.md"
        }
        # Forbid extra files at sample-001 root
        foreach ($c in @(Get-ChildItem -LiteralPath $sample001Abs -Force -File)) {
            if ($c.Name -ne 'README.md') {
                Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Forbidden file in samples/sample-001-dfd-crop/: samples/sample-001-dfd-crop/$($c.Name)"
            }
        }
        # Allowed subfolders inside sample-001
        $sample001AllowedDirs = @('inputs', 'expected')
        foreach ($d in @(Get-ChildItem -LiteralPath $sample001Abs -Force -Directory)) {
            if (-not ($sample001AllowedDirs -contains $d.Name)) {
                Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Forbidden subfolder in samples/sample-001-dfd-crop/: $($d.Name)"
            }
        }
        # inputs/
        $inputsAbs = Join-Path $sample001Abs 'inputs'
        if (Test-Path -LiteralPath $inputsAbs -PathType Container) {
            foreach ($c in @(Get-ChildItem -LiteralPath $inputsAbs -Force -File)) {
                if (-not ($sample001InputsAllowed -contains $c.Name)) {
                    Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Forbidden file in samples/sample-001-dfd-crop/inputs/: $($c.Name). Build Package 10 fixes inputs/ at exactly 6 files."
                }
            }
            foreach ($name in $sample001InputsAllowed) {
                if (-not (Test-Path -LiteralPath (Join-Path $inputsAbs $name) -PathType Leaf)) {
                    Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Required Build Package 10 input missing: samples/sample-001-dfd-crop/inputs/$name"
                }
            }
        }
        else {
            Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Required Build Package 10 inputs/ folder missing: samples/sample-001-dfd-crop/inputs/"
        }
        # expected/
        $expectedAbs = Join-Path $sample001Abs 'expected'
        if (Test-Path -LiteralPath $expectedAbs -PathType Container) {
            foreach ($c in @(Get-ChildItem -LiteralPath $expectedAbs -Force -File)) {
                if ($c.Name -eq 'expected-00-run-log.md') {
                    Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Forbidden file in samples/sample-001-dfd-crop/expected/: expected-00-run-log.md (founder decision Q2: run logs are run artefacts deferred to Build Package 11)."
                    continue
                }
                if ($c.Extension -ieq '.json') {
                    Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Forbidden JSON expected baseline in samples/sample-001-dfd-crop/expected/: $($c.Name) (founder decision Q1: Markdown-only)."
                    continue
                }
                if (-not ($sample001ExpectedAllowed -contains $c.Name)) {
                    Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Forbidden file in samples/sample-001-dfd-crop/expected/: $($c.Name). Build Package 10 fixes expected/ at exactly 26 Markdown baselines (17 RS + 9 DFD)."
                }
            }
            foreach ($name in $sample001ExpectedAllowed) {
                if (-not (Test-Path -LiteralPath (Join-Path $expectedAbs $name) -PathType Leaf)) {
                    Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Required Build Package 10 expected baseline missing: samples/sample-001-dfd-crop/expected/$name"
                }
            }
        }
        else {
            Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Required Build Package 10 expected/ folder missing: samples/sample-001-dfd-crop/expected/"
        }
    }
    else {
        Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "Required Build Package 10 sample folder missing: samples/sample-001-dfd-crop/"
    }
    $samplesFails = @($results | Where-Object { $_.Check -eq '08h-samples-content-limits' -and $_.Status -eq 'FAIL' }).Count
    if ($samplesFails -eq 0) {
        Add-Result -Status PASS -Check '08h-samples-content-limits' -Detail "samples/ surface matches Build Package 10 contract (README.md, sample-registry.yaml, sample-001-dfd-crop/ with README.md, inputs/ holding 6 files, and expected/ holding 26 Markdown baselines: 17 RS + 9 DFD)."
    }
}
else {
    Add-Result -Status FAIL -Check '08h-samples-content-limits' -Detail "samples/ folder is missing."
}

# 9b. runs/ — Build Package 11 surface (Check 08i-runs-content-limits)
# Allowed under runs/: README.md plus exactly one governed run folder, RUN-001.
# Other runs/RUN-* folders are smoke runs and are reported as WARN by Check 14.
# Allowed under runs/RUN-001/: README.md, run-profile.yaml, 00-run-log.md,
#   inputs/, dfd/, and (when the chain has executed) the 17 RS outputs at
#   root matching ^(0[1-9]|1[0-7])-[a-z0-9-]+\.md$ and the 9 DFD outputs
#   under dfd/ as a fixed allow-list of governed BP12B post-execution
#   filenames (01-intake-quality-check.md ... 09-extraction-summary.md).
#   Optional Jira/Confluence draft files (jira-ticket-draft.md,
#   confluence-page-draft.md) are also permitted.
# Allowed under runs/RUN-001/inputs/: exactly the 6 byte-copied sample
#   inputs (no other files; no subfolders).
# Allowed under runs/RUN-001/dfd/: empty (Build Package 11 reservation),
#   .gitkeep (Build Package 12 fresh-clone reservation marker), or the
#   9 BP12B post-execution DFD chain outputs (fixed allow-list). No
#   nested folders. Arbitrary extra files are FAIL.
# FAIL anything else.
$run001InputsAllowed = @('dfd-crop.png', 'dfd-crop.mmd', 'dfd-legend-excerpt.md', 'cloud-triage-notes.md', 'review-transcript.md', 'intake-ticket.md')
$run001RootAllowedFiles = @('README.md', 'run-profile.yaml', '00-run-log.md', 'jira-ticket-draft.md', 'confluence-page-draft.md')
$run001RootRsOutputPattern = '^(0[1-9]|1[0-7])-[a-z0-9-]+\.md$'
$run001DfdOutputsAllowed = @(
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
$run001Abs = Resolve-PackagePath 'runs/RUN-001'
if (Test-Path -LiteralPath $run001Abs -PathType Container) {
    # Required Build Package 11 files at run-folder root
    foreach ($name in @('README.md', 'run-profile.yaml', '00-run-log.md')) {
        if (-not (Test-Path -LiteralPath (Join-Path $run001Abs $name) -PathType Leaf)) {
            Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Required Build Package 11 file missing: runs/RUN-001/$name"
        }
    }
    # Top-level files
    foreach ($c in @(Get-ChildItem -LiteralPath $run001Abs -Force -File)) {
        if ($run001RootAllowedFiles -contains $c.Name) { continue }
        if ($c.Name -match $run001RootRsOutputPattern) { continue }
        Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Forbidden file in runs/RUN-001/: $($c.Name). Build Package 11 fixture allows README.md, run-profile.yaml, 00-run-log.md, optional jira/confluence drafts, and 17 RS chain outputs matching '$run001RootRsOutputPattern'."
    }
    # Top-level subfolders
    $run001AllowedDirs = @('inputs', 'dfd')
    foreach ($d in @(Get-ChildItem -LiteralPath $run001Abs -Force -Directory)) {
        if (-not ($run001AllowedDirs -contains $d.Name)) {
            Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Forbidden subfolder in runs/RUN-001/: $($d.Name). Build Package 11 allows only inputs/ and dfd/."
        }
    }
    # inputs/ — must contain exactly the 6 byte-copied sample inputs
    $run001Inputs = Join-Path $run001Abs 'inputs'
    if (Test-Path -LiteralPath $run001Inputs -PathType Container) {
        foreach ($d in @(Get-ChildItem -LiteralPath $run001Inputs -Force -Directory)) {
            Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Forbidden subfolder in runs/RUN-001/inputs/ (Build Package 11 disallows nested folders): $($d.Name)/"
        }
        foreach ($c in @(Get-ChildItem -LiteralPath $run001Inputs -Force -File)) {
            if (-not ($run001InputsAllowed -contains $c.Name)) {
                Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Forbidden file in runs/RUN-001/inputs/: $($c.Name). Build Package 11 fixes inputs/ at exactly 6 byte-copied sample inputs."
            }
        }
        foreach ($name in $run001InputsAllowed) {
            if (-not (Test-Path -LiteralPath (Join-Path $run001Inputs $name) -PathType Leaf)) {
                Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Required Build Package 11 input missing: runs/RUN-001/inputs/$name"
            }
        }
    }
    else {
        Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Required Build Package 11 inputs/ folder missing: runs/RUN-001/inputs/"
    }
    # dfd/ — empty (Build Package 11/12), .gitkeep (Build Package 12 fresh-clone reservation marker), or the 9 BP12B post-execution DFD chain outputs (fixed allow-list)
    $run001Dfd = Join-Path $run001Abs 'dfd'
    if (Test-Path -LiteralPath $run001Dfd -PathType Container) {
        foreach ($d in @(Get-ChildItem -LiteralPath $run001Dfd -Force -Directory)) {
            Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Forbidden subfolder in runs/RUN-001/dfd/ (Build Package 11 disallows nested folders): $($d.Name)/"
        }
        foreach ($c in @(Get-ChildItem -LiteralPath $run001Dfd -Force -File)) {
            if ($c.Name -eq '.gitkeep') { continue }
            if ($run001DfdOutputsAllowed -contains $c.Name) { continue }
            Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Forbidden file in runs/RUN-001/dfd/: $($c.Name). Build Package 11 reserves dfd/ empty; Build Package 12 permits '.gitkeep' as a fresh-clone reservation marker; Build Package 12B post-execution permits exactly the 9 governed DFD chain outputs (01-intake-quality-check.md, 02-boundary-catalog.md, 03-component-catalog.md, 04-flow-inventory.md, 05-annotation-resolution.md, 06-boundary-crossings.md, 07-control-signals.md, 08-confidence-score.md, 09-extraction-summary.md). No other filenames are permitted."
        }
    }
    else {
        Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Required Build Package 11 dfd/ folder missing: runs/RUN-001/dfd/"
    }
    $run001Fails = @($results | Where-Object { $_.Check -eq '08i-runs-content-limits' -and $_.Status -eq 'FAIL' }).Count
    if ($run001Fails -eq 0) {
        Add-Result -Status PASS -Check '08i-runs-content-limits' -Detail "runs/RUN-001/ surface matches Build Package 11 contract (README.md, run-profile.yaml, 00-run-log.md, inputs/ with 6 byte-copied files; dfd/ accepts the empty/.gitkeep BP11/12 reservation OR the 9 governed BP12B post-execution DFD chain outputs as a fixed allow-list)."
    }
}
else {
    Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Required Build Package 11 run fixture missing: runs/RUN-001/"
}

# 08j. sample DFD grammar — Build Package 10A default sample-DFD standard
# Enforces against samples/sample-001-dfd-crop/inputs/dfd-crop.mmd:
#   - 4-token flow grammar: <flow name> / <C#>,<T#>,<IA#|SA#|CA#>,<AZ#|AZ?>
#   - explicit authorization on every flow (AZ# or AZ?)
#   - embedded legend subgraph present (subgraph LEGEND)
#   - storage tuple on every Data subnet store (<class> • R# • <Enc|Tok|Mask|Clr|Unknown>)
#   - no BND-NN/CMP-NN/F#/BC-NN as primary visual labels (subgraph titles, node visible labels)
$dfdMmdPath = Resolve-PackagePath 'samples/sample-001-dfd-crop/inputs/dfd-crop.mmd'
if (Test-Path -LiteralPath $dfdMmdPath -PathType Leaf) {
    $dfdMmd = Get-Content -LiteralPath $dfdMmdPath -Raw
    $dfdGrammarFails = @()

    # 1. embedded legend subgraph present
    if (-not ($dfdMmd -match '(?m)^\s*subgraph\s+LEGEND\b')) {
        $dfdGrammarFails += "Embedded legend subgraph 'subgraph LEGEND' missing in dfd-crop.mmd. Default DFD standard (no-drift-rules.md rule 20) requires a compact legend panel inside the rendered DFD."
    }

    # 2. flow grammar: every Mermaid edge label must match 4-token grammar
    $flowEdgeRegex = '--\s*"([^"]+)"\s*-->'
    $flowGrammarRegex = '^[^/]+\s*/\s*C[0-9]+,T[0-9]+,(IA|SA|CA)[0-9]+[OS]?,(AZ[0-9]+|AZ\?)$'
    $edgeMatches = [regex]::Matches($dfdMmd, $flowEdgeRegex)
    foreach ($m in $edgeMatches) {
        $label = $m.Groups[1].Value
        if ($label -notmatch $flowGrammarRegex) {
            $dfdGrammarFails += "Non-compliant flow label in dfd-crop.mmd (no-drift-rules.md rules 18-19; default 4-token grammar): '$label'. Required: <flow name> / <C#>,<T#>,<IA#|SA#|CA#>,<AZ#|AZ?>"
        }
    }
    if ($edgeMatches.Count -lt 1) {
        $dfdGrammarFails += "No flow edges parsed from dfd-crop.mmd (expected 14)."
    }

    # 3. data-store storage tuple: every node label containing the bullet '•' must match 3-token tuple
    $storeNodeRegex = '\["([^"]*•[^"]*)"\]'
    $storeTupleRegex = '^[^•]+•\s*R[0-9]+\s*•\s*(Enc|Tok|Mask|Clr|Unknown)$'
    $storeMatches = [regex]::Matches($dfdMmd, $storeNodeRegex)
    foreach ($m in $storeMatches) {
        $label = $m.Groups[1].Value
        # Strip Mermaid <br/> line breaks; keep the storage line for the regex match
        $bodyAfterBr = ($label -split '<br/>')[-1]
        # Trim a leading C#-token (e.g., "C4 ") if present at start of bodyAfterBr — actually the stored label is "<class> • R1 • Enc" already
        if ($bodyAfterBr -notmatch $storeTupleRegex) {
            $dfdGrammarFails += "Non-compliant data-store storage tuple in dfd-crop.mmd (no-drift-rules.md rule 21): '$label'. Required: <class> • R# • <Enc|Tok|Mask|Clr|Unknown>"
        }
    }

    # 4. no extraction-ID-as-primary-visual-label
    # Check subgraph titles and node visible labels for BND-NN / CMP-NN / F# / BC-NN at start of label string
    $subgraphTitleRegex = '(?m)^\s*subgraph\s+\S+\s*\[(BND-[0-9]+|CMP-[0-9]+|F[0-9]+|BC-[0-9]+)\b'
    if ($dfdMmd -match $subgraphTitleRegex) {
        $dfdGrammarFails += "Extraction ID as primary subgraph title in dfd-crop.mmd (no-drift-rules.md rule 22): '$($Matches[1])'. Subgraph titles must be real architecture concepts."
    }
    $nodeIdLabelRegex = '\["((?:BND-[0-9]+|CMP-[0-9]+|F[0-9]+|BC-[0-9]+)[\s].*?)"\]'
    if ($dfdMmd -match $nodeIdLabelRegex) {
        $dfdGrammarFails += "Extraction ID as primary visual node label in dfd-crop.mmd (no-drift-rules.md rule 22): '$($Matches[1])'. Node visible labels must be real component / boundary names."
    }

    if ($dfdGrammarFails.Count -gt 0) {
        foreach ($s in $dfdGrammarFails) { Add-Result -Status FAIL -Check '08j-sample-dfd-grammar' -Detail $s }
    }
    else {
        $flowCount = $edgeMatches.Count
        $storeCount = $storeMatches.Count
        Add-Result -Status PASS -Check '08j-sample-dfd-grammar' -Detail "samples/sample-001-dfd-crop/inputs/dfd-crop.mmd conforms to the Build Package 10A default DFD standard (no-drift-rules.md rules 18-22): embedded LEGEND subgraph present; $flowCount flows match the 4-token grammar with explicit AZ# or AZ?; $storeCount data-store tuples match <class> • R# • <Enc|Tok|Mask|Clr|Unknown>; no BND-NN/CMP-NN/F#/BC-NN extraction IDs leaked into primary visual labels."
    }
}
else {
    Add-Result -Status FAIL -Check '08j-sample-dfd-grammar' -Detail "Required sample DFD source missing: samples/sample-001-dfd-crop/inputs/dfd-crop.mmd"
}

# 10. authoring-agents/ — only the four templates approved by Build Package 01
$authAbs = Resolve-PackagePath 'authoring-agents'
$authoringAllowed = @('README.md', 'agent-instruction-triad-template.md', 'package-build-agent-template.md', 'package-validation-template.md', 'package-acceptance-checklist.md')
$authoringFails = @()
if (Test-Path -LiteralPath $authAbs -PathType Container) {
    foreach ($c in @(Get-ChildItem -LiteralPath $authAbs -Force -File)) {
        if (-not ($authoringAllowed -contains $c.Name)) {
            $authoringFails += "authoring-agents/$($c.Name)"
        }
    }
}
if ($authoringFails.Count -gt 0) {
    foreach ($s in $authoringFails) { Add-Result -Status FAIL -Check '10-authoring-agents-allowed' -Detail "Unexpected file in authoring-agents/: $s" }
}
else {
    Add-Result -Status PASS -Check '10-authoring-agents-allowed' -Detail "authoring-agents/ contains only the four Build Package 01 templates."
}

# 11. validation/ — Build Package 03 expected file set
$validationAbs = Resolve-PackagePath 'validation'
$validationAllowed = @('README.md', 'no-drift-rules.md', 'release-readiness-checklist.md', 'package-01-foundation-checklist.md', 'package-02-config-checklist.md', 'package-03-tools-checklist.md', 'package-04-prompts-checklist.md', 'prompt-registry-checklist.md', 'package-05-skills-checklist.md', 'skill-registry-checklist.md', 'package-06-agents-checklist.md', 'agent-registry-checklist.md', 'prompt-skill-agent-mapping-checklist.md', 'package-07-catalogs-checklist.md', 'catalog-registry-checklist.md', 'catalog-consumption-checklist.md', 'package-08-blueprints-checklist.md', 'blueprint-registry-checklist.md', 'blueprint-catalog-consumption-checklist.md', 'package-09-templates-checklist.md', 'template-registry-checklist.md', 'template-consumption-checklist.md', 'package-10-samples-checklist.md', 'sample-registry-checklist.md', 'sample-baseline-checklist.md', 'package-11-runs-checklist.md', 'run-folder-shape-checklist.md', 'run-log-checklist.md', 'run-comparison-checklist.md', 'package-12-validation-checklist.md', 'scoring-rubric-checklist.md', 'package-lint-master-checklist.md', 'expected-output-lint-checklist.md', 'prompt-skill-pra-parity-checklist.md', 'sample-input-readiness-checklist.md', 'local-run-readiness-checklist.md', 'prototype-execution-readiness-checklist.md', 'diagram-readiness-pre-render-checklist.md', 'docs-readiness-pre-render-checklist.md', 'final-qa-checklist.md', 'package-10a-corrective-patch-checklist.md', 'package-11a-input-refresh-checklist.md', 'package-12c-operator-experience-plan.md', 'agent-skill-projection-checklist.md', 'hook-readiness-checklist.md', 'role-smoke-test-checklist.md', 'chat-preview-test-checklist.md', 'package-12c-proposed-file-tree.md', 'package-12c-controlled-output-checklist.md', 'package-12c-regression-checklist.md', 'package-12c-operator-card-usability-checklist.md', 'package-12c-manual-operator-test-guide.md', 'package-12c-quick-manual-test-card.md', 'package-12c-sample-input-output-test-card.md', 'package-12c-solution-package-architecture.md', 'package-12c-agent-spec-template.md', 'package-12c-capability-agent-traceability-register.md', 'package-12c-platform-projection-matrix.md', 'package-12c-plugin-roadmap.md', 'package-12c-qa-agent-spec.md', 'package-12c-plugin-install-and-publication-checklist.md')
$validationAllowed += @(
    'package-12c-repository-editor-agent-spec.md',
    'package-12c-public-primer-draft.md',
    'package-12c-operator-quickstart-draft.md',
    'package-12c-security-review-workflow-draft.md',
    'package-12c-architecture-overview-draft.md',
    'package-12c-roadmap-draft.md',
    'package-12c-l2b-controlled-output-smoke-plan.md',
    'package-12c-l2b-closeout-plugin-discovery-report.md',
    'package-12c-release-qa-report.md',
    'package-12c-release-blocker-register.md',
    'package-12c-editor-readability-report.md',
    'package-12c-rel0-final-qa-report.md',
    'package-12c-rel0-final-qa-remediation-report.md',
    'package-12c-rel0-final-qa-remediation-closeout-report.md',
    'package-12c-rel0-final-qa-remediation-bp12a-drift-allowlist-decision-report.md',
    'package-12c-rel0-final-qa-rerun-report.md',
    'package-12c-rel0-release-decision-report.md',
    'package-12c-rel0-release-decision-remediation-report.md',
    'package-12c-rel0-release-decision-rerun-report.md',
    'package-12c-rel0-release-decision-stage-commit-fix-a-report.md',
    'package-12c-rel0-release-decision-stage-commit-retry-report.md',
    'package-12c-rel0-release-decision-founder-approval-report.md',
    'package-12c-rel0-public-license-notice-fix-eval-report.md',
    'package-12c-rel0-public-license-notice-fix-eval-bp12a-drift-policy-report.md',
    'package-12c-rel0-final-release-qa-report.md',
    'package-12c-rel0-final-release-blocker-register.md',
    'package-12c-rel0-c-micropatch-report.md',
    'package-12c-rel0-c-fix-a-report.md',
    'package-12c-am3-runtime-plan.md',
    'package-12c-am3-definition-of-done.md',
    'package-12c-am3-test-plan.md',
    'package-12c-am3-risk-register.md',
    'package-12c-am3-contracts-report.md',
    'package-12c-am3-runtime-report.md',
    'package-12c-am3-runtime-mp1-report.md',
    'package-12c-am3-smoke-evidence-report.md',
    'package-12c-am3-smoke-retry-evidence-report.md',
    'package-12c-am3-qa-report.md',
    'package-12c-am3-release-claim-alignment-report.md',
    'package-13-first-public-visual-pack-report.md',
    'package-13-first-public-visual-pack-bp12a-drift-policy-report.md',
    'package-13-final-qa-and-publication-export-prep-report.md',
    'package-12c-rel0-final-public-qa-report.md',
    'package-12c-rel0-post-commit-qa-report.md',
    'package-12c-rel0-github-prerelease-stakeholder-asset-pack-report.md',
    'package-12c-rel0-product-flow-adapter-roadmap-rebase-report.md',
    'package-12c-rel0-operating-flow-observability-ux-rebase-report.md',
    'package-12c-rel0-operating-flow-ux-stage-commit-report.md',
    'package-12c-rel0-cross-shell-command-ux-report.md'
)
$validationFails = @()
if (Test-Path -LiteralPath $validationAbs -PathType Container) {
    foreach ($c in @(Get-ChildItem -LiteralPath $validationAbs -Force -File)) {
        if (-not ($validationAllowed -contains $c.Name)) {
            $validationFails += "validation/$($c.Name)"
        }
    }
}
if ($validationFails.Count -gt 0) {
    foreach ($s in $validationFails) { Add-Result -Status FAIL -Check '11-validation-allowed' -Detail "Unexpected file in validation/ at Build Package 12: $s" }
}
else {
    Add-Result -Status PASS -Check '11-validation-allowed' -Detail "validation/ contains only the Build Package 01-12C documents (including BP12C planning, implementation checklists, and WP-12C-I solution-package alignment artifacts)."
}

# 12. tools/ — Build Package 03 expected file set plus exact WP-12C-K3C bundle build script path
$toolsAbs = Resolve-PackagePath 'tools'
$toolsAllowed = @('README.md', 'New-AisrafRun.ps1', 'Test-AisrafRunProfile.ps1', 'Test-AisrafPackage.ps1', 'Test-AisrafBp12AReadiness.ps1', 'Build-AisrafCopilotPluginBundle.ps1', 'Invoke-AisrafAm3LocalRun.ps1', 'Test-AisrafAm3Runtime.ps1')
$hookAllowed = @('README.md', 'hook-allow-list.yaml', 'aisraf-allowed-path-prewrite-guard.ps1', 'aisraf-focused-validator-postwrite.ps1', 'aisraf-session-stop-summary.ps1', 'aisraf-precommit-full-validator.ps1')
$toolsFails = @()
if (Test-Path -LiteralPath $toolsAbs -PathType Container) {
    foreach ($d in @(Get-ChildItem -LiteralPath $toolsAbs -Force -Directory)) {
        if ($d.Name -ne 'hooks') {
            $toolsFails += "tools/$($d.Name)/"
        }
    }
    foreach ($c in @(Get-ChildItem -LiteralPath $toolsAbs -Force -File)) {
        if (-not ($toolsAllowed -contains $c.Name)) {
            $toolsFails += "tools/$($c.Name)"
        }
    }
    $hooksAbs = Join-Path $toolsAbs 'hooks'
    if (-not (Test-Path -LiteralPath $hooksAbs -PathType Container)) {
        $toolsFails += 'tools/hooks/'
    }
    else {
        foreach ($child in @(Get-ChildItem -LiteralPath $hooksAbs -Force)) {
            if ($child.PSIsContainer) {
                $toolsFails += "tools/hooks/$($child.Name)/"
                continue
            }
            if (-not ($hookAllowed -contains $child.Name)) {
                $toolsFails += "tools/hooks/$($child.Name)"
            }
        }
        foreach ($name in $hookAllowed) {
            if (-not (Test-Path -LiteralPath (Join-Path $hooksAbs $name) -PathType Leaf)) {
                $toolsFails += "tools/hooks/$name"
            }
        }
    }
}
if ($toolsFails.Count -gt 0) {
    foreach ($s in $toolsFails) { Add-Result -Status FAIL -Check '12-tools-allowed' -Detail "Unexpected or missing tools surface entry: $s. Build Package 12C allows the core tools plus tools/hooks/ hook scripts and allow-list." }
}
else {
    Add-Result -Status PASS -Check '12-tools-allowed' -Detail "tools/ contains the core scripts plus the BP12C tools/hooks/ README, hook allow-list, 4 hook scripts, and only the exact future K3C bundle build script path when present."
}

# 13. config/ — Build Package 02 expected file set
$configAbs = Resolve-PackagePath 'config'
$configAllowed = @('README.md', 'run-profile.schema.yaml', 'run-profile.template.yaml', 'run-profile.sample.folder-first.yaml', 'run-profile.sample.integration.yaml', 'run-profile.field-catalog.md', 'run-profile.validation-rules.md', 'path-resolution-rules.md', 'integration-fields.md', 'sensitive-data-rules.md')
# WP-12C-AM3-CONTRACTS: four AM3 contract / schema files authored under config/ to
# define the orchestrator contract, specialist handoff contract, run-state schema,
# and event/checkpoint schema for the later AM3 local orchestrated multi-agent
# runtime. Exact-path allow-list extension only; no wildcards; no broadening of
# config/ surface. Authorized only for the WP-12C-AM3-CONTRACTS gate.
$configAllowed += @(
    'am3.orchestrator-contract.v0_1_2.yaml',
    'am3.handoff-contract.v0_1_2.yaml',
    'am3.run-state.schema.v0_1_2.yaml',
    'am3.event.schema.v0_1_2.yaml'
)
$configFails = @()
if (Test-Path -LiteralPath $configAbs -PathType Container) {
    foreach ($c in @(Get-ChildItem -LiteralPath $configAbs -Force -File)) {
        if (-not ($configAllowed -contains $c.Name)) {
            $configFails += "config/$($c.Name)"
        }
    }
}
if ($configFails.Count -gt 0) {
    foreach ($s in $configFails) { Add-Result -Status FAIL -Check '13-config-allowed' -Detail "Unexpected file in config/: $s" }
}
else {
    Add-Result -Status PASS -Check '13-config-allowed' -Detail "config/ contains only the nine Build Package 02 files plus README.md plus the four WP-12C-AM3-CONTRACTS contract / schema files (orchestrator contract, handoff contract, run-state schema, event schema)."
}

# 14. runs/ — Build Package 11 surface posture
# Allowed top-level files: README.md only. Any other file at runs/ root FAILs.
# Allowed governed run folder: runs/RUN-001/ (validated by Check 08i-runs-content-limits).
# Other runs/RUN-* folders are smoke runs from tools/New-AisrafRun.ps1 and WARN
# until removed before human git stage (per validation/no-drift-rules.md).
$runsAbs = Resolve-PackagePath 'runs'
$runFolderNames = @()
if (Test-Path -LiteralPath $runsAbs -PathType Container) {
    foreach ($c in @(Get-ChildItem -LiteralPath $runsAbs -Force -Directory)) {
        $runFolderNames += $c.Name
    }
    foreach ($f in @(Get-ChildItem -LiteralPath $runsAbs -Force -File)) {
        if ($f.Name -ne 'README.md') {
            Add-Result -Status FAIL -Check '14-runs-readme-only' -Detail "Unexpected file in runs/: runs/$($f.Name)"
        }
    }
}
$smokeRunFolders = @($runFolderNames | Where-Object { $_ -ne 'RUN-001' })
foreach ($r in $smokeRunFolders) {
    Add-Result -Status WARN -Check '14-runs-readme-only' -Detail "runs/$r/ exists alongside the governed RUN-001 fixture. Build Package 03 must remove smoke run folders before human git stage."
}
$runsFails = @($results | Where-Object { $_.Check -eq '14-runs-readme-only' -and $_.Status -eq 'FAIL' }).Count
if ($runsFails -eq 0) {
    if ($runFolderNames -contains 'RUN-001') {
        Add-Result -Status PASS -Check '14-runs-readme-only' -Detail "runs/ contains README.md and the governed RUN-001 fixture (validated by Check 08i-runs-content-limits)."
    }
    else {
        Add-Result -Status PASS -Check '14-runs-readme-only' -Detail "runs/ contains only README.md."
    }
}

# 15. Old reference workspace acknowledgement
$oldRef = 'D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01'
if (Test-Path -LiteralPath $oldRef -PathType Container) {
    Add-Result -Status PASS -Check '15-old-reference-readonly' -Detail "Old reference workspace acknowledged at $oldRef (read-only; tools never write here)."
}
else {
    Add-Result -Status WARN -Check '15-old-reference-readonly' -Detail "Old reference workspace not present at $oldRef. Schema field old_reference_workspace still names it for traceability."
}

# 16. plugins/ — WP-12C-K2 scaffold plus exact WP-12C-K3C bundle artifact paths and WP-12C-L1A provider install manifest
# plugins/ is NOT a required root folder before WP-12C-K2 creates the scaffold.
# When absent: PASS as "scaffold not opened yet."
# When present: only the exact minimal scaffold under plugins/aisraf-copilot-plugin/
# is required at plugin root. The additional root files are exact only:
# bundle-checksum-manifest.yaml from K3C and plugin.json from L1A. The only
# subfolder prepared by K3B/K3C is the exact future bundle/ target. No broad
# plugins/** allowance is introduced.
$pluginsAbs = Resolve-PackagePath 'plugins'
if (-not (Test-Path -LiteralPath $pluginsAbs -PathType Container)) {
    Add-Result -Status PASS -Check '16-plugin-content-limits' -Detail "plugins/ scaffold not opened yet (WP-12C-K2 will create plugins/aisraf-copilot-plugin/ later); no surface to validate."
}
else {
    $pluginsTopAllowedDirs = @('aisraf-copilot-plugin')
    $aisrafPluginScaffoldFiles = @(
        'README.md',
        'PLUGIN-PACKAGING-PLAN.md',
        'PLUGIN-TEST-CARD.md',
        'EVIDENCE-CHECKLIST.md',
        'plugin.yaml'
    )
    $aisrafPluginOptionalK3cFiles = @('bundle-checksum-manifest.yaml')
    $aisrafPluginOptionalL1aFiles = @('plugin.json')
    $aisrafPluginAllowedFiles = $aisrafPluginScaffoldFiles + $aisrafPluginOptionalK3cFiles + $aisrafPluginOptionalL1aFiles
    $aisrafPluginAllowedDirs = @('bundle')
    $bundleTopAllowedDirs = @('.github', '.copilot-skills', '.agents', 'prompts', 'skills', 'prototype-agents', 'templates', 'catalogs', 'blueprints', 'tools')
    $bundleToolsAllowedFiles = @('Test-AisrafPackage.ps1', 'Test-AisrafBp12AReadiness.ps1', 'Test-AisrafRunProfile.ps1', 'Invoke-AisrafAm3LocalRun.ps1', 'Test-AisrafAm3Runtime.ps1')
    foreach ($f in @(Get-ChildItem -LiteralPath $pluginsAbs -Force -File)) {
        Add-Result -Status FAIL -Check '16-plugin-content-limits' -Detail "Forbidden file at plugins/ root (only the aisraf-copilot-plugin/ subfolder is permitted): plugins/$($f.Name)"
    }
    foreach ($d in @(Get-ChildItem -LiteralPath $pluginsAbs -Force -Directory)) {
        if (-not ($pluginsTopAllowedDirs -contains $d.Name)) {
            Add-Result -Status FAIL -Check '16-plugin-content-limits' -Detail "Forbidden subfolder under plugins/ (WP-12C-K2 permits only aisraf-copilot-plugin/): plugins/$($d.Name)/"
        }
    }
    $aisrafPluginAbs = Join-Path $pluginsAbs 'aisraf-copilot-plugin'
    if (-not (Test-Path -LiteralPath $aisrafPluginAbs -PathType Container)) {
        Add-Result -Status FAIL -Check '16-plugin-content-limits' -Detail "Required plugin scaffold folder missing: plugins/aisraf-copilot-plugin/"
    }
    if (Test-Path -LiteralPath $aisrafPluginAbs -PathType Container) {
        foreach ($requiredScaffoldFile in $aisrafPluginScaffoldFiles) {
            if (-not (Test-Path -LiteralPath (Join-Path $aisrafPluginAbs $requiredScaffoldFile) -PathType Leaf)) {
                Add-Result -Status FAIL -Check '16-plugin-content-limits' -Detail "Required WP-12C-K2 scaffold file missing from plugins/aisraf-copilot-plugin/: $requiredScaffoldFile"
            }
        }
        foreach ($child in @(Get-ChildItem -LiteralPath $aisrafPluginAbs -Force)) {
            if ($child.PSIsContainer) {
                if (-not ($aisrafPluginAllowedDirs -contains $child.Name)) {
                    Add-Result -Status FAIL -Check '16-plugin-content-limits' -Detail "Forbidden subfolder in plugins/aisraf-copilot-plugin/ (only the exact future bundle/ target is allowed after K3B; no agents/, skills/, hooks/, prompts/, tools/, mcp/, validation/, evidence/, install evidence, release files, or diagrams at plugin root): plugins/aisraf-copilot-plugin/$($child.Name)/"
                    continue
                }

                foreach ($bundleChild in @(Get-ChildItem -LiteralPath $child.FullName -Force)) {
                    if ($bundleChild.PSIsContainer) {
                        if (-not ($bundleTopAllowedDirs -contains $bundleChild.Name)) {
                            Add-Result -Status FAIL -Check '16-plugin-content-limits' -Detail "Forbidden top-level folder in approved bundle target (only exact by-reference bundle surfaces are allowed; no mcp/, validation/, evidence/, samples/, runs/, install evidence, release files, or diagrams): plugins/aisraf-copilot-plugin/bundle/$($bundleChild.Name)/"
                        }
                    }
                    else {
                        Add-Result -Status FAIL -Check '16-plugin-content-limits' -Detail "Forbidden file directly under approved bundle target (bundle files must preserve source-root path shape): plugins/aisraf-copilot-plugin/bundle/$($bundleChild.Name)"
                    }
                }

                $bundleToolsAbs = Join-Path $child.FullName 'tools'
                if (Test-Path -LiteralPath $bundleToolsAbs -PathType Container) {
                    foreach ($bundleToolChild in @(Get-ChildItem -LiteralPath $bundleToolsAbs -Force)) {
                        if ($bundleToolChild.PSIsContainer) {
                            if ($bundleToolChild.Name -ne 'hooks') {
                                Add-Result -Status FAIL -Check '16-plugin-content-limits' -Detail "Forbidden folder under bundle/tools/ (only tools/hooks/ is allowed as a bundled tool subfolder): plugins/aisraf-copilot-plugin/bundle/tools/$($bundleToolChild.Name)/"
                            }
                            continue
                        }
                        if (-not ($bundleToolsAllowedFiles -contains $bundleToolChild.Name)) {
                            Add-Result -Status FAIL -Check '16-plugin-content-limits' -Detail "Forbidden file under bundle/tools/ (only selected validators are allowed at this level): plugins/aisraf-copilot-plugin/bundle/tools/$($bundleToolChild.Name)"
                        }
                    }
                }
                continue
            }
            if (-not ($aisrafPluginAllowedFiles -contains $child.Name)) {
                Add-Result -Status FAIL -Check '16-plugin-content-limits' -Detail "Forbidden file in plugins/aisraf-copilot-plugin/ (only the five WP-12C-K2 scaffold files plus exact bundle-checksum-manifest.yaml and plugin.json root files are allowed): plugins/aisraf-copilot-plugin/$($child.Name)"
            }
        }
    }
    $pluginFails = @($results | Where-Object { $_.Check -eq '16-plugin-content-limits' -and $_.Status -eq 'FAIL' }).Count
    if ($pluginFails -eq 0) {
        Add-Result -Status PASS -Check '16-plugin-content-limits' -Detail "plugins/ surface restricted to the five-file aisraf-copilot-plugin/ scaffold plus only exact bundle/, bundle-checksum-manifest.yaml, and plugin.json paths; broad plugins/** is not allowed."
    }

    $pluginJsonRelativePath = 'plugins/aisraf-copilot-plugin/plugin.json'
    $pluginJsonAbs = Resolve-PackagePath $pluginJsonRelativePath
    $pluginJsonFailures = New-Object System.Collections.Generic.List[string]
    if (-not (Test-Path -LiteralPath $pluginJsonAbs -PathType Leaf)) {
        $pluginJsonFailures.Add('plugin.json missing from plugins/aisraf-copilot-plugin/.')
    }
    else {
        $pluginJsonRaw = Get-Content -LiteralPath $pluginJsonAbs -Raw
        $pluginJsonObject = $null
        try {
            $pluginJsonObject = $pluginJsonRaw | ConvertFrom-Json -ErrorAction Stop
        }
        catch {
            $pluginJsonFailures.Add("plugin.json is not valid JSON: $($_.Exception.Message)")
        }

        if ($null -ne $pluginJsonObject) {
            if ($pluginJsonObject -is [array]) {
                $pluginJsonFailures.Add('plugin.json root must be a JSON object, not an array.')
            }
            else {
                foreach ($requiredPluginJsonField in @('name', 'description', 'version', 'author', 'agents', 'skills', 'hooks')) {
                    if (-not (Test-ObjectHasExactProperty -InputObject $pluginJsonObject -PropertyName $requiredPluginJsonField)) {
                        $pluginJsonFailures.Add("plugin.json missing required field: $requiredPluginJsonField")
                    }
                }

                $pluginJsonName = [string](Get-ExactPropertyValue -InputObject $pluginJsonObject -PropertyName 'name')
                if ($pluginJsonName -ne 'aisraf-copilot-plugin') {
                    $pluginJsonFailures.Add("plugin.json name must be aisraf-copilot-plugin; found: $pluginJsonName")
                }
                if ($pluginJsonName -notmatch '^[a-z0-9]+(-[a-z0-9]+)*$') {
                    $pluginJsonFailures.Add('plugin.json name must be kebab-case.')
                }

                $pluginJsonDescription = [string](Get-ExactPropertyValue -InputObject $pluginJsonObject -PropertyName 'description')
                if ([string]::IsNullOrWhiteSpace($pluginJsonDescription)) {
                    $pluginJsonFailures.Add('plugin.json description must be non-empty.')
                }
                if ($pluginJsonDescription.Length -ge 1024) {
                    $pluginJsonFailures.Add('plugin.json description must be under 1024 characters.')
                }

                $pluginYamlText = Get-Content -LiteralPath (Join-Path $aisrafPluginAbs 'plugin.yaml') -Raw
                $pluginYamlVersionMatch = [regex]::Match($pluginYamlText, "(?m)^version:\s*[""']?(?<version>[^""'`r`n#]+)")
                $expectedPluginVersion = if ($pluginYamlVersionMatch.Success) { $pluginYamlVersionMatch.Groups['version'].Value.Trim().Trim('"').Trim("'") } else { '0.0.0-scaffold' }
                $pluginJsonVersion = [string](Get-ExactPropertyValue -InputObject $pluginJsonObject -PropertyName 'version')
                if ($pluginJsonVersion -ne $expectedPluginVersion) {
                    $pluginJsonFailures.Add("plugin.json version must match plugin.yaml version $expectedPluginVersion; found: $pluginJsonVersion")
                }

                $pluginJsonAuthor = Get-ExactPropertyValue -InputObject $pluginJsonObject -PropertyName 'author'
                if (($null -eq $pluginJsonAuthor) -or (-not (Test-ObjectHasExactProperty -InputObject $pluginJsonAuthor -PropertyName 'name')) -or [string]::IsNullOrWhiteSpace([string](Get-ExactPropertyValue -InputObject $pluginJsonAuthor -PropertyName 'name'))) {
                    $pluginJsonFailures.Add('plugin.json author.name must exist and be non-empty.')
                }

                $expectedProviderBundlePaths = [ordered]@{
                    agents = 'bundle/.github/agents/'
                    skills = 'bundle/.github/skills/'
                    hooks  = 'bundle/.github/hooks/aisraf-guardrails.json'
                }
                foreach ($providerBundlePathEntry in $expectedProviderBundlePaths.GetEnumerator()) {
                    $providerBundleField = $providerBundlePathEntry.Key
                    $expectedProviderBundlePath = $providerBundlePathEntry.Value
                    $actualProviderBundlePath = [string](Get-ExactPropertyValue -InputObject $pluginJsonObject -PropertyName $providerBundleField)
                    if ($actualProviderBundlePath -ne $expectedProviderBundlePath) {
                        $pluginJsonFailures.Add("plugin.json $providerBundleField must point to $expectedProviderBundlePath; found: $actualProviderBundlePath")
                        continue
                    }
                    if ($actualProviderBundlePath -match '^[A-Za-z]:' -or $actualProviderBundlePath -match '^/' -or $actualProviderBundlePath -match '(^|/)\.\.(/|$)' -or (-not $actualProviderBundlePath.StartsWith('bundle/.github/', [System.StringComparison]::Ordinal))) {
                        $pluginJsonFailures.Add("plugin.json $providerBundleField must stay inside the approved bundled provider surfaces; found: $actualProviderBundlePath")
                        continue
                    }
                    $normalizedProviderBundlePath = $actualProviderBundlePath.TrimEnd('/')
                    $providerBundleAbs = Join-Path $aisrafPluginAbs ($normalizedProviderBundlePath -replace '/', [System.IO.Path]::DirectorySeparatorChar)
                    $expectedPathType = if ($providerBundleField -eq 'hooks') { 'Leaf' } else { 'Container' }
                    if (-not (Test-Path -LiteralPath $providerBundleAbs -PathType $expectedPathType)) {
                        $pluginJsonFailures.Add("plugin.json $providerBundleField target does not exist as ${expectedPathType}: $actualProviderBundlePath")
                    }
                }

                if ((Test-ObjectHasExactProperty -InputObject $pluginJsonObject -PropertyName 'mcpServers') -or $pluginJsonRaw -match '"mcpServers"\s*:') {
                    $pluginJsonFailures.Add('plugin.json must not include mcpServers.')
                }

                $forbiddenPluginJsonClaimPatterns = @(
                    '"external_execution"\s*:',
                    '"runtime_claims"\s*:',
                    '"postback_execution_status"\s*:',
                    '"output_destination_mode"\s*:',
                    '(?i)\bmcp\b',
                    '(?i)\bjira\b',
                    '(?i)\bconfluence\b',
                    '(?i)\blucidchart\b',
                    '(?i)\bclaude\b',
                    '(?i)\bfoundry\b',
                    '(?i)\badk\b',
                    '(?i)\bmaf\b',
                    '(?i)\bdatabase\b',
                    '(?i)\bterraform\b',
                    '(?i)\bpost-?back\b',
                    '(?i)\bcloud\b'
                )
                foreach ($forbiddenPluginJsonClaimPattern in $forbiddenPluginJsonClaimPatterns) {
                    if ($pluginJsonRaw -match $forbiddenPluginJsonClaimPattern) {
                        $pluginJsonFailures.Add("plugin.json contains forbidden external execution claim pattern: $forbiddenPluginJsonClaimPattern")
                    }
                }
            }
        }
    }
    if ($pluginJsonFailures.Count -gt 0) {
        foreach ($pluginJsonFailure in $pluginJsonFailures) {
            Add-Result -Status FAIL -Check '16c-plugin-provider-install-manifest' -Detail $pluginJsonFailure
        }
    }
    else {
        Add-Result -Status PASS -Check '16c-plugin-provider-install-manifest' -Detail 'plugin.json is valid JSON, has required provider fields, points only to bundled provider agents/skills/hooks, omits mcpServers, and has no external execution claim.'
    }

    $canonicalBodyDuplicationHits = @(Get-PluginCanonicalBodyDuplicationHits -PluginRootRelativePath 'plugins/aisraf-copilot-plugin')
    if ($canonicalBodyDuplicationHits.Count -gt 0) {
        foreach ($canonicalBodyDuplicationHit in $canonicalBodyDuplicationHits) {
            Add-Result -Status FAIL -Check '16a-plugin-no-canonical-body-duplication' -Detail $canonicalBodyDuplicationHit
        }
    }
    else {
        Add-Result -Status PASS -Check '16a-plugin-no-canonical-body-duplication' -Detail "Plugin root files and plugin metadata contain no copied canonical body blocks of 200+ characters."
    }

    $bundleAbs = Join-Path $aisrafPluginAbs 'bundle'
    $bundleManifestRelativePath = 'plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml'
    $bundleManifestAbs = Resolve-PackagePath $bundleManifestRelativePath
    $bundleChecksumFailures = New-Object System.Collections.Generic.List[string]

    if ((Test-Path -LiteralPath $bundleAbs -PathType Container) -and (-not (Test-Path -LiteralPath $bundleManifestAbs -PathType Leaf))) {
        $bundleChecksumFailures.Add('plugins/aisraf-copilot-plugin/bundle/ exists without plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml')
    }
    if ((Test-Path -LiteralPath $bundleManifestAbs -PathType Leaf) -and (-not (Test-Path -LiteralPath $bundleAbs -PathType Container))) {
        $bundleChecksumFailures.Add('plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml exists without plugins/aisraf-copilot-plugin/bundle/')
    }

    if (Test-Path -LiteralPath $bundleManifestAbs -PathType Leaf) {
        $bundleEntries = @(Read-BundleChecksumManifestEntries -ManifestAbsolutePath $bundleManifestAbs)
        if ($bundleEntries.Count -eq 0) {
            $bundleChecksumFailures.Add('bundle-checksum-manifest.yaml contains no source/target hash entries')
        }

        $manifestTargetPaths = New-Object System.Collections.Generic.List[string]
        foreach ($bundleEntry in $bundleEntries) {
            foreach ($requiredField in @('source_path', 'target_path', 'source_sha256', 'target_sha256')) {
                if (-not $bundleEntry.ContainsKey($requiredField)) {
                    $bundleChecksumFailures.Add("bundle-checksum-manifest.yaml entry missing required field: $requiredField")
                }
            }
            if (-not ($bundleEntry.ContainsKey('source_path') -and $bundleEntry.ContainsKey('target_path') -and $bundleEntry.ContainsKey('source_sha256') -and $bundleEntry.ContainsKey('target_sha256'))) {
                continue
            }

            $sourcePath = $bundleEntry['source_path']
            $targetPath = $bundleEntry['target_path']
            $sourceSha256 = $bundleEntry['source_sha256'].ToLowerInvariant()
            $targetSha256 = $bundleEntry['target_sha256'].ToLowerInvariant()
            $manifestTargetPaths.Add($targetPath)

            if (-not (Test-ApprovedBundleSourcePath -RelativePath $sourcePath)) {
                $bundleChecksumFailures.Add("Unauthorized bundle source path in checksum manifest: $sourcePath")
            }

            $expectedTargetPath = "plugins/aisraf-copilot-plugin/bundle/$sourcePath"
            if ($targetPath -ne $expectedTargetPath) {
                $bundleChecksumFailures.Add("Bundle target path does not preserve source-root shape: source=$sourcePath target=$targetPath expected=$expectedTargetPath")
            }
            if ($sourcePath -notmatch '^[^:]+$' -or $sourcePath -match '(^|/)\.\.(/|$)') {
                $bundleChecksumFailures.Add("Invalid relative source path in checksum manifest: $sourcePath")
            }
            if ($targetPath -notmatch '^plugins/aisraf-copilot-plugin/bundle/' -or $targetPath -match '(^|/)\.\.(/|$)') {
                $bundleChecksumFailures.Add("Invalid target path in checksum manifest: $targetPath")
            }
            if ($sourceSha256 -notmatch '^[a-f0-9]{64}$') {
                $bundleChecksumFailures.Add("Invalid source_sha256 for $sourcePath")
            }
            if ($targetSha256 -notmatch '^[a-f0-9]{64}$') {
                $bundleChecksumFailures.Add("Invalid target_sha256 for $targetPath")
            }

            $sourceAbs = Resolve-PackagePath $sourcePath
            $targetAbs = Resolve-PackagePath $targetPath
            if (-not (Test-Path -LiteralPath $sourceAbs -PathType Leaf)) {
                $bundleChecksumFailures.Add("Checksum manifest source file missing: $sourcePath")
                continue
            }
            if (-not (Test-Path -LiteralPath $targetAbs -PathType Leaf)) {
                $bundleChecksumFailures.Add("Checksum manifest target file missing: $targetPath")
                continue
            }

            $actualSourceSha256 = (Get-FileHash -LiteralPath $sourceAbs -Algorithm SHA256).Hash.ToLowerInvariant()
            $actualTargetSha256 = (Get-FileHash -LiteralPath $targetAbs -Algorithm SHA256).Hash.ToLowerInvariant()
            if ($sourceSha256 -ne $actualSourceSha256) {
                $bundleChecksumFailures.Add("source_sha256 mismatch for $sourcePath")
            }
            if ($targetSha256 -ne $actualTargetSha256) {
                $bundleChecksumFailures.Add("target_sha256 mismatch for $targetPath")
            }
            if ($actualSourceSha256 -ne $actualTargetSha256) {
                $bundleChecksumFailures.Add("source and target hashes differ for $sourcePath")
            }
        }

        if (Test-Path -LiteralPath $bundleAbs -PathType Container) {
            foreach ($bundleFile in @(Get-ChildItem -LiteralPath $bundleAbs -Recurse -Force -File -ErrorAction SilentlyContinue)) {
                $bundleFileRelativePath = Convert-ToPackageRelativePath $bundleFile.FullName
                if (-not ($manifestTargetPaths -contains $bundleFileRelativePath)) {
                    $bundleChecksumFailures.Add("Bundle file missing from checksum manifest: $bundleFileRelativePath")
                }
            }
        }
    }

    if ($bundleChecksumFailures.Count -gt 0) {
        foreach ($bundleChecksumFailure in $bundleChecksumFailures) {
            Add-Result -Status FAIL -Check '16b-plugin-bundle-checksum-validation' -Detail $bundleChecksumFailure
        }
    }
    elseif (Test-Path -LiteralPath $bundleManifestAbs -PathType Leaf) {
        Add-Result -Status PASS -Check '16b-plugin-bundle-checksum-validation' -Detail "bundle-checksum-manifest.yaml validates source path, target path, source SHA-256, and target SHA-256 for every bundled file."
    }
    else {
        Add-Result -Status PASS -Check '16b-plugin-bundle-checksum-validation' -Detail "K3C bundle checksum validation is prepared and inactive because bundle-checksum-manifest.yaml does not exist."
    }
}

# Print and exit
Write-Host ''
Write-Host "Test-AisrafPackage  package_root=$packageRoot" -ForegroundColor Cyan
Write-Host ''
foreach ($r in $results) {
    $color = switch ($r.Status) {
        'PASS' { 'Green' }
        'WARN' { 'Yellow' }
        'FAIL' { 'Red' }
    }
    Write-Host ("{0,-5}  {1,-32}  {2}" -f $r.Status, $r.Check, $r.Detail) -ForegroundColor $color
}
$failCount = @($results | Where-Object { $_.Status -eq 'FAIL' }).Count
$warnCount = @($results | Where-Object { $_.Status -eq 'WARN' }).Count
$passCount = @($results | Where-Object { $_.Status -eq 'PASS' }).Count
Write-Host ''
if ($failCount -eq 0) {
    Write-Host "Test-AisrafPackage: $passCount PASS, $warnCount WARN, 0 FAIL" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "Test-AisrafPackage: $passCount PASS, $warnCount WARN, $failCount FAIL" -ForegroundColor Red
    exit 1
}
