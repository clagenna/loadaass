rem @echo off
set APP=loadaass
java -version 
set aa=%errorlevel%
if %aa% equ 0 goto okjava
@echo.
@echo Non trovo Java installato !!!
@echo.
@echo Prova a visitare il sito (per java 16):
@echo   https://www.oracle.com/java/technologies/javase-jdk16-downloads.html
pause
goto fine

:okjava
set JFX=--module-path "%JAVAFX_HOME%/lib" --add-modules=javafx.controls,javafx.graphics,javafx.fxml

set ESEG=%APP%-jar-with-dependencies.jar
if exist "%ESEG%" goto lancia
set ESEG=%APP%.jar
if exist "%ESEG%" goto lancia
set ESEG=target\%APP%-jar-with-dependencies.jar
if exist "%ESEG%" goto lancia
set ESEG=%APP%.jar
if exist "%ESEG%" goto lancia
@echo .
@echo Cannot find JAR to launch
goto fine

:lancia
java %JFX% -jar "%ESEG%"

:fine
