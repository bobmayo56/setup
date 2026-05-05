FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# --- Base tools ---
RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    python3-dev \
    python3-pip \
    libgdal-dev \
    libeccodes-dev \
    git \
    curl \
    wget \
    vim \
    jq \
    ripgrep \
    fzf \
    unzip \
    netcdf-bin \
    ncview \
    libnetcdf-dev \
    libhdf5-dev \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# --- Node.js 20 ---
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# --- uv ---
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# --- AWS CLI ---
RUN ARCH=$(uname -m) && \
    case "$ARCH" in \
        aarch64) AWS_ARCH="aarch64" ;; \
        *) AWS_ARCH="x86_64" ;; \
    esac && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}.zip" -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws

# --- rclone ---
RUN curl https://rclone.org/install.sh | bash

# --- Dotfiles ---
# Docker caches this layer, so if you push dotfile updates, a plain docker compose build
# won't pick them up. You'd need docker compose build --no-cache to force a fresh clone.

RUN git clone https://github.com/bobmayo56/setup.git /bobmayo56_setup \
    && cd /bobmayo56_setup \
    && make home_dir

# --- Claude Code ---
RUN npm install -g @anthropic-ai/claude-code

WORKDIR /workspace

CMD ["bash", "-l"]
