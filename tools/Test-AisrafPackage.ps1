<#
.SYNOPSIS
    Smoke-test the Build Package 01-12 surface of AISRAF SAS Prototype v0.1.2 (with corrective patch 10A active on the sample side).

.DESCRIPTION
    Test-AisrafPackage is the active package validator. It confirms:

      - required root files exist;
      - required root folders and folder READMEs exist;
      - Build Package 02 config files exist;
      - Build Package 02 validation file exists;
      - Build Package 03 tool files exist;
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
      - no forbidden later-package artifacts exist (DOCX/PDF/PPTX/ZIP,
        diagram/docs/release content beyond folder README placeholders);
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

# 1. Required root files
$rootFiles = @('README.md', 'START-HERE.md', 'PACKAGE-MANIFEST.yaml', 'PROTOTYPE-CHARTER.md', 'FOLDER-CONTRACTS.md', 'BUILD-ORDER.md')
foreach ($f in $rootFiles) {
    Test-PackageFile -Relative $f -Check '01-root-files'
}

# 2. Required root folders
$rootFolders = @('.github', '.agents', 'config', 'tools', 'prompts', 'skills', 'prototype-agents', 'catalogs', 'blueprints', 'templates', 'samples', 'runs', 'diagrams', 'docs', 'validation', 'release', 'authoring-agents')
foreach ($d in $rootFolders) {
    Test-PackageDir -Relative $d -Check '02-root-folders'
}

