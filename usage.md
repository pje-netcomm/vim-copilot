# Usage Guide

## Building the Docker Container

To build the Docker image for this project, from the repository root, run:

```sh
docker build -t vim-copilot .
```

## Running the Docker Container

To start a container from your built image:

```sh
docker run --rm -it vim-copilot
```

You can add additional options (such as mounting volumes or setting environment variables) as needed:

```sh
docker run --rm -it \
  -v $(pwd):/app \
  -e ENV_VARIABLE=value \
  vim-copilot
```

## Notes
- Make sure Docker is installed and running on your system.
- Modify the Docker run command as needed for your workflow (e.g., mapping configuration files or directories).
