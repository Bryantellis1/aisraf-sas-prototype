<#
.SYNOPSIS
    Validate a runs/<RunId>/run-profile.yaml against the Build Package 02 schema.

.DESCRIPTION
    Test-AisrafRunProfile is a Build Package 03 validator. It enforces the
    rules declared in:

      - config/run-profile.schema.yaml (field set, types, enums, patterns)
      - config/run-profile.validation-rules.md (validation order)
      - config/path-resolution-rules.md (relative-path discipline)
      - config/sensitive-data-rules.md (string-field screening)
      - validation/no-drift-rules.md

    It does not run prompts, skills, PRAs, .agent.md adapters, Jira,
    Confluence, Rovo, MCP, scoring, diagram generation, or release export.

    Two validation levels:

      -ProfileShape    (default) Schema fields, enums, identifier patterns,
                       path rules, mode coupling, post-back honesty,
                       connector/MCP honesty, scoring coupling, no unknown
                       fields, sensitive-data screening. Allows
                       sensitive_data_confirmed_redacted: false.

      -ExecutionReady  All ProfileShape checks plus
                       sensitive_data_confirmed_redacted: true.

    Exit code 0 when all checks PASS. Exit code 1 on any FAIL.

.PARAMETER RunProfilePath
    Path to the run-profile.yaml to validate.

.PARAMETER ProfileShape
    Use ProfileShape level (default).

.PARAMETER ExecutionReady
    Use ExecutionReady level. Implies ProfileShape.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$RunProfilePath,

    [switch]$ProfileShape,

    [switch]$ExecutionReady
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ($ExecutionReady.IsPresent) {
    $level = 'ExecutionReady'
}
else {
    $level = 'ProfileShape'
}

$results = New-Object System.Collections.Generic.List[psobject]
function Add-Result {
    param(
        [Parameter(Mandatory = $true)][ValidateSet('PASS', 'FAIL')][string]$Status,
        [Parameter(Mandatory = $true)][string]$Check,
        [Parameter(Mandatory = $true)][string]$Detail
    )
    $results.Add([pscustomobject]@{ Status = $Status; Check = $Check; Detail = $Detail })
}

if (-not (Test-Path -LiteralPath $RunProfilePath -PathType Leaf)) {
    Write-Host ''
    Write-Host "FAIL  file-presence  Run profile not found: $RunProfilePath" -ForegroundColor Red
    Write-Host ''
    Write-Host "Test-AisrafRunProfile: 1 FAIL, 0 PASS (level=$level)" -ForegroundColor Red
    exit 1
}

