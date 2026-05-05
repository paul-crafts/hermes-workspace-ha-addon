# Switching back to Debian for full compatibility with web browsing (Playwright/Chromium)
FROM ghcr.io/home-assistant/aarch64-base-debian:bookworm

# Set environment
ENV LANG C.UTF-8
ENV HOME="/config"
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
ENV CHROME_BIN=/usr/bin/chromium

# Install system dependencies + Browser support
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
    && rm -rf /var/lib/apt/lists/* \
    && echo "System dependencies and Browser tools installed."

# Set up Python environment
RUN python3 -m venv /opt/hermes-venv
ENV PATH="/opt/hermes-venv/bin:$PATH"

# Install hermes-agent (verbose)
RUN pip3 install -v --no-cache-dir git+https://github.com/NousResearch/hermes-agent.git \
    && echo "Hermes Agent installed."

# Copy workspace directly from the pre-built image
WORKDIR /app
COPY --from=ghcr.io/outsourc-e/hermes-workspace:latest /app /app
RUN echo "Workspace assets copied."

# Add startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Use standard HA command pattern
CMD [ "/run.sh" ]
