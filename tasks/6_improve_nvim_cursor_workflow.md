# Task 6: Improve Neovim and External Editor Workflow

## Description

The current workflow when using Neovim alongside an external editor (like Cursor) is suboptimal. Two key issues need to be addressed:
1.  Buffers in Neovim become stale when files are modified externally. A manual refresh is required.
2.  There is no easy way to trigger a consistent formatting pass on all changed files before saving.

The goal of this task is to create a more seamless experience by automating these two aspects.

## Plan

1.  **Automatic Buffer Refresh**:
    -   Create a Neovim autocmd that triggers on `FocusGained`.
    -   This autocmd will execute the `:checktime` command, which prompts Neovim to check for and reload any files that have been modified on disk.
    -   This will ensure that buffers are automatically refreshed when switching back to Neovim.

2.  **Format on Save All**:
    -   Create a new custom user command (e.g., `:FormatAndSaveAll`).
    -   This command will iterate through all open buffers.
    -   For each modifiable buffer, it will trigger the LSP formatting command (`vim.lsp.buf.format`).
    -   After attempting to format all buffers, it will execute `:wall` to save all changes.
    -   This provides a single, reliable command to format and save the entire session state.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 