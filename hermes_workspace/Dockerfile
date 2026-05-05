ARG BUILD_FROM

# 1. Sources
FROM nousresearch/hermes-agent:latest AS agent
FROM ghcr.io/outsourc-e/hermes-workspace:latest AS workspace

# 2. Final Image (Back to HA Base)
FROM $BUILD_FROM

# Set environment
ENV LANG C.UTF-8
ENV HOME="/config"
ENV HERMES_HOME="/config"
ENV INSTALL_DIR="/opt/hermes"
ENV PLAYWRIGHT_BROWSERS_PATH="/opt/hermes/.playwright"
ENV CHROME_BIN="/opt/hermes/.playwright/chromium-*/chrome-linux/chrome"
ENV PATH="/opt/hermes/.venv/bin:${PATH}"
ENV __BASHIO_LIB_DIR=/usr/lib/bashio
ENV S6_KEEP_ENV=1
ENV S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0
ENV UV_LINK_MODE=copy


# Install only the system libraries needed for the browser (much faster than full chromium)
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    git \
    jq \
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
    && rm -rf /var/lib/apt/lists/*

# Copy pre-installed agent and browser from official source
COPY --from=agent /opt/hermes /opt/hermes
COPY --from=agent /usr/local/bin/uv /usr/local/bin/uv

# Re-create the virtual environment to match the system Python version (3.11)
# This ensures that the hermes_cli module and all dependencies are correctly found.
RUN cd /opt/hermes && \
    rm -rf .venv && \
    uv venv && \
    uv pip install --no-cache-dir -e ".[all]"

# Copy pre-built workspace from workspace source
WORKDIR /app
COPY --from=workspace /app /app

# Add startup script
# Add startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
