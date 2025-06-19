# Task 12: Refactor to a Centralized Plugin Loading Strategy

## Description

The current plugin loading mechanism relies on Neovim's file-based `start` directory system, where everything is loaded automatically. A more flexible and robust approach is to centralize control, allowing plugins to be enabled or disabled from a single configuration file.

The goal of this task is to refactor the entire plugin management system. All plugins will be moved to `opt` directories and loaded explicitly via `:packadd` from a single, new, core `start` plugin.

## Plan

1.  **Create the Core Loader Pack**:
    -   Create a new pack for core functionality: `pack/oatvim-core/`.
    -   Inside this pack, create the loader plugin that will be the **only** `start` plugin in the entire configuration: `pack/oatvim-core/start/oatvim-loader/plugin/`.
    -   Create a Lua file inside, e.g., `loader.lua`.

2.  **Implement the Central Loader**:
    -   In `loader.lua`, define a table containing the names of all plugin directories that should be loaded (e.g., `{"nvim-cmp", "cmp-config", "lsp-config", ...}`).
    -   Write a loop that iterates over this table and executes `vim.cmd('packadd ' .. plugin_name)` for each entry.
    -   This file becomes the single source of truth for which plugins are active. Disabling a plugin is as simple as commenting it out from this list.

3.  **Convert All Existing Packs to `opt`**:
    -   This is a critical step that requires modifying the installation scripts.
    -   In `install_on_windows.ps1`, `install_on_mac_osx.sh`, and the `Dockerfile`, find every command that installs a plugin (`git clone`, `cp`, `COPY`).
    -   Change the destination path for all of them from `pack/.../start/...` to `pack/.../opt/...`.

4.  **Update Install Scripts for the New Core Pack**:
    -   Add the necessary commands (`mkdir`, `cp`/`COPY`) to all three installation scripts to create the new `pack/oatvim-core/start/oatvim-loader/` plugin from the local files in the repository.

5.  **Simplify `init.lua`**:
    -   The main `init.lua` can now be simplified significantly. Since `oatvim-loader` is a `start` plugin, it will load automatically, and no explicit `require` or `packadd` calls should be needed in `init.lua` for plugin loading.

6.  **Update Documentation**:
    -   Create a new help file (`nvim-config/doc/managing-plugins.txt`) that explains the new centralized loading system.
    -   Document that enabling/disabling plugins is now done by editing the list in `pack/oatvim-core/start/oatvim-loader/plugin/loader.lua`.
    -   Update the main `oatvim.txt` help file to link to this new documentation.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 