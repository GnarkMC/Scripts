@echo off

:: User-configurable options
set BASE_NAME=paper-1.21.3-74
set HEAP_SIZE=16384

:: Java command-line options (one per line)
set JAVA_OPTS=^
-Xms%HEAP_SIZE%M ^
-Xmx%HEAP_SIZE%M ^
-DPaper.IgnoreJavaVersion=true

:: Find the JAR file with the highest version number
for /f "tokens=*" %%F in ('dir /b /o:n %BASE_NAME%*.jar 2^>nul') do set "NAME=%%F"

if defined NAME (
    echo Using JAR file: %NAME%
    java %JAVA_OPTS% -jar "%NAME%" --nogui
) else (
    echo No relevant JAR file found.
    exit /b 1
)

pause
