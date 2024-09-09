# https://github.com/GnarkMC/Scripts/blob/main/start-server.sh

# User-configurable options
BASE_NAME="DivineMC-1.21.1-" # Set the base name of the JAR file (before the version number)
HEAP_SIZE=16384              # Set heap size for the server (megabytes)
JAVA_OPTS=(                  # Java command-line options
    "-Xms${HEAP_SIZE}M"      # Initial heap size
    "-Xmx${HEAP_SIZE}M"      # Maximum heap size
)

# Find the JAR file with the highest version number
NAME=$(ls ${BASE_NAME}*.jar 2>/dev/null | sort -V | tail -n 1)

if [ -n "$NAME" ]; then # Check if any JAR file was found
    echo "Using JAR file: $NAME"
    java "${JAVA_OPTS[@]}" -jar "$NAME" --nogui
else # Exit if no JAR file is found
    echo "No relevant JAR file found."
    exit 1
fi
