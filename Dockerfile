# Use the latest Ubuntu base image
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Update and install dependencies
#  - curl - npm build
#
RUN apt-get update && \
    apt-get install -y \
        vim \
        bash \
        curl \
        exuberant-ctags

# Install latest Node.js via NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && \
    apt-get install -y nodejs

# Install GitHub Copilot CLI globally
RUN npm install -g @github/copilot

# Create user to match host user
ARG USERNAME=user
ARG USER_UID=1001
ARG USER_GID=1001
ARG USER_HOME=/home/user
RUN if ! getent group $USER_GID >/dev/null; then \
        groupadd --gid $USER_GID $USERNAME; \
    fi && \
    if ! getent passwd $USER_UID >/dev/null; then \
        useradd --uid $USER_UID --gid $USER_GID --no-create-home --home-dir $USER_HOME $USERNAME; \
    else \
        EXISTING_USER=$(getent passwd $USER_UID | cut -d: -f1) && \
        usermod -l $USERNAME -d $USER_HOME -g $USER_GID $EXISTING_USER; \
    fi

USER $USERNAME

CMD ["/bin/bash"]

# Image metadata
LABEL org.opencontainers.image.title="vim-copilot"
LABEL org.opencontainers.image.description="Ubuntu container with Vim, Node.js, and GitHub Copilot CLI"
