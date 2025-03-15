Set-Location "D:\winapp\app\LoadAASS"
$AppName = "LoadAASS"

$props = ConvertFrom-StringData ( Get-Content -Path "${AppName}.properties" -raw )
$props["DB.name"]="${AppName}.db"
$props.getEnumerator() | 
    ForEach-Object {  "$($_.name)=$($_.Value)" } | 
    Sort-Object | 
    Set-Content -Path "${AppName}_1.properties" -encoding UTF-8
