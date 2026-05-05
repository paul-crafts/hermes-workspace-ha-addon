ARG BUILD_FROM
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
RUN python3 -m venv /opt/hermes-venv
ENV PATH="/opt/hermes-venv/bin:$PATH"
RUN pip3 install --no-cache-dir git+https://github.com/NousResearch/hermes-agent.git

# Copy workspace directly from the pre-built image
WORKDIR /app
COPY --from=ghcr.io/outsourc-e/hermes-workspace:latest /app /app

# Add startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
