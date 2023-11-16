@echo off
:: -----------------------------------------------
:: mi sposto nel direttorio di lancio
for %%a in ( %0 ) do set curr=%%~dpa
set curr=%curr:~,-1%
cd /d "%curr%"

:: -----------------------------------------------
:: settaggi iniziali 
set DBFILNAM=SQLaassNEW.sqlite3
set FILREST=SQLaass_backup_2023-11-16_16-00-38.bak
set SQLITE=C:\Program Files\SQLiteStudio\sqlite3.exe


if "%1" == "" (
  set /P FILREST="Nome File per il restore:"
) else (
  set FILREST=%1
)
if exist "%FILREST%" goto dorest
@echo non esiste il file %FILREST%
goto fine

:dorest
@echo on
rem "%SQLITE%" %DBFILNAM% #  "%FILREST%"
"%SQLITE%" %DBFILNAM% < "%FILREST%"
:fine 