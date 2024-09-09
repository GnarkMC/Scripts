# https://github.com/GnarkMC/Scripts/blob/main/start-proxy.sh

# User-configurable options
BASE_NAME="velocity-3.3.0-SNAPSHOT-"    # Set the base name of the JAR file (before the version number)
HEAP_SIZE=4096                         # Set heap size for the server (megabytes)
JAVA_OPTS=(                            # Java command-line options
    "-Xms${HEAP_SIZE}M"                # Initial heap size
    "-Xmx${HEAP_SIZE}M"                # Maximum heap size
    "-XX:+UseG1GC"                     # Use G1 Garbage Collector
    "-XX:G1HeapRegionSize=4M"          # Set G1 heap region size
    "-XX:+UnlockExperimentalVMOptions" # Unlock experimental VM options
    "-XX:+ParallelRefProcEnabled"      # Enable parallel reference processing
    "-XX:+AlwaysPreTouch"              # Pre-touch memory to improve performance
    "-XX:MaxInlineLevel=15"            # Increase the maximum inlining level
)

# Find the Purpur JAR file with the highest version number
NAME=$(ls ${BASE_NAME}*.jar 2>/dev/null | sort -V | tail -n 1)

if [ -n "$NAME" ]; then # Check if any JAR file was found
    echo "Using JAR file: $NAME"
    java "${JAVA_OPTS[@]}" -jar "$NAME"
else # Exit if no JAR file is found
    echo "No relevant JAR file found."
    exit 1
fi
