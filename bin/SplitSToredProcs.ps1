Set-StrictMode -Version 2.0
$SplDirs = "F:\java\photon2\loadaass\data\sql\spl"
$SqlPrfx = "SPL"
$SqlFile = "F:\java\photon2\loadaass\data\sql\SQLServer\AASS_db7.sql"
#$SqlFile = "F:\java\photon2\loadaass\data\sql\SQLite\SQLaass_backup_2023-11-16_16-00-38.bak"

if ( ! (Test-Path -Path $SplDirs)) {
   New-Item -ItemType Directory -Path $SplDirs 
}

enum Lavoro {
    Scarta
    InizioSQL
    ContinuaSQL
    FineSQL
}
$viewName=$null
$cont=""
$fase = [Lavoro]::Scarta
Get-Content $SqlFile | ForEach-Object {
    $Riga=$_
    do {
        switch ($fase) {
            Scarta {
                if ( $Riga -match '^CREATE VIEW*') {
                    $fase=[Lavoro]::InizioSQL
                }
            }
            InizioSQL {
                $viewName = $riga -replace "CREATE VIEW","" 
                if ( $Riga -match ' AS ' -or $Riga -match " AS$") {
                    $n = $viewName.IndexOf(" AS")
                    if ( $n -gt 0) {
                        $viewName = $viewName.Substring(0, $n)
                    }
                    $viewName=$viewName.Trim()
                } elseif ( $viewName -match '\.') {
                    $arr = $viewName.Split(".")
                    $viewName = $arr[1].Replace("[","").Replace("]","")
                } else {
                    Write-Host ("Non interpreto: {0}" -f $Riga)
                    $fase=[Lavoro]::Scarta
                }
                $cont = $Riga  + "`n"
                $fase=[Lavoro]::ContinuaSQL
            }
            ContinuaSQL {
                $cont += $Riga + "`n"
                if ( $Riga -match '^GO') {
                    $fase=[Lavoro]::FineSQL
                }
                if ( $Riga -match ';') {
                    $fase=[Lavoro]::FineSQL
                }
            }
            FineSQL {
                $sqlfil = "{0}\{1}_{2}.sql" -f $SplDirs,$SqlPrfx,$viewName
                $cont | Out-File -FilePath $sqlfil -Encoding ascii  -Force              
                Write-Host ("Scritto proc {0}" -f $viewName)
                $viewName=$null
                $cont=""
                $fase=[Lavoro]::Scarta
            }
        }
    } while ($fase -in ([Lavoro]::InizioSQL,[Lavoro]::FineSQL));
}