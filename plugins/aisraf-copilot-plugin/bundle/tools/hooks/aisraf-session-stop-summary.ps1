[CmdletBinding()]
param(
    [string]$WrapperId = 'unknown',
    [string[]]$InputsRead = @(),
    [string[]]$OutputsWritten = @(),
    [string[]]$ValidatorsInvoked = @(),
    [string[]]$StopConditionsHit = @(),
    [string]$Status = 'SUMMARY'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Format-ListValue {
    param([string[]]$Values)
    if ($null -eq $Values -or $Values.Count -eq 0) { return 'none' }
    return ($Values | Where-Object { $_.Trim().Length -ne 0 } | Sort-Object -Unique) -join '; '
}

Write-Output "SUMMARY aisraf-session-stop-summary"
Write-Output "wrapper_id: $WrapperId"
Write-Output "status: $Status"
Write-Output "inputs_read: $(Format-ListValue -Values $InputsRead)"
Write-Output "outputs_written: $(Format-ListValue -Values $OutputsWritten)"
Write-Output "validators_invoked: $(Format-ListValue -Values $ValidatorsInvoked)"
Write-Output "stop_conditions_hit: $(Format-ListValue -Values $StopConditionsHit)"
