# Documentation

## Getting Started

This add-on allows you to run the **Hermes Workspace** entirely within your Home Assistant environment. It automatically launches the Hermes Agent backend and connects the frontend workspace.

### Step 1: Configuration
Before starting the add-on for the first time, navigate to the **Configuration** tab:
1. Select your **LLM Provider** (e.g., `openai`, `anthropic`).
2. Provide the corresponding **API Key**.

*Note: If you plan to use local models via Ollama or similar, leave the API key blank and configure it via the workspace UI after starting.*

### Step 2: Start and Access
1. Start the add-on.
2. Toggle **Show in sidebar** to easily access it from the Home Assistant sidebar.
3. Click **Open Web UI** or the new sidebar link to enter Hermes Workspace.

## Data Persistence

All your agent configurations, sessions, and memory are stored in your Home Assistant's `addon_configs` directory (which maps to `/config` internally). This ensures your data survives add-on updates and restarts.

## Troubleshooting

- **White screen on load**: Try refreshing your browser cache or opening the UI in a new tab. Ingress proxies can sometimes aggressively cache the frontend assets.
- **Agent not connecting**: Check the add-on **Log** tab. If the agent fails to start, it's typically due to a missing or invalid API key.
