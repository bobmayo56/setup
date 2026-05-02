FROM node:20

# --- Python and useful tools --
RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    python3.11-dev \
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
    && rm -rf /var/lib/apt/lists/*

# Make python3.11 the default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1

# --- uv ---
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# --- AWS CLI ---
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws

# --- rclone ---
RUN curl https://rclone.org/install.sh | bash

# --- Claude Code ---
RUN npm install -g @anthropic-ai/claude-code

WORKDIR /workspace

CMD ["bash", "-l"]
