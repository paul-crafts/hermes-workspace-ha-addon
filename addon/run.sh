#!/usr/bin/with-contenv bashio

# Set HOME to /config for persistence (mapped to addon_configs)
export HOME="/config"
export NODE_ENV="production"

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
