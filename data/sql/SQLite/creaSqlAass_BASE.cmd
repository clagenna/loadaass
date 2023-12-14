:: -----------------------------------------------
:: mi sposto nel direttorio di lancio
for %%a in ( %0 ) do set curr=%%~dpa
set curr=%curr:~,-1%
cd /d "%curr%"

:: -----------------------------------------------
:: settaggi iniziali
set DBFILE=SQLAass_Base.sqlite3

:: -----------------------------------------------
:: istanzio nuovo DB di base (vuoto)
if exist %DBFILE% del %DBFILE%
type SQLaass_BASE.sql |sqlite3 %DBFILE%
 
