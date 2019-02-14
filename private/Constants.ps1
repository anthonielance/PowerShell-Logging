$Script:LogFile = $null
$Script:LogEntryTemplate = "{DATETIME} |-{LEVEL} [{MACHINE}:{USER}] [{FILE}:{LINE}] | {MESSAGE}"
$Script:Levels = @{
  Verbose     = "VBS"
  Debug       = "DBG"
  Information = "INF"
  Warning     = "WRN"
  Error       = "ERR"
  Fatal       = "FTL"
}