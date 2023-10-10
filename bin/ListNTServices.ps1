 # Per vedere i Nomi dei User NT service (nascosti)
 # ! Lanciare con privilegi alti !
 get-service | foreach {Write-Host NT Service\$($_.Name)}