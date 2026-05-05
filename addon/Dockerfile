# 1. Get the pre-built workspace
FROM ghcr.io/outsourc-e/hermes-workspace:latest AS workspace

# 2. Final image
ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base-debian:bookworm
FROM $BUILD_FROM

# Set environment
ENV LANG C.UTF-8
ENV HOME="/config"

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install hermes-agent via pip
# We use a venv to stay clean on Debian
RUN python3 -m venv /opt/hermes-venv
ENV PATH="/opt/hermes-venv/bin:$PATH"
RUN pip3 install --no-cache-dir git+https://github.com/NousResearch/hermes-agent.git

# Copy workspace from build stage
WORKDIR /app
COPY --from=workspace /app /app

# Add startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
