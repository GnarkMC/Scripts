@echo off

:: User-configurable options
set BASE_NAME=velocity-3.3.0-SNAPSHOT-
set HEAP_SIZE=4096

:: Build Java options string
set JAVA_OPTS=-Xms%HEAP_SIZE%M ^
-Xmx%HEAP_SIZE%M ^
-XX:+UseG1GC ^
-XX:G1HeapRegionSize=4M ^
-XX:+UnlockExperimentalVMOptions ^
-XX:+ParallelRefProcEnabled ^
-XX:+AlwaysPreTouch ^
-XX:MaxInlineLevel=15

:: Find the JAR file with the highest version number
for /f "tokens=*" %%F in ('dir /b /o:N %BASE_NAME%*.jar 2^>nul') do set NAME=%%F

:: Check if JAR file was found
if defined NAME (
    echo Using JAR file: %NAME%
    java %JAVA_OPTS% -jar "%NAME%"
) else (
    echo No relevant JAR file found.
    exit /b 1
)
