$compress = @{
  LiteralPath="LoadAass.properties","target\LoadAass-jar-with-dependencies.jar","lancia.cmd","readme_it.md"
  CompressionLevel="Optimal"
  DestinationPath="LoadAass.zip"
}

Set-Location (Split-Path $PSCommandPath)
Set-Location ".."

New-Item -ItemType Directory -Force -Path "xzip"
# Copy-Item .\LoadAass.properties -Destination "xzip\LoadAass.properties" -Force
# (Get-Content -Path .\LoadAass.properties) -replace "DB.name=data/sql/SQLite/","DB.name=" | Set-Content -Path "xzip\LoadAass.properties" -Encoding utf8
$props = @"
DB.Host=localhost
DB.Type=SQLite3
DB.name=SQLaass.sqlite3
DB.passwd=none
DB.service=1433
DB.user=none
frame.dimx=742
frame.dimy=589
frame.posx=709
frame.posy=17
intestatario=claudio
last.dir=C\:\\Temp
logLevel=INFO
resview.lx=1021
resview.ly=1039
resview.splitpos=0.2850
resview.x=1369
resview.y=178
splitpos=0.5036
"@
$props | Set-Content -Path "xzip\LoadAass.properties" -Encoding utf8
Copy-Item .\target\LoadAass-jar-with-dependencies.jar -Destination "xzip\LoadAass.jar" -Force
Copy-Item .\lancia.cmd -Destination "xzip\lancia.cmd"
Copy-Item .\data\settaEnvJava.ps1 -Destination "xzip\settaEnvJava.ps1"
Copy-Item .\data\sql\SQLite\SQLaass.sqlite3 -Destination "xzip\SQLaass.sqlite3"
Copy-Item .\readme_it.md -Destination "xzip\readme_it.md"

if ( (Test-Path "LoadAass.zip" )) {
  Remove-Item -Path "LoadAass.zip" -Force
}

Compress-Archive -Path "xzip\*.*" -DestinationPath "LoadAass.zip" -CompressionLevel Optimal

Remove-Item -Path "xzip" -Recurse -Force

