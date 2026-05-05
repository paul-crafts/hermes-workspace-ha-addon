# 1. Source: Official Workspace
FROM ghcr.io/outsourc-e/hermes-workspace:latest AS workspace

# 2. Source: Official Agent
FROM nousresearch/hermes-agent:latest AS agent

# 3. Final Image
FROM ghcr.io/home-assistant/aarch64-base-debian:bookworm

# Set environment
ENV LANG C.UTF-8
ENV HOME="/config"
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
ENV CHROME_BIN=/usr/bin/chromium
ENV PYTHONUNBUFFERED=1

# Install runtime dependencies + Browser support
# We only install the essentials here, skipping build-essential to save space
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    git \
    chromium \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    jq \
    && rm -rf /var/lib/apt/lists/* \
    && echo "Runtime dependencies and Browser tools installed."

# Copy pre-built workspace from workspace source
WORKDIR /app
COPY --from=workspace /app /app

# Copy the entire hermes-agent installation from agent source
# This skips the slow pip install / compilation phase
COPY --from=agent /opt/hermes /opt/hermes
COPY --from=agent /usr/local/bin/uv /usr/local/bin/uv

# Link the agent so it's globally available
ENV PATH="/opt/hermes/.venv/bin:$PATH"

# Add startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
