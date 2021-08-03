FROM mcr.microsoft.com/vscode/devcontainers/python:3.8 as workspace

RUN mkdir -p /workspace

# [Option] Install Node.js
ARG INSTALL_NODE="true"
ARG NODE_VERSION="lts/fermium"
RUN if [ "${INSTALL_NODE}" = "true" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# [Optional] If your pip requirements rarely change, uncomment this section to add them to the image.
COPY requirements.txt /tmp/pip-tmp/
RUN pip3 --disable-pip-version-check --no-cache-dir install -r /tmp/pip-tmp/requirements.txt \
   && rm -rf /tmp/pip-tmp

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment this line to install global node packages.
RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g markdownlint-cli" 2>&1

###########################
FROM workspace as builder
COPY . /workspace
WORKDIR /workspace

###########################
FROM builder as lint
RUN make lint

###########################
FROM builder as scan
RUN make sec_scan

###########################
FROM builder as build
RUN make build

