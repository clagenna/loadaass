:: -----------------------------------------------
:: mi sposto nel direttorio di lancio
for %%a in ( %0 ) do set curr=%%~dpa
set curr=%curr:~,-1%
cd /d "%curr%"

:: -----------------------------------------------
:: settaggi iniziali
set DBFILE=SQLaass.sqlite3
set DT=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
set DT=%DT: =0%
set filOUT=SQLaass_schema_%DT%.sql

:: -----------------------------------------------
:: alla ricerca di SQLite
where sqlite4.exe
set RES1=%ERRORLEVEL%
if "%RES1%" equ "0" goto litok

set PATH=C:\Program Files\SQLiteStudio;%PATH%
where sqlite3.exe
set RES2=%ERRORLEVEL%
if "%RES2%" equ "0" goto litok

@echo non ho il path per SQLITE3.EXE
goto fine

:litok
:: -----------------------------------------------
:: Lascio solo l'ultimo schema con desinenza .sql
if not exist SQLaass_schema*.sql goto litok2
forfiles /P . /M SQLaass_schema*.sql /C "cmd /c ren @fname.sql @fname.bak"

:: -----------------------------------------------
:: alla ricerca di SQLite
:litok2
sqlite3.exe %DBFILE% ".schema" > %filOUT%
dir %filOUT%


:fine