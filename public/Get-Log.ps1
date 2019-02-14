function Get-Log {
  param(
    [Parameter(Mandatory)]
    [ValidateScript({
      Test-Path -Path $_
    })]
    [string]$Path,

    [Parameter()]
    [string]$LogEntryTemplate = $Script:LogEntryTemplate
  )

  $Script:LogFile = $Path
  if ($LogEntryTemplate){
    $Script:LogEntryTemplate = $LogEntryTemplate
  }
}