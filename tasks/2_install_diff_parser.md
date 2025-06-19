# Task 2: Install Missing 'diff' Treesitter Parser

## Description

The `:checkhealth` output for `CopilotChat.nvim` includes a warning:
- `WARNING treesitter[diff]: missing, optional for better diff highlighting. Install \`nvim-treesitter/nvim-treesitter\` plugin and run \`:TSInstall diff\`.`

While this is an optional dependency, fixing it will improve the user experience by providing better syntax highlighting for diffs within the editor.

The goal of this task is to ensure the `diff` Treesitter parser is installed automatically.

## Plan

1.  Locate the Treesitter configuration file. Based on the project structure, this is likely `pack/nvim-treesitter/start/nvim-treesitter-config/plugin/nvim-treesitter-config.lua`.
2.  In this file, find the `ensure_installed` table within the `treesitter.setup` block.
3.  Add `'diff'` to the list of parsers to be installed automatically.
4.  This change will apply to all installations (Docker, macOS, Windows) as it's part of the shared Neovim configuration.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 