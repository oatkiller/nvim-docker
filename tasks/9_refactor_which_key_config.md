# Task 9: Refactor which-key Configuration

## Description

Similar to the `nvim-tree` configuration, the setup for the `which-key` plugin is currently in `init.lua`. To maintain a modular and clean structure, this configuration should be moved to its dedicated configuration plugin.

The goal of this task is to relocate the `which-key` setup from `init.lua` to its corresponding pack config file.

## Plan

1.  **Locate `which-key` Pack**: First, identify the pack for `which-key`. Assuming it doesn't exist, a new one should be created (e.g., `pack/which-key/`).
2.  **Create Config Plugin**:
    -   Create a directory for the configuration plugin: `pack/which-key/start/which-key-config/plugin/`.
    -   Create the configuration file: `which-key-config.lua`.
3.  **Move Configuration**:
    -   Identify and cut the `which-key` setup code from `init.lua`.
    -   Paste this code into the newly created `which-key-config.lua`.
4.  **Update Install Scripts**: Add the necessary `mkdir` and `cp` commands to all installation scripts (`Dockerfile`, `install_on_mac_osx.sh`, `install_on_windows.ps1`) to create the new `which-key-config` plugin structure.
5.  **Test**: Restart Neovim and confirm that `which-key` continues to function correctly, showing keymap hints as expected.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 