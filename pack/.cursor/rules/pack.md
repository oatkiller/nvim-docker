---
description: Manages the `pack` directory, which is the heart of the plugin management system.
globs: '**'
alwaysApply: true
---

- **Main Goal**: The `pack` directory is a blueprint for Neovim's native package management. Each subdirectory within `pack` is a "pack" that groups related plugins.

- **Core Concepts**:
    - **Pack-based Management**: Plugins are grouped into packs (e.g., `cmp` for completion).
    - **`start` Directory**: All plugins are placed in a `start` subdirectory (e.g., `cmp/start/nvim-cmp`). Neovim loads anything in a `start` directory automatically on startup.
    - **Configuration as Plugins**: Custom configurations for a plugin are created as their own separate plugin (e.g., `cmp/start/cmp-config`). This keeps `init.lua` clean.
    - **Co-located Dependencies**: A plugin and its dependencies should be in the same pack.

---

### Adding a New Plugin

1.  **Choose/Create a Pack**:
    - If the new plugin belongs to an existing group (e.g., it's a `cmp` source), place it in the corresponding pack directory (e.g., `cmp`).
    - If it's a new, standalone plugin, create a new pack directory for it (e.g., `my-new-feature`).

2.  **Add the Plugin**:
    - Clone the plugin's repository into the `start` subdirectory of the chosen pack.
    - Example: `git clone <repo_url> my-new-feature/start/plugin-name`

3.  **Add Configuration Plugin**:
    - Inside the same `start` directory, create a directory for your configuration plugin. Conventionally, this is named with a `-config` suffix.
    - This directory must also be structured as a plugin, with your code in a `plugin/` subdirectory.
    - Example structure: `my-new-feature/start/my-new-feature-config/plugin/config.lua`.

4.  **Update Installation Scripts**:
    - Crucially, you must update the installation scripts (`Dockerfile`, `install_on_mac_osx.sh`, etc.) to clone the plugin and copy your configuration. See the [root rule](../../.cursor/rules/root.md) for more details.

### Maintaining Plugins

- **Updating a Plugin**: To update a plugin, you would typically `git pull` inside its directory. However, since this repository is a blueprint, the update process involves changing the `git clone` command in the installation scripts if you need to pin it to a specific commit or branch. Otherwise, it will always clone the latest version.
- **Updating Configuration**: Simply edit the files within your configuration plugin (e.g., `my-new-feature/start/my-new-feature-config/plugin/config.lua`).

### Deleting a Plugin

1.  **Remove Plugin and Config**: Delete the plugin's directory and its associated configuration directory from the pack.
    - Example: `rm -rf my-new-feature/start/plugin-name` and `rm -rf my-new-feature/start/my-new-feature-config`.
2.  **Clean Up Pack**: If the pack is now empty, remove the pack directory itself.
    - Example: `rmdir my-new-feature`.
3.  **Update Installation Scripts**: Remove the corresponding `git clone` and `cp` commands from the installation scripts as described in the [root rule](../../.cursor/rules/root.md). 