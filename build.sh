#!/bin/bash

set -e

IMAGE_NAME="vim-copilot"
DOCKERFILE="Dockerfile"
HOST_HOME="$HOME"
HOST_USER="$(whoami)"

echo ">>> Building $IMAGE_NAME image..."
docker build -t "$IMAGE_NAME" \
    --build-arg USERNAME="$HOST_USER" \
    --build-arg USER_UID="$(id -u)" \
    --build-arg USER_GID="$(id -g)" \
    --build-arg USER_HOME="$HOST_HOME" \
    -f "$DOCKERFILE" .

echo ">>> Build complete!"
