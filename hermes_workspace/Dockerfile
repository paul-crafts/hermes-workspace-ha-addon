FROM ghcr.io/home-assistant/aarch64-base-debian:bookworm

# Set environment
ENV LANG C.UTF-8
ENV HOME="/config"

# Install system dependencies (Step 1)
RUN apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    npm \
    python3 \
    python3-pip \
    python3-venv \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/* \
    && echo "System dependencies installed successfully."

# Set up Python environment (Step 2)
RUN python3 -m venv /opt/hermes-venv \
    && echo "Python virtual environment created."
ENV PATH="/opt/hermes-venv/bin:$PATH"

# Install hermes-agent with verbose output (Step 3)
# This is usually the slowest part of the build
RUN pip3 install -v --no-cache-dir git+https://github.com/NousResearch/hermes-agent.git \
    && echo "Hermes Agent installed successfully."

# Copy workspace (Step 4)
WORKDIR /app
COPY --from=ghcr.io/outsourc-e/hermes-workspace:latest /app /app
RUN echo "Hermes Workspace assets copied."

# Finalize (Step 5)
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
