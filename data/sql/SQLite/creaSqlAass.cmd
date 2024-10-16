@if not defined DEBUG set DEBUG=0
@if %DEBUG% equ 0 echo off

:: -----------------------------------------------
:: mi sposto nel direttorio di lancio
for %%a in ( %0 ) do set curr=%%~dpa
set curr=%curr:~,-1%
cd /d "%curr%"
if %DEBUG% GEQ 1 pause

:: -----------------------------------------------
:: settaggi iniziali
if "%1" == "" (
  set DBFILE=SQLAass_Base.sqlite3
  ) else (
  set DBFILE=%1
  )
@echo Creazione del DB [93m %DBFILE% [0m

:: -----------------------------------------------
:: alla ricerca di SQLite
where sqlite4.exe 2>nul >nul
set RES1=%ERRORLEVEL%
if "%RES1%" equ "0" goto litok

set PATH=C:\Program Files\SQLiteStudio;%PATH%
where sqlite3.exe 2>nul >nul
set RES2=%ERRORLEVEL%
if "%RES2%" equ "0" goto litok

@echo non ho il path per SQLITE3.EXE
goto fine

:litok
:: -----------------------------------------------
:: istanzio nuovo DB di base (vuoto)
if %DEBUG% GEQ 1 echo type SQLaass_Schema.sql -PIPE-  sqlite3 %DBFILE%
if %DEBUG% GEQ 1 pause

if exist %DBFILE% del %DBFILE%
type SQLaass_Schema.sql |sqlite3 %DBFILE%
@echo .
@echo creato DB su file [92m %DBFILE% [0m 
@echo .
dir %DBFILE%

:fine
if %DEBUG% GEQ 1 pause
