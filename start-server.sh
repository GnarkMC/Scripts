#!/bin/bash

# User-configurable options
BASE_NAME="paper-1.21.3-74"
HEAP_SIZE=16384
JAVA_OPTS=(
    "-Xms${HEAP_SIZE}M"
    "-Xmx${HEAP_SIZE}M"
    "-DPaper.IgnoreJavaVersion=true"
)

# Find the JAR file with the highest version number
NAME=$(ls ${BASE_NAME}*.jar 2>/dev/null | sort -V | tail -n 1)

if [ -n "$NAME" ]; then
    echo "Using JAR file: $NAME"
    java "${JAVA_OPTS[@]}" -jar "$NAME" --nogui
else
    echo "No relevant JAR file found."
    exit 1
fi
