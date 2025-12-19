# Use the latest Ubuntu base image
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
RUN apt-get update && \
    apt-get install -y \
        vim \
        curl \
        gnupg \
        ca-certificates \
        git \
        openssh-client \
        bash \
        build-essential

# Install latest Node.js via NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get install -y nodejs

# Install GitHub Copilot CLI globally
RUN npm install -g @github/copilot-cli

# Create user to match host UID/GID (for mounting home)
ARG USERNAME=hostuser
ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID --create-home --home-dir /home/$USERNAME $USERNAME

WORKDIR /home/$USERNAME
USER $USERNAME

CMD ["/bin/bash"]

# Image metadata
LABEL org.opencontainers.image.title="vim-copilot"
LABEL org.opencontainers.image.description="Ubuntu container with Vim, Node.js, and GitHub Copilot CLI"
