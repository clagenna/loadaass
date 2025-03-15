Set-Location (Split-Path $PSCommandPath)
Set-Location ".."
Get-Location

$AppName = "LoadAASS"
$zipFile = "${AppName}.zip"

$Mvn = ${Env:\MAVEN_HOME}
if ( $null -eq $Mvn) {
  $Mvn = ${Env:\MVN_HOME}
}
if ( $null -eq $Mvn) {
  Write-host  "Manca la Var Ambiente MAVEN_HOME/MVN_HOME!" -ForegroundColor Red
  exit 1957
}
$mvnCmd = "{0}\bin\mvn.cmd" -f ${Mvn}

if ( Test-Path $zipFile ) {
  Remove-Item -Path $zipFile
}

Start-Process -Wait -FilePath $mvnCmd -ArgumentList 'clean','package'

$allFiles = @()
$allFiles += ".\bin\${AppName}.cmd"
$allFiles += "${AppName}.properties"
$allFiles += "README.md"
$allFiles += "README_it.md"
$allFiles += "target\${AppName}.jar"
$allFiles += ".\bin\installApp.ps1"
$allFiles += ".\data\Sql\SQLite\${AppName}Nuovo.db"
# Get-ChildItem -path ".\bin\${AppName}.cmd", "${AppName}.properties", "target\${AppName}.jar", ".\bin\installApp.ps1", ".\data\Sql\SQLite\${AppName}Nuovo.db"   |
Get-ChildItem -Path $allFiles | Compress-Archive  -CompressionLevel Fastest -DestinationPath $zipFile

