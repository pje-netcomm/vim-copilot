#!/bin/bash

set -e

IMAGE_NAME="vim-copilot"
HOST_HOME="$HOME"
HOST_PWD="$PWD"

# Check if image exists
if ! docker image inspect "$IMAGE_NAME" > /dev/null 2>&1; then
    echo "Error: Image '$IMAGE_NAME' not found. Please run build.sh first."
    exit 1
fi

# Run the container with the given command, default to bash if empty
if [ $# -eq 0 ]; then
    CMD="/bin/bash"
else
    CMD="$@"
fi

docker run -it --rm \
    -v "$HOST_HOME":"$HOST_HOME":rw \
    -w "$HOST_PWD" \
    "$IMAGE_NAME" $CMD
