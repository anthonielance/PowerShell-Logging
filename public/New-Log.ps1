function New-Log {
  param(
    [Parameter(Mandatory)]
    [string]$Path,

    [Parameter()]
    [string]$LogEntryTemplate = $Script:LogEntryTemplate,

    [Parameter()]
    [switch]$Force
  )

  $newLogParams = @{
    Path  = $Path
    Force = $Force
  }
  New-Item @newLogParams

  $Script:LogFile = $Path
  if ($LogEntryTemplate){
    $Script:LogEntryTemplate = $LogEntryTemplate
  }
}