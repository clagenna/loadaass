
@if not defined DEBUG set DEBUG=0
@if %DEBUG% equ 0 echo off

:: -----------------------------------------------
:: mi sposto sul dir di lancio
for %%i in ( "%0" )      do set BASE=%%~dpi
for %%i in ( "%BASE%" )  do set BASE=%%~fi
@if %DEBUG% GEQ 1 echo Base dir = %BASE%

:: -----------------------------------------------
:: settaggi iniziali
set DT=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
set DT=%DT: =0%

if "%1" == "?" goto usage
if "%1" == "" goto usage
if not "%1" == "" ( 
  set DBNAME=%1
  shift 
  )
set SERV=localhost
if not "%1" == "" ( 
  set SERV=%1
  shift 
  )

set CPFLASH=1
set DBTMP=C:\temp
set DBTMP2=%DBTMP::=$%
set SQLFIL=%DBTMP%\BackupDB_%DBNAME%.sql
set FILBAK=%DBNAME%_%DT%_db.sav
set ZIPFIL=%DBNAME%_%DT%.zip

call :findsql
call :findwzip
@echo.
@echo      salvo DB  [32m %DBNAME%  [0m 
@echo     dal server [32m %SERV%  [0m
@echo nel direttorio [32m %BASE%  [0m
@echo       col nome [32m %FILBAK% [0m
@echo.
if %DEBUG% GEQ 1 pause

echo BACKUP DATABASE [%DBNAME%] > %SQLFIL%
echo  TO  DISK = N'%DBTMP%\%FILBAK%' >> %SQLFIL%
echo    WITH NOFORMAT, INIT,  SKIP, NOREWIND, NOUNLOAD, >> %SQLFIL%
echo    DESCRIPTION = 'Backup da stream BackupDB.cmd',  STATS = 10 >> %SQLFIL%
echo GO  >> %SQLFIL%
if %DEBUG% GEQ 1 more %SQLFIL%
if %DEBUG% GEQ 1 pause

:backuppa
"%SQLCMD%" -S %SERV% -E -i %SQLFIL%
set retv=%ERRORLEVEL%
if not exist "%DBTMP%\%FILBAK%" goto nobackup

if %DEBUG% GEQ 1 pause

if "%SERV%" == "localhost" goto zippa
  
rem copia dal server 
  xcopy /y "\\%SERV%\%DBTMP2%\%FILBAK%" %BASE%
  del "\\%SERV%\%DBTMP2%\%FILBAK%"

:zippa

"%WZZIP%" %WZZIPPARM% "%ZIPFIL%" "%DBTMP%\%FILBAK%"
dir "%ZIPFIL%" | findstr /i "%DBNAME%"
@if %DEBUG% GEQ 1 pause

if %CPFLASH% equ 0 goto fine


rem cerco la chiavetta USB che contiene il file civetta toFlash.cmd
set fla=#
for %%i in (d e f g h i j k l m n o p q r s t u v w x y z) do if exist %%i:\toflash.cmd set fla=%%i
if "%fla%" == "#" goto fine
echo Flash Disk = %fla%

@echo Copio il backup [32m%DBNAME%_%DT%.zip[0m su l'unita [32m%fla%:\[0m
xcopy /y "%BASE%\%DBNAME%_%DT%.zip" %fla%:
if errorlevel 1 goto fine

goto fine


:nobackup
@echo.
@echo [31m ERRORE [0m Non sono riuscito a fare il backup %DBTMP%\%FILBAK%
goto fine




------------------------------------------------------------------------------
cerca il comando sqlcmd per il backup
------------------------------------------------------------------------------
:findsql
if %DEBUG% GEQ 1 @echo on

for /f "usebackq delims=+ tokens=*" %%i in ( `where sqlcmd.exe` ) do SET SQLCMD=%%i
if exist "%SQLCMD%" goto :eof

set SQLCMD=C:\Program Files\Microsoft SQL Server\90\Tools\Binn\sqlcmd.exe
if exist "%SQLCMD%" goto :eof

set SQLCMD=C:\Programmi\Microsoft SQL Server\90\Tools\binn\sqlcmd.exe
if exist "%SQLCMD%" goto :eof

set SQLCMD=C:\Microsoft\SQL Server 2005\90\Tools\Binn\SQLCMD.EXE
if exist "%SQLCMD%" goto :eof

set SQLCMD=C:\Program Files\Microsoft SQL Server\100\Tools\Binn\SQLCMD.EXE
if exist "%SQLCMD%" goto :eof

set SQLCMD=C:\microsoft\SQL Server 2008\100\Tools\Binn\SQLCMD.EXE
if exist "%SQLCMD%" goto :eof

set SQLCMD=C:\Microsoft\SQL Server\100\Tools\Binn\SQLCMD.EXE
if exist "%SQLCMD%" goto :eof

echo non trovo Tools\binn\sqlcmd.exe !!!!
pause
goto fine
------------------------------------------------------------------------------






------------------------------------------------------------------------------
cerca wzzip.exe
------------------------------------------------------------------------------
:findwzip
set WZZIP=c:\WinApp\util\WinZip\wzzip.exe
set WZZIPPARM=-a -m
if exist "%WZZIP%" goto :eof

set WZZIP=C:\Program Files (x86)\WinZip\WZZIP.EXE
if exist "%WZZIP%" goto :eof

if not "%WZIP_HOME%" == "" set WZZIP=%WZIP_HOME%\wzzip.exe
if exist "%WZZIP%" goto :eof

rem provo 7zip
set WZZIP=%ProgramFiles%\7-Zip\7z.exe
set WZZIPPARM=a -sdel
if exist "%WZZIP%" goto :eof

echo non trovo WZZIP.EXE !!!!
echo imposta la var di ambiente WZIP_HOME
pause
goto fine




------------------------------------------------------------------------------
Usage
------------------------------------------------------------------------------
:usage
echo stream generica per salvare DB 
echo usage: %0 DBNAME [SERVER=localhost]
goto fine








:nocp
:fine