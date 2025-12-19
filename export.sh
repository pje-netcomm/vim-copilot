#!/bin/bash
#
# Export

set -e

IMAGE_NAME="vim-copilot"
HOST_HOME="$HOME"
HOST_PWD="$PWD"

# Check if image exists
if ! docker image inspect "$IMAGE_NAME" > /dev/null 2>&1; then
    echo "Error: Image '$IMAGE_NAME' not found. Please run build.sh first."
    exit 1
fi

# Run the image to get a container for exporting
docker run -it \
    -v "$HOST_HOME":"$HOST_HOME":rw \
    -w "$HOST_PWD" \
    "$IMAGE_NAME" true


container=$(docker container ls -a | grep vim-copilot | cut -f 1 -d " ")

if [ $(echo "$container" | wc -w) != 1 ]; then
    echo "ERROR: More than one vim-copilot container present, prune them".
    exit 1
fi

set -o xtrace
docker export "$container" -o vim-copilot-docker.tar
docker container rm "$container"



