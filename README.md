# Hermes Workspace - Home Assistant Add-on Repository

This repository contains the Home Assistant Add-on for **Hermes Workspace**.

Hermes Workspace is your AI agent's command center — chat, files, memory, skills, and terminal in one place. This add-on runs both the `hermes-agent` (backend) and `hermes-workspace` (frontend) locally on your Home Assistant OS, optimized for devices like the Raspberry Pi Compute Module 4 (CM4).

## Features
- **All-In-One**: Runs both the backend AI agent and the frontend workspace within a single add-on container.
- **Ingress Support**: Access the workspace directly from your Home Assistant sidebar.
- **Data Persistence**: Maps all your agent memory and configuration to Home Assistant's `addon_configs` directory automatically.

## Installation

You can add this repository to your Home Assistant instance with a single click:

[![Open your Home Assistant instance and show the add-on store with a specific repository pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fpaul-crafts%2Fhermes-workspace-ha-addon)

Alternatively, add the repository manually:
1. Go to **Settings > Add-ons > Add-on Store** in Home Assistant.
2. Click the three dots in the top right corner and select **Repositories**.
3. Add the URL of this repository: `https://github.com/paul-crafts/hermes-workspace-ha-addon`
4. Click **Add** and then close the dialog.
5. Refresh the page and scroll down to find the **Hermes Workspace** add-on.

## Configuration

The add-on can be configured from its "Configuration" tab before starting:
- **LLM Provider**: Choose your preferred provider (OpenAI, Anthropic, OpenRouter, etc.).
- **API Key**: Input the API key for your chosen provider.

## Support

If you find this add-on useful and want to support its maintenance, consider buying me a coffee:

<a href="https://www.buymeacoffee.com/paul.crafts" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
