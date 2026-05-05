# LLM Instructions

## Versioning
When modifying this Home Assistant Add-on, **you MUST ALWAYS bump the `version` field in `addon/config.yaml` before committing and pushing to git.**

Home Assistant relies on the version string in `config.yaml` to detect updates to add-ons. If you push code changes without bumping the version, the user's Home Assistant instance will not prompt them to update the add-on.

### Steps for LLMs:
1. Make the requested changes to the code or configuration.
2. Open `addon/config.yaml` and increment the `version` (e.g., from `1.0.0` to `1.0.1` or `1.1.0` depending on the scope of the change).
3. Commit the changes and push to the remote repository.
