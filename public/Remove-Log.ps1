function Remove-Log {
  if($Script:LogFile){
    Remove-Item -Path $Script:LogFile
    Remove-Variable -Scope Script -Name LogFile
  }
}