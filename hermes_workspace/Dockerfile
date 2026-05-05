# Using the standard Alpine-based Home Assistant base image
ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base:latest
FROM $BUILD_FROM

# Set environment
ENV LANG C.UTF-8
ENV HOME="/config"

# Install system dependencies (Alpine)
RUN apk add --no-cache \
    nodejs \
    npm \
    python3 \
    py3-pip \
    curl \
    git \
    && echo "System dependencies installed."

# Set up Python environment
# Note: On Alpine, we might need to install build dependencies if pip needs to compile wheels.
# However, many common wheels are now available for aarch64 alpine.
RUN python3 -m venv /opt/hermes-venv \
    && echo "Python virtual environment created."
ENV PATH="/opt/hermes-venv/bin:$PATH"

# Install hermes-agent
RUN pip3 install --no-cache-dir git+https://github.com/NousResearch/hermes-agent.git \
    && echo "Hermes Agent installed."

# Copy workspace directly from the pre-built image
WORKDIR /app
COPY --from=ghcr.io/outsourc-e/hermes-workspace:latest /app /app
RUN echo "Workspace assets copied."

# Add startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