# 3. Folder READMEs / .github copilot-instructions
Test-PackageFile -Relative '.github/copilot-instructions.md' -Check '03-folder-readmes'
$readmeFolders = @('.agents', 'config', 'tools', 'prompts', 'skills', 'prototype-agents', 'catalogs', 'blueprints', 'templates', 'samples', 'runs', 'diagrams', 'docs', 'validation', 'release', 'authoring-agents')
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
# FAIL: any other *.agent.md anywhere in the workspace; any file under .agents/ that
# is not in the approved adapter list or README.md; any approved adapter file missing.
$approvedAdapters = @(
    'aisraf-orchestrator.agent.md',
    'aisraf-input-reader.agent.md',
    'aisraf-dfd-extractor.agent.md',
    'aisraf-review-table-builder.agent.md',
    'aisraf-blueprint-questioner.agent.md',
    'aisraf-finding-recommender.agent.md',
    'aisraf-handoff-qa-scorer.agent.md'
)
$agentMd = @(Get-ChildItem -LiteralPath $packageRoot -Recurse -Force -File -Filter '*.agent.md' -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notlike "*\.git\*" })
$agentsAbs = Resolve-PackagePath '.agents'
$agentsAbsNormalized = $agentsAbs.TrimEnd('\','/')
foreach ($a in $agentMd) {
    $parent = Split-Path -Parent $a.FullName
    $parentNormalized = $parent.TrimEnd('\','/')
    if ($parentNormalized -ieq $agentsAbsNormalized) {
        if (-not ($approvedAdapters -contains $a.Name)) {
            Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Forbidden adapter in .agents/ (not in the 7 approved Build Package 06 adapters): .agents/$($a.Name)"
        }
    }
    else {
        $rel = $a.FullName.Substring($packageRoot.Length + 1)
        Add-Result -Status FAIL -Check '07-package-06-adapters' -Detail "Forbidden *.agent.md outside .agents/ (Build Package 06 reserves adapter content for .agents/): $rel"
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
$adapterFails = @($results | Where-Object { $_.Check -eq '07-package-06-adapters' -and $_.Status -eq 'FAIL' }).Count
if ($adapterFails -eq 0) {
    Add-Result -Status PASS -Check '07-package-06-adapters' -Detail ".agents/ contains exactly the 7 approved Build Package 06 adapters plus README.md."
}

# 8. Folder content limits — only README.md allowed before owning Build Package
# prompts/ is owned by Build Package 04 (active); see Check 08b for the prompts/ allowed surface.
# skills/ is owned by Build Package 05 (active); see Check 08c for the skills/ allowed surface.
# prototype-agents/ is owned by Build Package 06 (active); see Check 08d for the prototype-agents/ allowed surface.
# .agents/ is owned by Build Package 06 (active); see Check 07 for the adapter surface.
# catalogs/ is owned by Build Package 07 (active); see Check 08e for the catalogs/ allowed surface.
# blueprints/ is owned by Build Package 08 (active); see Check 08f for the blueprints/ allowed surface.
# templates/ is owned by Build Package 09 (active); see Check 08g for the templates/ allowed surface.
$readmeOnlyFolders = @{
    'diagrams'         = 'Build Package 13'
    'docs'             = 'Build Package 14'
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
$folderLimitFails = @($results | Where-Object { $_.Check -eq '08-folder-content-limits' -and $_.Status -eq 'FAIL' }).Count
if ($folderLimitFails -eq 0) {
    Add-Result -Status PASS -Check '08-folder-content-limits' -Detail "Read-me-only folders contain only README.md."
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
#   under dfd/ matching ^dfd-0[1-9]-[a-z0-9-]+\.md$. Optional Jira/Confluence
#   draft files (jira-ticket-draft.md, confluence-page-draft.md) are also
#   permitted.
# Allowed under runs/RUN-001/inputs/: exactly the 6 byte-copied sample
#   inputs (no other files; no subfolders).
# Allowed under runs/RUN-001/dfd/: empty (Build Package 11 reservation) or
#   the 9 DFD chain outputs matching ^dfd-0[1-9]-[a-z0-9-]+\.md$. No nested
#   folders.
# FAIL anything else.
$run001InputsAllowed = @('dfd-crop.png', 'dfd-crop.mmd', 'dfd-legend-excerpt.md', 'cloud-triage-notes.md', 'review-transcript.md', 'intake-ticket.md')
$run001RootAllowedFiles = @('README.md', 'run-profile.yaml', '00-run-log.md', 'jira-ticket-draft.md', 'confluence-page-draft.md')
$run001RootRsOutputPattern = '^(0[1-9]|1[0-7])-[a-z0-9-]+\.md$'
$run001DfdOutputPattern    = '^dfd-0[1-9]-[a-z0-9-]+\.md$'
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
    # dfd/ — empty (Build Package 11/12) or 9 DFD chain outputs (post-execution); .gitkeep is permitted as a fresh-clone reservation marker (Build Package 12)
    $run001Dfd = Join-Path $run001Abs 'dfd'
    if (Test-Path -LiteralPath $run001Dfd -PathType Container) {
        foreach ($d in @(Get-ChildItem -LiteralPath $run001Dfd -Force -Directory)) {
            Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Forbidden subfolder in runs/RUN-001/dfd/ (Build Package 11 disallows nested folders): $($d.Name)/"
        }
        foreach ($c in @(Get-ChildItem -LiteralPath $run001Dfd -Force -File)) {
            if ($c.Name -notmatch $run001DfdOutputPattern -and $c.Name -ne '.gitkeep') {
                Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Forbidden file in runs/RUN-001/dfd/: $($c.Name). Build Package 11 reserves dfd/ empty (or post-chain DFD outputs matching '$run001DfdOutputPattern'); the only allowed non-DFD-output filename is '.gitkeep' (Build Package 12 fresh-clone reservation marker)."
            }
        }
    }
    else {
        Add-Result -Status FAIL -Check '08i-runs-content-limits' -Detail "Required Build Package 11 dfd/ folder missing: runs/RUN-001/dfd/"
    }
    $run001Fails = @($results | Where-Object { $_.Check -eq '08i-runs-content-limits' -and $_.Status -eq 'FAIL' }).Count
    if ($run001Fails -eq 0) {
        Add-Result -Status PASS -Check '08i-runs-content-limits' -Detail "runs/RUN-001/ surface matches Build Package 11 contract (README.md, run-profile.yaml, 00-run-log.md, inputs/ with 6 byte-copied files, and dfd/ as empty governed reservation; .gitkeep permitted in dfd/ as a fresh-clone reservation marker per Build Package 12)."
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
$validationAllowed = @('README.md', 'no-drift-rules.md', 'release-readiness-checklist.md', 'package-01-foundation-checklist.md', 'package-02-config-checklist.md', 'package-03-tools-checklist.md', 'package-04-prompts-checklist.md', 'prompt-registry-checklist.md', 'package-05-skills-checklist.md', 'skill-registry-checklist.md', 'package-06-agents-checklist.md', 'agent-registry-checklist.md', 'prompt-skill-agent-mapping-checklist.md', 'package-07-catalogs-checklist.md', 'catalog-registry-checklist.md', 'catalog-consumption-checklist.md', 'package-08-blueprints-checklist.md', 'blueprint-registry-checklist.md', 'blueprint-catalog-consumption-checklist.md', 'package-09-templates-checklist.md', 'template-registry-checklist.md', 'template-consumption-checklist.md', 'package-10-samples-checklist.md', 'sample-registry-checklist.md', 'sample-baseline-checklist.md', 'package-11-runs-checklist.md', 'run-folder-shape-checklist.md', 'run-log-checklist.md', 'run-comparison-checklist.md', 'package-12-validation-checklist.md', 'scoring-rubric-checklist.md', 'package-lint-master-checklist.md', 'expected-output-lint-checklist.md', 'prompt-skill-pra-parity-checklist.md', 'sample-input-readiness-checklist.md', 'local-run-readiness-checklist.md', 'prototype-execution-readiness-checklist.md', 'diagram-readiness-pre-render-checklist.md', 'docs-readiness-pre-render-checklist.md', 'final-qa-checklist.md', 'package-10a-corrective-patch-checklist.md')
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
    Add-Result -Status PASS -Check '11-validation-allowed' -Detail "validation/ contains only the Build Package 01-12 documents (plus Build Package 10A corrective-patch checklist)."
}

# 12. tools/ — Build Package 03 expected file set
$toolsAbs = Resolve-PackagePath 'tools'
$toolsAllowed = @('README.md', 'New-AisrafRun.ps1', 'Test-AisrafRunProfile.ps1', 'Test-AisrafPackage.ps1')
$toolsFails = @()
if (Test-Path -LiteralPath $toolsAbs -PathType Container) {
    foreach ($c in @(Get-ChildItem -LiteralPath $toolsAbs -Force -File)) {
        if (-not ($toolsAllowed -contains $c.Name)) {
            $toolsFails += "tools/$($c.Name)"
        }
    }
}
if ($toolsFails.Count -gt 0) {
    foreach ($s in $toolsFails) { Add-Result -Status FAIL -Check '12-tools-allowed' -Detail "Unexpected file in tools/: $s. Build Package 03 authorizes only the three approved scripts plus README.md." }
}
else {
    Add-Result -Status PASS -Check '12-tools-allowed' -Detail "tools/ contains only the three Build Package 03 scripts plus README.md."
}

# 13. config/ — Build Package 02 expected file set
$configAbs = Resolve-PackagePath 'config'
$configAllowed = @('README.md', 'run-profile.schema.yaml', 'run-profile.template.yaml', 'run-profile.sample.folder-first.yaml', 'run-profile.sample.integration.yaml', 'run-profile.field-catalog.md', 'run-profile.validation-rules.md', 'path-resolution-rules.md', 'integration-fields.md', 'sensitive-data-rules.md')
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
    Add-Result -Status PASS -Check '13-config-allowed' -Detail "config/ contains only the nine Build Package 02 files plus README.md."
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
