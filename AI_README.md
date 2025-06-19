# AI-Assisted Plugin Management

This document outlines the process for adding new Neovim plugins to this configuration, with a focus on leveraging AI assistance for a streamlined workflow.

**Important**: This repository is not a Neovim configuration itself. Rather, it is a blueprint and a set of installers (`install_on_mac_osx.sh` and `Dockerfile`) that build a complete, ready-to-use Neovim environment. The plugin source code is not stored here; it is cloned during the installation process.

## Guiding Principles

- **Pack-based management**: All plugins are managed using Neovim's native package management system (`:help packages`). This system revolves around the `packpath` option, which is a list of directories where Neovim looks for plugins.

- **Autoloading with `start`**: Inside any directory in `packpath` (e.g., `~/.config/nvim/pack/`), Neovim automatically searches for plugins in any subdirectory matching `pack/*/start/*`. Any plugin located in a `start` directory will be loaded automatically at startup. This is the core mechanism we use. For example, a plugin at `pack/cmp/start/nvim-cmp` is automatically loaded.

- **Co-located dependencies**: A plugin and its dependencies should be grouped together in the same pack. For example, `nvim-cmp` and all of its `cmp-*` sources are located in `pack/cmp/`. This makes it easy to manage related plugins as a single unit.

- **Mirrored repository structure**: The `pack` directory in this repository is a blueprint for the final Neovim configuration. The installation scripts (`install_on_mac_osx.sh` and `Dockerfile`) are responsible for replicating this structure in the user's configuration directory (`~/.config/nvim` or `/root/.config/nvim`).

- **Configuration as plugins**: Custom configurations are written as separate plugins. This keeps the main `init.lua` clean and allows for modular and targeted configuration. For example, the configuration for `nvim-cmp` is located at `pack/cmp/start/cmp-config/plugin/cmp_config.lua` and is loaded automatically because it's in a `start` directory.

> **Note on Optional Plugins**: Neovim also supports optional plugins in `pack/*/opt/*`, which can be loaded manually with `:packadd`. For simplicity and consistency, this configuration exclusively uses `start` plugins.

## Adding a New Plugin

To add a new plugin, follow these steps:

1.  **Choose or Create a Pack**: A "pack" is a logical grouping of plugins. For example, `pack/cmp` is the pack for all completion-related plugins. If you're adding a plugin related to an existing group, use that pack. If it's a new, unrelated plugin, create a new pack directory for it (e.g., `pack/my-new-plugin`).

2.  **Add the Plugin to `start`**: Clone the plugin's repository into the `start` subdirectory of your chosen pack. For example: `pack/my-new-plugin/start/the-actual-plugin-name`.

3.  **Add a Config Plugin**: Create a directory for your configuration plugin within the same `start` directory. This config directory should itself be structured as a plugin. The convention is to use a `-config` suffix. For example: `pack/my-new-plugin/start/my-new-plugin-config/plugin/config.lua`.

4.  **Update Installation Scripts**:
    -   **`install_on_mac_osx.sh`**: Add the necessary `git clone` commands to install the new plugin(s) and `cp` or `mkdir` and `cp` commands to create your configuration plugin directory and file.
    -   **`install_on_windows.ps1`**: Add a corresponding `Install-Plugin` call or other PowerShell commands to perform the same installation.
    -   **`Dockerfile`**: Add the same `git clone` and `COPY` commands to the `Dockerfile`.

5.  **Update Documentation and Health Checks**: This configuration uses a custom help system located in `nvim-config/doc/`. To add or update documentation for a plugin or feature, follow this process:
    -   **Create a help file**: Create a new `.txt` file in `nvim-config/doc/` (e.g., `nvim-config/doc/new-feature.txt`).
    -   **Add a help tag**: At the top of the file, add a title and a main tag, like this: `*oatvim-new-feature* My New Feature`. This tag is how other help files will link to yours.
    -   **Link to the new file**: In the main help file, `nvim-config/doc/oatvim.txt`, add a line that links to your new tag (e.g., `-   My New Feature....................................|oatvim-new-feature|`).
    -   **Write the content**: Describe your configuration and provide links to the original plugin's documentation (e.g., `|new-plugin-help-tag|`).
    -   **Update health checks**: If the new plugin has external dependencies that can be verified, consider updating the `oathealth` plugin (`pack/oathealth/start/oathealth/lua/oathealth/health.lua`) to include a health check for it.
    -   You do not need to run `:helptags` manually; this is handled automatically when Neovim starts, making your new help document searchable.

By following these steps, you can ensure that new plugins are added in a way that is consistent with the existing structure of this configuration, making it easier to manage and maintain over time. 