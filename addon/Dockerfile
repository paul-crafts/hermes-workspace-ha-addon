ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base-debian:bookworm
# Use the pre-built workspace image to save time and resources during build
FROM ghcr.io/outsourc-e/hermes-workspace:latest AS workspace

FROM $BUILD_FROM

# Install dependencies for Node and Python
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    python3 \
    python3-pip \
    python3-venv \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a virtual environment for hermes-agent
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install hermes-agent
RUN pip3 install --no-cache-dir git+https://github.com/NousResearch/hermes-agent.git

# Copy pre-built workspace from the workspace image
WORKDIR /app
COPY --from=workspace /app /app

# Add the startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
