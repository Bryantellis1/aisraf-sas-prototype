<#
.SYNOPSIS
    Smoke-test the Build Package 01-04 surface of AISRAF SAS Prototype v0.1.2.

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
      - no forbidden later-package artifacts exist (DOCX/PDF/PPTX/ZIP, .agent.md,
        skill/PRA/catalog/blueprint/template/sample/diagram/docs/release
        content beyond folder README placeholders);
      - the old reference workspace path is acknowledged as read-only.

    The test does not run prompts, skills, PRAs, .agent.md adapters, Jira,
    Confluence, Rovo, MCP, scoring, diagram generation, or release export.

    runs/RUN-* folders generate WARN rows only. The Package 03 validation
    checklist requires any smoke run folder to be removed before human git
    stage.

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

# 7. Forbidden .agent.md adapters anywhere
$agentMd = @(Get-ChildItem -LiteralPath $packageRoot -Recurse -Force -File -Filter '*.agent.md' -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notlike "*\.git\*" })
if ($agentMd.Count -gt 0) {
    foreach ($a in $agentMd) {
        $rel = $a.FullName.Substring($packageRoot.Length + 1)
        Add-Result -Status FAIL -Check '07-no-agent-md' -Detail "Forbidden .agent.md adapter: $rel"
    }
}
else {
    Add-Result -Status PASS -Check '07-no-agent-md' -Detail "No .agent.md adapter files exist before Build Package 06."
}

# 8. Folder content limits — only README.md allowed before owning Build Package
# prompts/ is owned by Build Package 04 (active); see Check 08b for the prompts/ allowed surface.
$readmeOnlyFolders = @{
    'skills'           = 'Build Package 05'
    'prototype-agents' = 'Build Package 06'
    '.agents'          = 'Build Package 06'
    'catalogs'         = 'Build Package 07'
    'blueprints'       = 'Build Package 08'
    'templates'        = 'Build Package 09'
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

# 9. samples/ — only README.md at top, no sample-* subfolders before Build Package 10
$samplesAbs = Resolve-PackagePath 'samples'
$samplesFails = @()
if (Test-Path -LiteralPath $samplesAbs -PathType Container) {
    foreach ($c in @(Get-ChildItem -LiteralPath $samplesAbs -Force)) {
        if ($c.Name -ne 'README.md') {
            $samplesFails += "samples/$($c.Name)"
        }
    }
}
if ($samplesFails.Count -gt 0) {
    foreach ($s in $samplesFails) { Add-Result -Status FAIL -Check '09-samples-deferred' -Detail "Forbidden content in samples/ (owned by Build Package 10): $s" }
}
else {
    Add-Result -Status PASS -Check '09-samples-deferred' -Detail "samples/ contains only README.md."
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
$validationAllowed = @('README.md', 'no-drift-rules.md', 'release-readiness-checklist.md', 'package-01-foundation-checklist.md', 'package-02-config-checklist.md', 'package-03-tools-checklist.md', 'package-04-prompts-checklist.md', 'prompt-registry-checklist.md')
$validationFails = @()
if (Test-Path -LiteralPath $validationAbs -PathType Container) {
    foreach ($c in @(Get-ChildItem -LiteralPath $validationAbs -Force -File)) {
        if (-not ($validationAllowed -contains $c.Name)) {
            $validationFails += "validation/$($c.Name)"
        }
    }
}
if ($validationFails.Count -gt 0) {
    foreach ($s in $validationFails) { Add-Result -Status FAIL -Check '11-validation-allowed' -Detail "Unexpected file in validation/ at Build Package 03: $s" }
}
else {
    Add-Result -Status PASS -Check '11-validation-allowed' -Detail "validation/ contains only the Build Package 01-04 documents."
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

# 14. runs/ — RUN-* folders generate WARN rows; only README.md is committed
$runsAbs = Resolve-PackagePath 'runs'
$runFolders = @()
if (Test-Path -LiteralPath $runsAbs -PathType Container) {
    foreach ($c in @(Get-ChildItem -LiteralPath $runsAbs -Force -Directory)) {
        $runFolders += $c.Name
    }
    foreach ($f in @(Get-ChildItem -LiteralPath $runsAbs -Force -File)) {
        if ($f.Name -ne 'README.md') {
            Add-Result -Status FAIL -Check '14-runs-readme-only' -Detail "Unexpected file in runs/: runs/$($f.Name)"
        }
    }
}
if ($runFolders.Count -gt 0) {
    foreach ($r in $runFolders) {
        Add-Result -Status WARN -Check '14-runs-readme-only' -Detail "runs/$r/ exists. Build Package 03 must remove smoke run folders before human git stage; Build Package 11 owns the run-output surface."
    }
}
elseif (-not (@($results | Where-Object { $_.Check -eq '14-runs-readme-only' -and $_.Status -eq 'FAIL' }).Count -gt 0)) {
    Add-Result -Status PASS -Check '14-runs-readme-only' -Detail "runs/ contains only README.md."
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
