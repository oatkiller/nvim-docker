# Task 10: Refactor Helptags Autogeneration

## Description

The Lua code responsible for automatically generating helptags for documentation in `nvim-config/doc/` is currently in `init.lua`. This is a piece of core functionality that can be better organized as its own plugin within a dedicated "doc management" pack.

The goal of this task is to extract the helptags autogeneration logic into a new, dedicated plugin.

## Plan

1.  **Create a New Pack**:
    -   Create a new directory for documentation-related utilities: `pack/doc-tools/`.
2.  **Create the Plugin**:
    -   Create the plugin structure: `pack/doc-tools/start/helptags-manager/plugin/`.
    -   Create the Lua file: `helptags.lua`.
3.  **Move the Logic**:
    -   Identify and cut the `autocmd` and related logic for generating helptags from `init.lua`.
    -   Paste this logic into `helptags.lua`. Ensure it is self-contained.
4.  **Update Install Scripts**: Add the necessary `mkdir` and `cp` commands to `Dockerfile`, `install_on_mac_osx.sh`, and `install_on_windows.ps1` to create the new `helptags-manager` plugin directory and file during installation.
5.  **Test**: Restart Neovim, modify a file in `nvim-config/doc/`, and restart again to ensure that helptags are still being generated correctly. You can verify this by trying to `:help` a newly added tag.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 