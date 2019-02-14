# Log Level Codes
# Verbose: VBS
# Debug: DBG
# Information: INF
# Warning: WRN
# Error: ERR
# Fatal: FTL

function Write-Log {
  param(
    [Parameter(Mandatory)]
    [ValidateSet("Verbose", "Debug", "Information", "Warning", "Error", "Fatal")]
    [string]$Level,

    [Parameter(Mandatory, ParameterSetName = "Message")]
    [string]$Message,

    [Parameter(Mandatory, ParameterSetName = "Exception")]
    [Exception]$Exception
  )

  begin {
    if ($null -eq $Script:LogFile) {
      Write-Warning "No log file found. Please create log first."
      break
    }

    $PSBoundParameters.Add("DateTime", [DateTime]::Now.ToString("yyyy-MM-dd HH:mm:SS.FFF zzz"))
    $PSBoundParameters.Add("Machine", $ENV:COMPUTERNAME)
    $PSBoundParameters.Add("User", "$ENV:USERDOMAIN\$ENV:USERNAME")
    $PSBoundParameters.Add("File", $MyInvocation.ScriptName)
    $PSBoundParameters.Add("Line", $MyInvocation.ScriptLineNumber)
  }

  process {
    if ($PSCmdlet.ParameterSetName -eq "Exception"){
      $exp = $Exception
      $PSBoundParameters.Remove("Exception")
      $msg = "$($exp.Message)`n$($exp.StackTrace)"
      $PSBoundParameters.Add("Message", $msg)
    }

    $entry = $Script:LogEntryTemplate
    foreach ($arg in $PSBoundParameters.GetEnumerator()) {
      if ($arg.Key -eq "Level") {
        $entry = $entry -replace "{$($arg.Key.ToUpper())}", $Script:Levels[$arg.Value]
        continue
      }
      $entry = $entry -replace "{$($arg.Key.ToUpper())}", $arg.Value
    }
    
    Add-Content -Path $Script:LogFile -Value $entry
  }
}