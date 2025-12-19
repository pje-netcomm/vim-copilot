#!/bin/bash

set -e

IMAGE_NAME="vim-copilot"
DOCKERFILE="Dockerfile"
CONTAINER_HOME="/home/hostuser"
HOST_HOME="$HOME"

# Check if image needs rebuilding (if not exists or Dockerfile newer than image)
need_build=0
if ! docker image inspect "$IMAGE_NAME" > /dev/null 2>&1; then
    need_build=1
else
    DOCKERFILE_MTIME=$(stat -c %Y "$DOCKERFILE")
    IMAGE_CREATED=$(docker image inspect "$IMAGE_NAME" --format '{{.Created}}')
    IMAGE_CREATED_EPOCH=$(date --date="$IMAGE_CREATED" +%s)
    if [ "$DOCKERFILE_MTIME" -gt "$IMAGE_CREATED_EPOCH" ]; then
        need_build=1
    fi
fi

if [ $need_build -eq 1 ]; then
    echo ">>> Building $IMAGE_NAME image..."
    docker build -t "$IMAGE_NAME" -f "$DOCKERFILE" .
else
    echo ">>> $IMAGE_NAME image is up to date."
fi

# Run the container with the given command, default to bash if empty
if [ $# -eq 0 ]; then
    CMD="/bin/bash"
else
    CMD="$@"
fi

docker run -it --rm \
    -v "$HOST_HOME":"$CONTAINER_HOME" \
    -e USER_UID="$(id -u)" \
    -e USER_GID="$(id -g)" \
    "$IMAGE_NAME" $CMD
