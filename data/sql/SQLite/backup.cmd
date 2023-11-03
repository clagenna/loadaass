set DT=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
set DT=%DT: =0%
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
set fil=SQLaass_%DT%.bak
sqlite3.exe SQLaass ".backup %fil%"
dir %fil%


:fine