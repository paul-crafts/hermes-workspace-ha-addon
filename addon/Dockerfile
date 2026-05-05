ARG BUILD_FROM=ghcr.io/home-assistant/aarch64-base-debian:bookworm
FROM node:22-alpine AS build-node
WORKDIR /build

# Install pnpm
RUN corepack enable pnpm

# Clone hermes-workspace and build it
RUN apk add --no-cache git
RUN git clone https://github.com/outsourc-e/hermes-workspace.git .
RUN pnpm install --frozen-lockfile
RUN pnpm build

# Runtime Stage
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

# Create a virtual environment for hermes-agent to avoid PEP 668 issues on Debian Bookworm
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install hermes-agent inside the venv
RUN pip3 install --no-cache-dir git+https://github.com/NousResearch/hermes-agent.git

# Set up Node app
WORKDIR /app
COPY --from=build-node /build/dist ./dist
COPY --from=build-node /build/node_modules ./node_modules
COPY --from=build-node /build/package.json ./package.json
COPY --from=build-node /build/server-entry.js ./server-entry.js
COPY --from=build-node /build/skills ./skills

# Add the startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
