# Use any Debian/Ubuntu-based image. 😊
FROM mcr.microsoft.com/vscode/devcontainers/base:buster

COPY .devcontainer/scripts/*.sh /tmp/scripts/
COPY requirements.txt /tmp/

# [Option] Install zsh
ARG INSTALL_ZSH="true"
# [Option] Upgrade OS packages to their latest versions
ARG UPGRADE_PACKAGES="false"
# [Optional] Install Python
ARG INSTALL_PYTHON="true"
# [Option] Install Node.js
ARG INSTALL_NODE="true"
ARG NODE_VERSION="lts/*"

# COMMON
# Install needed packages and setup non-root user. Use a separate RUN statement to add your own dependencies.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && bash /tmp/scripts/common.sh "${INSTALL_ZSH}" "${USERNAME}" "${USER_UID}" "${USER_GID}" "${UPGRADE_PACKAGES}" "true" "true" \
    && apt-get install -y graphviz

# PYTHON
# Setup default python tools in a venv via pipx to avoid conflicts
ARG PYTHON_VERSION=3.8.3
ENV PIPX_HOME=/usr/local/py-utils \
    PIPX_BIN_DIR=/usr/local/py-utils/bin
ENV PATH=${PATH}:${PIPX_BIN_DIR}
RUN if [ "${INSTALL_PYTHON}" = "true" ]; then bash /tmp/scripts/python.sh "${PYTHON_VERSION}" "/usr/local" "${PIPX_HOME}" "${USERNAME}"; fi \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN if [ "${INSTALL_PYTHON}" = "true" ]; then pip3 install -r /tmp/requirements.txt; fi

# NODEJS
# Install Node.js
ENV NVM_DIR=/usr/local/share/nvm
ENV NVM_SYMLINK_CURRENT=true \
    PATH=${NVM_DIR}/current/bin:${PATH}
RUN if [ "${INSTALL_NODE}" = "true" ]; then bash /tmp/scripts/node.sh "${NVM_DIR}" "${NODE_VERSION}" "${USERNAME}"; fi \
    && rm -rf /var/lib/apt/lists/*

RUN if [ "${INSTALL_NODE}" = "true" ]; then npm install -g markdownlint-cli; fi

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>