function ConvertFrom-FlatYaml {
    param([Parameter(Mandatory = $true)][string]$Path)
    $hash = [System.Collections.Specialized.OrderedDictionary]::new()
    $unknown = New-Object System.Collections.Generic.List[string]
    $lineNo = 0
    foreach ($raw in (Get-Content -LiteralPath $Path)) {
        $lineNo++
        $trimmed = $raw -replace '\s+$', ''
        if ($trimmed -eq '') { continue }
        if ($trimmed -match '^\s*#') { continue }
        if ($trimmed -match '^\s+\S' -and $trimmed -notmatch '^[A-Za-z_]') {
            throw "Indented YAML not supported (line $lineNo): '$raw'"
        }
        if ($trimmed -notmatch '^([A-Za-z_][A-Za-z0-9_]*)\s*:\s*(.*)$') {
            throw "Unparseable YAML line $lineNo`: '$raw'"
        }
        $key = $Matches[1]
        $val = $Matches[2]
        if ($val -match '^"(.*)"\s*$') {
            $stringVal = $Matches[1].Replace('\\', '\').Replace('\"', '"')
            $hash[$key] = $stringVal
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
        elseif ($val -eq '' -or $val -eq '~' -or $val -eq 'null') {
            $hash[$key] = ''
        }
        else {
            $hash[$key] = $val
        }
    }
    return $hash
}

try {
    $profile = ConvertFrom-FlatYaml -Path $RunProfilePath
}
catch {
    Add-Result -Status FAIL -Check 'yaml-parse' -Detail $_.Exception.Message
    Write-Host ''
    foreach ($r in $results) {
        Write-Host ("{0}  {1}  {2}" -f $r.Status, $r.Check, $r.Detail) -ForegroundColor Red
    }
    Write-Host ''
    Write-Host "Test-AisrafRunProfile: 1 FAIL, 0 PASS (level=$level)" -ForegroundColor Red
    exit 1
}

$requiredFields = @(
    'schema_version', 'package_version', 'run_id', 'sample_id', 'mode',
    'workspace_root', 'input_root', 'expected_root', 'output_root',
    'old_reference_workspace', 'source_ticket_url', 'destination_ticket_url',
    'destination_confluence_url', 'output_destination_mode',
    'postback_execution_status', 'jira_connector_status',
    'confluence_connector_status', 'rovo_mcp_available',
    'mcp_execution_status', 'operator_name', 'reviewer_name',
    'sensitive_data_confirmed_redacted', 'expected_baseline_required',
    'scoring_enabled', 'created_at'
)
$optionalFields = @('notes')
$allowedFields = $requiredFields + $optionalFields

$enums = @{
    mode                          = @('folder_first_test', 'folder_first_review', 'integration_assisted_intake', 'integration_assisted_postback', 'dry_run_revalidation', 'live_reviewer_run')
    output_destination_mode       = @('local_only', 'jira_draft', 'confluence_draft', 'jira_and_confluence_draft', 'external_postback_executed')
    postback_execution_status     = @('deferred', 'formatted_only', 'executed_by_operator', 'not_attempted')
    jira_connector_status         = @('not_required', 'unavailable', 'configured_not_tested', 'available', 'executed_by_operator')
    confluence_connector_status   = @('not_required', 'unavailable', 'configured_not_tested', 'available', 'executed_by_operator')
    mcp_execution_status          = @('not_required', 'unavailable', 'configured_not_tested', 'executed_by_operator')
}

$booleanFields = @('rovo_mcp_available', 'sensitive_data_confirmed_redacted', 'expected_baseline_required', 'scoring_enabled')

# Check 1 — required field presence
$missing = @()
foreach ($f in $requiredFields) {
    if (-not $profile.Contains($f)) { $missing += $f }
}
if ($missing.Count -gt 0) {
    Add-Result -Status FAIL -Check '01-required-fields' -Detail ("Missing required field(s): " + ($missing -join ', '))
}
else {
    Add-Result -Status PASS -Check '01-required-fields' -Detail "All 25 required fields present."
}

# Check 2 — type, enum, constants
$typeFails = @()

$schemaVersion = $profile['schema_version']
if ($schemaVersion -ne 'run_profile.v0_1_2') {
    $typeFails += "schema_version must be 'run_profile.v0_1_2' (got '$schemaVersion')"
}
$packageVersion = $profile['package_version']
if ($packageVersion -ne 'v0.1.2') {
    $typeFails += "package_version must be 'v0.1.2' (got '$packageVersion')"
}
foreach ($f in $booleanFields) {
    if ($profile.Contains($f)) {
        $v = $profile[$f]
        if ($v -isnot [bool]) {
            $typeFails += "$f must be a boolean (got '$v')"
        }
    }
}
foreach ($k in $enums.Keys) {
    if ($profile.Contains($k)) {
        $v = $profile[$k]
        if (-not ($enums[$k] -contains $v)) {
            $typeFails += "$k value '$v' is not in enum (allowed: $($enums[$k] -join ', '))"
        }
    }
}
$nameFields = @('operator_name', 'reviewer_name')
foreach ($f in $nameFields) {
    if ($profile.Contains($f)) {
        $v = $profile[$f]
        if ($v -isnot [string] -or $v.Length -lt 1 -or $v.Length -gt 80) {
            $typeFails += "$f must be a non-empty string of 1-80 chars (got '$v')"
        }
    }
}
if ($profile.Contains('notes')) {
    $n = $profile['notes']
    if ($n -isnot [string]) {
        $typeFails += "notes must be a string"
    }
    elseif ($n.Length -gt 4096) {
        $typeFails += "notes exceeds 4096 chars"
    }
}
if ($typeFails.Count -gt 0) {
    foreach ($t in $typeFails) { Add-Result -Status FAIL -Check '02-type-enum' -Detail $t }
}
else {
    Add-Result -Status PASS -Check '02-type-enum' -Detail "Types, enums, and constants conform."
}

# Check 3 — identifier patterns
$idFails = @()
if ($profile.Contains('run_id')) {
    $rid = $profile['run_id']
    if ($rid -notmatch '^RUN-[A-Z0-9][A-Z0-9-]*$' -or $rid.Length -lt 5 -or $rid.Length -gt 64) {
        $idFails += "run_id '$rid' fails pattern ^RUN-[A-Z0-9][A-Z0-9-]*$ (length 5-64)"
    }
}
if ($profile.Contains('sample_id')) {
    $sid = $profile['sample_id']
    if ($sid -notmatch '^sample-[0-9]{3}[a-z0-9-]*$' -or $sid.Length -lt 11 -or $sid.Length -gt 64) {
        $idFails += "sample_id '$sid' fails pattern ^sample-[0-9]{3}[a-z0-9-]*$ (length 11-64)"
    }
}
if ($profile.Contains('created_at')) {
    $ts = $profile['created_at']
    if ($ts -notmatch '^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$') {
        $idFails += "created_at '$ts' fails ISO 8601 UTC pattern (yyyy-MM-ddTHH:mm:ssZ)"
    }
}
if ($idFails.Count -gt 0) {
    foreach ($t in $idFails) { Add-Result -Status FAIL -Check '03-identifier-patterns' -Detail $t }
}
else {
    Add-Result -Status PASS -Check '03-identifier-patterns' -Detail "run_id, sample_id, and created_at patterns conform."
}

# Check 4 — path resolution
$pathFails = @()
function Test-RelativePath {
    param([string]$Name, [string]$Value, [bool]$AllowEmpty)
    if ($null -eq $Value) {
        return ,"${Name} missing"
    }
    if ($Value -eq '') {
        if ($AllowEmpty) { return @() } else { return ,"${Name} must not be empty" }
    }
    $errs = @()
    if ($Value -match '\\') { $errs += "$Name uses backslash separators" }
    if ($Value -match '^[A-Za-z]:') { $errs += "$Name begins with a drive letter" }
    if ($Value.StartsWith('/')) { $errs += "$Name begins with '/'" }
    if ($Value -match '(^|/)\.\.(/|$)') { $errs += "$Name contains '..'" }
    return $errs
}
if ($profile.Contains('workspace_root')) {
    if ($profile['workspace_root'] -ne '.') {
        $pathFails += "workspace_root must be '.'"
    }
}
$expectedBaselineRequired = $false
if ($profile.Contains('expected_baseline_required')) {
    $expectedBaselineRequired = [bool]$profile['expected_baseline_required']
}
if ($profile.Contains('input_root')) {
    $pathFails += Test-RelativePath -Name 'input_root' -Value $profile['input_root'] -AllowEmpty:$false
}
if ($profile.Contains('expected_root')) {
    $pathFails += Test-RelativePath -Name 'expected_root' -Value $profile['expected_root'] -AllowEmpty:(-not $expectedBaselineRequired)
}
if ($profile.Contains('output_root')) {
    $or = $profile['output_root']
    $pathFails += Test-RelativePath -Name 'output_root' -Value $or -AllowEmpty:$false
    if ($or -notmatch '^runs/RUN-[A-Z0-9][A-Z0-9-]*(/.*)?$') {
        $pathFails += "output_root '$or' must match ^runs/RUN-[A-Z0-9][A-Z0-9-]*(/.*)?$"
    }
    elseif ($profile.Contains('run_id')) {
        $segments = $or -split '/'
        if ($segments.Count -ge 2 -and $segments[1] -ne $profile['run_id']) {
            $pathFails += "output_root run segment '$($segments[1])' does not match run_id '$($profile['run_id'])'"
        }
    }
}
$pathFails = @($pathFails | Where-Object { $_ -ne $null -and $_ -ne '' })
if ($pathFails.Count -gt 0) {
    foreach ($t in $pathFails) { Add-Result -Status FAIL -Check '04-path-resolution' -Detail $t }
}
else {
    Add-Result -Status PASS -Check '04-path-resolution' -Detail "Path fields are relative, forward-slash, and within run_id."
}

# Check 5 — no unknown fields
$unknown = @()
foreach ($k in $profile.Keys) {
    if (-not ($allowedFields -contains $k)) {
        $unknown += $k
    }
}
if ($unknown.Count -gt 0) {
    Add-Result -Status FAIL -Check '05-no-drift-fields' -Detail ("Unknown field(s) not in schema: " + ($unknown -join ', '))
}
else {
    Add-Result -Status PASS -Check '05-no-drift-fields' -Detail "Every field is declared in config/run-profile.schema.yaml."
}

# Check 6 — mode coupling
$modeFails = @()
if ($profile.Contains('mode')) {
    $mode = $profile['mode']
    $folderFirstFamily = @('folder_first_test', 'folder_first_review', 'dry_run_revalidation')
    if ($folderFirstFamily -contains $mode) {
        if ($profile['output_destination_mode'] -ne 'local_only') {
            $modeFails += "mode='$mode' requires output_destination_mode='local_only'"
        }
        if ($profile['postback_execution_status'] -ne 'deferred') {
            $modeFails += "mode='$mode' requires postback_execution_status='deferred'"
        }
        $allowedConn = @('not_required', 'unavailable')
        foreach ($c in @('jira_connector_status', 'confluence_connector_status', 'mcp_execution_status')) {
            if ($profile.Contains($c) -and -not ($allowedConn -contains $profile[$c])) {
                $modeFails += "mode='$mode' requires $c in {not_required, unavailable} (got '$($profile[$c])')"
            }
        }
    }
    if ($mode -eq 'folder_first_test' -or $mode -eq 'folder_first_review') {
        foreach ($u in @('source_ticket_url', 'destination_ticket_url', 'destination_confluence_url')) {
            if ($profile.Contains($u) -and $profile[$u] -ne '') {
                $modeFails += "mode='$mode' requires $u to be empty"
            }
        }
        if ($profile.Contains('rovo_mcp_available') -and [bool]$profile['rovo_mcp_available'] -ne $false) {
            $modeFails += "mode='$mode' requires rovo_mcp_available=false"
        }
    }
    if ($mode -eq 'integration_assisted_intake' -or $mode -eq 'integration_assisted_postback') {
        $hasUrl = ($profile['source_ticket_url'] -ne '') -or ($profile['destination_ticket_url'] -ne '') -or ($profile['destination_confluence_url'] -ne '')
        $hasConnector = ($profile['jira_connector_status'] -ne 'not_required') -or ($profile['confluence_connector_status'] -ne 'not_required') -or ($profile['mcp_execution_status'] -ne 'not_required')
        if (-not ($hasUrl -or $hasConnector)) {
            $modeFails += "mode='$mode' requires at least one URL set or one connector status not 'not_required'"
        }
    }
}
if ($modeFails.Count -gt 0) {
    foreach ($t in $modeFails) { Add-Result -Status FAIL -Check '06-mode-coupling' -Detail $t }
}
else {
    Add-Result -Status PASS -Check '06-mode-coupling' -Detail "Mode coupling rules satisfied."
}

# Check 7 — output destination required URLs
$urlFails = @()
$odm = $profile['output_destination_mode']
if ($odm -eq 'jira_draft' -and $profile['destination_ticket_url'] -eq '') {
    $urlFails += "output_destination_mode='jira_draft' requires destination_ticket_url"
}
if ($odm -eq 'confluence_draft' -and $profile['destination_confluence_url'] -eq '') {
    $urlFails += "output_destination_mode='confluence_draft' requires destination_confluence_url"
}
if ($odm -eq 'jira_and_confluence_draft') {
    if ($profile['destination_ticket_url'] -eq '') { $urlFails += "output_destination_mode='jira_and_confluence_draft' requires destination_ticket_url" }
    if ($profile['destination_confluence_url'] -eq '') { $urlFails += "output_destination_mode='jira_and_confluence_draft' requires destination_confluence_url" }
}
if ($odm -eq 'external_postback_executed') {
    if ($profile['destination_ticket_url'] -eq '' -and $profile['destination_confluence_url'] -eq '') {
        $urlFails += "output_destination_mode='external_postback_executed' requires at least one destination URL"
    }
}
foreach ($u in @('source_ticket_url', 'destination_ticket_url', 'destination_confluence_url')) {
    if ($profile.Contains($u)) {
        $v = $profile[$u]
        if ($v -ne '' -and $v -notmatch '^https://[^?#\s]+$') {
            $urlFails += "$u must be empty or an https URL without query, fragment, or whitespace (got '$v')"
        }
    }
}
if ($urlFails.Count -gt 0) {
    foreach ($t in $urlFails) { Add-Result -Status FAIL -Check '07-destination-urls' -Detail $t }
}
else {
    Add-Result -Status PASS -Check '07-destination-urls' -Detail "Destination URL coupling satisfied."
}

# Check 8 — post-back honesty
$postFails = @()
$pbs = $profile['postback_execution_status']
if ($odm -eq 'external_postback_executed' -and $pbs -ne 'executed_by_operator') {
    $postFails += "output_destination_mode='external_postback_executed' requires postback_execution_status='executed_by_operator'"
}
if ($pbs -eq 'executed_by_operator' -and $odm -ne 'external_postback_executed') {
    $postFails += "postback_execution_status='executed_by_operator' requires output_destination_mode='external_postback_executed'"
}
if ($postFails.Count -gt 0) {
    foreach ($t in $postFails) { Add-Result -Status FAIL -Check '08-post-back-honesty' -Detail $t }
}
else {
    Add-Result -Status PASS -Check '08-post-back-honesty' -Detail "Post-back biconditional satisfied."
}

# Check 9 — connector and MCP honesty
$connFails = @()
if ($profile['jira_connector_status'] -eq 'executed_by_operator') {
    if ($pbs -ne 'executed_by_operator') {
        $connFails += "jira_connector_status='executed_by_operator' requires postback_execution_status='executed_by_operator'"
    }
    if ($profile['destination_ticket_url'] -eq '') {
        $connFails += "jira_connector_status='executed_by_operator' requires destination_ticket_url"
    }
}
if ($profile['confluence_connector_status'] -eq 'executed_by_operator') {
    if ($pbs -ne 'executed_by_operator') {
        $connFails += "confluence_connector_status='executed_by_operator' requires postback_execution_status='executed_by_operator'"
    }
    if ($profile['destination_confluence_url'] -eq '') {
        $connFails += "confluence_connector_status='executed_by_operator' requires destination_confluence_url"
    }
}
if ($connFails.Count -gt 0) {
    foreach ($t in $connFails) { Add-Result -Status FAIL -Check '09-connector-honesty' -Detail $t }
}
else {
    Add-Result -Status PASS -Check '09-connector-honesty' -Detail "Connector and MCP honesty rules satisfied."
}

# Check 10 — expected baseline / scoring coupling
$scoreFails = @()
$scoring = $false
if ($profile.Contains('scoring_enabled')) { $scoring = [bool]$profile['scoring_enabled'] }
$baseline = $false
if ($profile.Contains('expected_baseline_required')) { $baseline = [bool]$profile['expected_baseline_required'] }
$expectedRoot = $profile['expected_root']
if ($scoring -and -not $baseline) {
    $scoreFails += "scoring_enabled=true requires expected_baseline_required=true"
}
if ($scoring -and $expectedRoot -eq '') {
    $scoreFails += "scoring_enabled=true requires non-empty expected_root"
}
if ($baseline -and $expectedRoot -eq '') {
    $scoreFails += "expected_baseline_required=true requires non-empty expected_root"
}
if ($scoreFails.Count -gt 0) {
    foreach ($t in $scoreFails) { Add-Result -Status FAIL -Check '10-scoring-coupling' -Detail $t }
}
else {
    Add-Result -Status PASS -Check '10-scoring-coupling' -Detail "Expected-baseline and scoring coupling satisfied."
}

# Check 11 — sensitive-data screening on every string value
$sensitivePatterns = @(
    @{ Name = 'Bearer prefix';            Pattern = 'Bearer\s' }
    @{ Name = 'Authorization header';     Pattern = '(?i)Authorization\s*:' }
    @{ Name = 'x-api-key header';         Pattern = '(?i)x-api-key\s*:' }
    @{ Name = 'token query param';        Pattern = '[?&]token=' }
    @{ Name = 'api_key query param';      Pattern = '(?i)[?&]api[_-]?key=' }
    @{ Name = 'password query param';     Pattern = '[?&]password=' }
    @{ Name = 'access_token query param'; Pattern = '[?&]access_token=' }
    @{ Name = 'RSA private key';          Pattern = 'BEGIN RSA PRIVATE KEY' }
    @{ Name = 'OpenSSH private key';      Pattern = 'BEGIN OPENSSH PRIVATE KEY' }
    @{ Name = 'EC private key';           Pattern = 'BEGIN EC PRIVATE KEY' }
    @{ Name = 'PAN-like 16-digit run';    Pattern = '(?<!\d)\d{16}(?!\d)' }
    @{ Name = 'SSN-like XXX-XX-XXXX';     Pattern = '\b\d{3}-\d{2}-\d{4}\b' }
)
$sensitiveHits = @()
foreach ($k in $profile.Keys) {
    $v = $profile[$k]
    if ($v -isnot [string]) { continue }
    if ($v -eq '') { continue }
    foreach ($p in $sensitivePatterns) {
        if ($v -match $p.Pattern) {
            $sensitiveHits += "$k matches '$($p.Name)'"
        }
    }
}
if ($sensitiveHits.Count -gt 0) {
    foreach ($t in $sensitiveHits) { Add-Result -Status FAIL -Check '11-sensitive-data-screen' -Detail $t }
}
else {
    Add-Result -Status PASS -Check '11-sensitive-data-screen' -Detail "No prohibited substrings detected in string fields."
}

# Check 12 — sensitive-data confirmation (ExecutionReady only)
if ($level -eq 'ExecutionReady') {
    $confirmed = $false
    if ($profile.Contains('sensitive_data_confirmed_redacted')) {
        $confirmed = [bool]$profile['sensitive_data_confirmed_redacted']
    }
    if ($confirmed -ne $true) {
        Add-Result -Status FAIL -Check '12-sensitive-data-confirmed' -Detail "ExecutionReady requires sensitive_data_confirmed_redacted=true"
    }
    else {
        Add-Result -Status PASS -Check '12-sensitive-data-confirmed' -Detail "Operator has confirmed sensitive-data redaction."
    }
}
else {
    Add-Result -Status PASS -Check '12-sensitive-data-confirmed' -Detail "Skipped under -ProfileShape (default level)."
}

# Print results
Write-Host ''
Write-Host "Test-AisrafRunProfile  level=$level  profile=$RunProfilePath" -ForegroundColor Cyan
Write-Host ''
foreach ($r in $results) {
    $color = if ($r.Status -eq 'PASS') { 'Green' } else { 'Red' }
    Write-Host ("{0,-5}  {1,-30}  {2}" -f $r.Status, $r.Check, $r.Detail) -ForegroundColor $color
}
$failCount = @($results | Where-Object { $_.Status -eq 'FAIL' }).Count
$passCount = @($results | Where-Object { $_.Status -eq 'PASS' }).Count
Write-Host ''
if ($failCount -eq 0) {
    Write-Host "Test-AisrafRunProfile: $passCount PASS, 0 FAIL (level=$level)" -ForegroundColor Green
    exit 0
}
else {
    Write-Host "Test-AisrafRunProfile: $passCount PASS, $failCount FAIL (level=$level)" -ForegroundColor Red
    exit 1
}
