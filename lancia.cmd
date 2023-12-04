@echo off
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
set JAREXE=loadaass-jar-with-dependencies.jar
if exist "%JAREXE%" goto lancia
set JAREXE=loadaass.jar
if exist "%JAREXE%" goto lancia
set JAREXE=target\loadass-jar-with-dependencies.jar
if exist "%JAREXE%" goto lancia
set JAREXE=loadaass.jar
if exist "%JAREXE%" goto lancia
@echo .
@echo Cannot find JAR to launch
goto fine

:lancia
set MODPATH=C:\Program Files\java\javafx-sdk-20.0.1\lib
set MODS=javafx.controls
set MODS=%MODS%,javafx.base
set MODS=%MODS%,javafx.fxml
set MODS=%MODS%,javafx.graphics
rem set MODS=%MODS%,javafx.media

java --module-path "%MODPATH%" --add-modules="%MODS%" -jar "%JAREXE%"

rem java -jar "%JAREXE%"

:fine
