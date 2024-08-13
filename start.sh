#!/bin/bash | https://github.com/MithrilMC/Scripts/blob/main/start.sh

# Search for the latest Purpur or Velocity JAR file
latest_purpur=$(ls purpur-1.21.1-*.jar | sort -V | tail -n 1)
latest_velocity=$(ls velocity-3.3.0-SNAPSHOT-*.jar | sort -V | tail -n 1)

# Check if either JAR file exists
if [ -n "$latest_purpur" ]; then
    jar_type="Purpur"
    latest_jar="$latest_purpur"

    # Set heap size for Purpur in megabytes.
    heap_size=16384

    # Java command-line options for Purpur
    java_opts=(
        "-Xms${heap_size}M"                # Initial heap size for Purpur
        "-Xmx${heap_size}M"                # Maximum heap size for Purpur
    )

    echo "Using $jar_type JAR file: $latest_jar"
    java "${java_opts[@]}" -jar "$latest_jar" --nogui

elif [ -n "$latest_velocity" ]; then
    jar_type="Velocity"
    latest_jar="$latest_velocity"

    # Set heap size for Velocity in megabytes.
    heap_size=4096

    # Java command-line options for Velocity
    java_opts=(
        "-Xms${heap_size}M"                # Initial heap size for Velocity
        "-Xmx${heap_size}M"                # Maximum heap size for Velocity
        "-XX:+UseG1GC"                     # Use G1 Garbage Collector
        "-XX:G1HeapRegionSize=4M"          # Set G1 heap region size
        "-XX:+UnlockExperimentalVMOptions" # Unlock experimental VM options
        "-XX:+ParallelRefProcEnabled"      # Enable parallel reference processing
        "-XX:+AlwaysPreTouch"              # Pre-touch memory to improve performance
        "-XX:MaxInlineLevel=15"            # Increase the maximum inlining level
    )

    echo "Using $jar_type JAR file: $latest_jar"
    java "${java_opts[@]}" -jar "$latest_jar"

else
    # Exit if no relevant JAR file is found
    echo "No relevant JAR file found."
    exit 1
fi
