@echo off
set LUOGO=%~dp0
cd /d "%LUOGO%\.."
cd
copy /y LoadAass.properties LoadAass_properties.bak > nul
@echo .
@echo Setta il file di propertie al seguente DB
@echo 1 - SQL Server
@echo 2 - SQLite

set /P TIPO="Dammi il tipo: "
if "%TIPO%" == "1" goto sqlsrvr
if "%TIPO%" == "2" goto sqlit
@echo non hai specificato ona opzione valida (%TIPO%)
goto fine

:sqlsrvr
@echo.
@echo setto      S Q L S e r v e r
copy /y LoadAass_SQLServer.properties LoadAass.properties
goto fine

:sqlit
@echo.
@echo setto      S Q L i t e 
copy /y LoadAass_SQLite.properties LoadAass.properties
goto fine

:boh

:fine