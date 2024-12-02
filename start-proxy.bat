@echo off

:: User-configurable options
set BASE_PREFIX=velocity-3.3.0-SNAPSHOT
set HEAP_SIZE=4096

:: Java command-line options (one per line)
set JAVA_OPTS=^
-Xms%HEAP_SIZE%M ^
-Xmx%HEAP_SIZE%M ^
-XX:+UseG1GC ^
-XX:G1HeapRegionSize=4M ^
-XX:+UnlockExperimentalVMOptions ^
-XX:+ParallelRefProcEnabled ^
-XX:+AlwaysPreTouch ^
-XX:MaxInlineLevel=15

:: Find the JAR file with the highest version number
set "highest_num=0"
set "highest_jar="
for /f "tokens=*" %%F in ('dir /b %BASE_PREFIX%*.jar 2^>nul') do (
    set "filename=%%F"
    set "version=!filename:%BASE_PREFIX%-=!"
    set "version=!version:.jar=!"
    if !version! gtr !highest_num! (
        set "highest_num=!version!"
        set "highest_jar=%%F"
    )
)

setlocal EnableDelayedExpansion
if defined highest_jar (
    echo Using JAR file: !highest_jar!
    java %JAVA_OPTS% -jar "!highest_jar!"
) else (
    echo No relevant JAR file found.
    exit /b 1
)

pause
