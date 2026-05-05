# Use the official Hermes Agent image as the base (it already has Python, Agent, and Chromium)
FROM nousresearch/hermes-agent:latest

# Set environment
ENV LANG C.UTF-8
ENV HOME="/config"
ENV HERMES_HOME="/config"
ENV INSTALL_DIR="/opt/hermes"
ENV PATH="/opt/hermes/.venv/bin:${PATH}"

# Install minimal requirements for Home Assistant integration (bashio needs jq and curl)
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    jq \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy bashio from the official Home Assistant base image
COPY --from=ghcr.io/home-assistant/aarch64-base-debian:bookworm /usr/bin/bashio /usr/bin/bashio
COPY --from=ghcr.io/home-assistant/aarch64-base-debian:bookworm /usr/lib/bashio /usr/lib/bashio

# Copy pre-built workspace from the official workspace image
COPY --from=ghcr.io/outsourc-e/hermes-workspace:latest /app /app

# Add our custom startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# We bypass their entrypoint to use our run.sh which manages both services and bashio
ENTRYPOINT []
CMD [ "/run.sh" ]
