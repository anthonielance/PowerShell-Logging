# Get public and private function definition files.
$Public = Get-ChildItem $PSScriptRoot\Public\*.ps1
$Private = Get-ChildItem $PSScriptRoot\Private\*.ps1
$FilesToLoad = $Public + $Private

# Dot source the files
# Thanks to Bartek, Constatine
# https://becomelotr.wordpress.com/2017/02/13/expensive-dot-sourcing/
foreach($file in $filesToLoad)
{
    try
    {
        if($DebugMode)
        {
            . $File.Fullname
        }
        else
        {
            . (
                [scriptblock]::Create(
                    [io.file]::ReadAllText($File.Fullname,[Text.Encoding]::UTF8)
                )
            )
        }
    }
    catch
    {
        Write-Error -Message "Failed to import function $($File.FullName)"
        Write-Error $_
    }
}