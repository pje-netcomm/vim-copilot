# vim-copilot

A containerised version of vim and Github co-pilot.  This helps avoid needing to update your system to latest node.js and vim which is required by copilot CLI.

This project is mostly created with the help of AI (claude-sonnet via GitHub Copilot).


## Features

- **Vim Editor**: Latest Vim with exuberant-ctags support
- **GitHub Copilot CLI**: AI-powered command-line assistance
- **User Matching**: Container user matches your host username, UID, GID, and home directory
- **Home Directory Mounting**: Your home directory is mounted with read/write access at the same path
- **Working Directory Preservation**: Container starts in your current directory

## Prerequisites

- Docker installed and running
- GitHub Copilot CLI access (requires GitHub Copilot subscription)

## Setup

1. Build the Docker image:
   ```bash
   ./build.sh
   ```

   This builds an image configured with your current user's username, UID, GID, and home directory path.

2. (Optional) Add the directory to your PATH to use the wrapper scripts from anywhere:
   ```bash
   export PATH="/path/to/vim-copilot:$PATH"
   ```

## Usage

### Run Interactive Shell

```bash
./run.sh
```

Starts an interactive bash shell in the container with your home directory mounted.

### Run Vim

```bash
./vim [file...]
```

Opens Vim in the container with any specified files.

### Run GitHub Copilot CLI

```bash
./copilot [command]
```

Runs GitHub Copilot CLI commands in the container.

### Run Custom Commands

```bash
./run.sh <command> [args...]
```

Runs any command in the container with arguments.

## How It Works

- **build.sh**: Builds the Docker image with your user configuration (username, UID, GID, home directory)
- **run.sh**: Runs the container with:
  - Home directory mounted at the same path as host with read/write access
  - Working directory set to your current directory (`$PWD`)
  - Container user matching your host user
- **vim**: Wrapper script that calls `run.sh vim`
- **copilot**: Wrapper script that calls `run.sh copilot`

## Technical Details

- Base Image: Ubuntu latest
- Node.js: Latest version via NodeSource
- Packages: vim, git, curl, build-essential, exuberant-ctags, openssh-client
- User Configuration: Matches host user to ensure proper file permissions

## Notes

- The container runs with `--rm` flag, so it's removed after exit
- All file changes are persisted to your host home directory
- The image needs to be rebuilt if you change the Dockerfile
