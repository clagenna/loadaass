@echo on
if "%1" equ "-a" goto dopo 
set argC=0
for %%x in (%*) do Set /A argC+=1
set DIRL=F:\Google Drive\SMichele\AASS
set TIPO=GAS
if %ARGC% equ 1 set TIPO=%1
echo qta args = %argC% and Tipo=%TIPO%

rem ---------------------------------------------------------
for /F "delims=" %%i in ( 'dir /s /b %0' ) do set FCMD=%%i
@echo il for dopo
for /F "delims=" %%i in ( 'dir /s /b "%DIRL%\%TIPO%*.pdf"' ) do call "%FCMD%" -a %%i
goto fine

:Trim
SetLocal EnableDelayedExpansion
set Params=%*
for /f "tokens=1*" %%a in ("!Params!") do EndLocal & set %1=%%b
exit /b

:dopo
@echo on
shift
SetLocal EnableDelayedExpansion
set fila=%1 %2 %3 %4
call :Trim filb !fila!
echo dopo Trim  "%filb%"
java -jar target\loadass-jar-with-dependencies.jar -f "%filb%" -lv debug
rem pause
@echo off
goto fine



:fine