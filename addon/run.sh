#!/usr/bin/with-contenv bashio

# Set HOME to /config for persistence (mapped to addon_configs)
export HOME="/config"
export NODE_ENV="production"

# Read LLM configuration from Add-on options
if bashio::config.has_value 'llm_provider' && bashio::config.has_value 'api_key'; then
    PROVIDER=$(bashio::config 'llm_provider')
    API_KEY=$(bashio::config 'api_key')

    if [ "$PROVIDER" = "openai" ]; then
        export OPENAI_API_KEY="$API_KEY"
    elif [ "$PROVIDER" = "anthropic" ]; then
        export ANTHROPIC_API_KEY="$API_KEY"
    elif [ "$PROVIDER" = "openrouter" ]; then
        export OPENROUTER_API_KEY="$API_KEY"
    elif [ "$PROVIDER" = "google" ]; then
        export GOOGLE_API_KEY="$API_KEY"
    fi
    bashio::log.info "Configured API key for provider: $PROVIDER"
fi

# Agent configuration
export API_SERVER_HOST="0.0.0.0"
export API_SERVER_ENABLED="true"

# Ensure the .hermes config directory exists
mkdir -p "$HOME/.hermes"

# Workspace configuration
# Connect the workspace to the local agent running in the same container
export HERMES_API_URL="http://127.0.0.1:8642"
export PORT="3000"

# Trust proxy so ingress works correctly
export TRUST_PROXY="1"
export COOKIE_SECURE="0"

bashio::log.info "Starting Hermes Agent Gateway..."
# Start the agent in the background
hermes gateway run > /proc/1/fd/1 2>&1 &

bashio::log.info "Starting Hermes Workspace..."
cd /app
exec node --max-old-space-size=256 server-entry.js
