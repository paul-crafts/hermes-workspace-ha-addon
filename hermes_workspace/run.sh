#!/usr/bin/env bashio

# Set environment
export HOME="/config"
export HERMES_HOME="/config"
export INSTALL_DIR="/opt/hermes"
export NODE_ENV="production"
export PYTHONUNBUFFERED=1
export PLAYWRIGHT_BROWSERS_PATH="/opt/hermes/.playwright"

# Read LLM configuration from Add-on options
if bashio::config.has_value 'openai_api_key'; then
    export OPENAI_API_KEY=$(bashio::config 'openai_api_key')
    bashio::log.info "Configured OpenAI API key"
fi
if bashio::config.has_value 'anthropic_api_key'; then
    export ANTHROPIC_API_KEY=$(bashio::config 'anthropic_api_key')
    bashio::log.info "Configured Anthropic API key"
fi
if bashio::config.has_value 'google_api_key'; then
    export GOOGLE_API_KEY=$(bashio::config 'google_api_key')
    bashio::log.info "Configured Google API key"
fi
if bashio::config.has_value 'openrouter_api_key'; then
    export OPENROUTER_API_KEY=$(bashio::config 'openrouter_api_key')
    bashio::log.info "Configured OpenRouter API key"
fi
if bashio::config.has_value 'groq_api_key'; then
    export GROQ_API_KEY=$(bashio::config 'groq_api_key')
    bashio::log.info "Configured Groq API key"
fi
if bashio::config.has_value 'mistral_api_key'; then
    export MISTRAL_API_KEY=$(bashio::config 'mistral_api_key')
    bashio::log.info "Configured Mistral API key"
fi

# Bootstrap Hermes directory structure in /config
mkdir -p "$HERMES_HOME"/{cron,sessions,logs,hooks,memories,skills,skins,plans,workspace,home}

# Bootstrap config files if they don't exist
if [ ! -f "$HERMES_HOME/.env" ]; then
    cp "$INSTALL_DIR/.env.example" "$HERMES_HOME/.env" || true
fi
if [ ! -f "$HERMES_HOME/config.yaml" ]; then
    cp "$INSTALL_DIR/cli-config.yaml.example" "$HERMES_HOME/config.yaml" || true
fi

# Agent configuration
export API_SERVER_HOST="0.0.0.0"
export API_SERVER_ENABLED="true"

# Workspace configuration
export HERMES_API_URL="http://127.0.0.1:8642"
export PORT="3000"
export TRUST_PROXY="1"
export COOKIE_SECURE="0"

# Use the pre-installed venv
source "${INSTALL_DIR}/.venv/bin/activate"

bashio::log.info "Starting Hermes Agent Gateway..."
# Start the agent in the background
hermes gateway run > /proc/1/fd/1 2>&1 &

bashio::log.info "Starting Hermes Workspace..."
cd /app
exec node --max-old-space-size=256 server-entry.js
