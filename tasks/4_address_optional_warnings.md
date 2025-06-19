# Task 4: Address Optional Dependency Warnings

## Description

The `:checkhealth` output shows several warnings for missing optional dependencies:
- `CopilotChat: WARNING lynx: missing, optional for improved fetching of url contents.`
- `CopilotChat: WARNING tiktoken_core: missing, optional for accurate token counting.`
- `nvim-treesitter: WARNING \`tree-sitter\` executable not found (parser generator, only needed for :TSInstallFromGrammar)`

While these are optional, installing them will provide a more complete and feature-rich environment.

The goal of this task is to add the installation steps for these optional dependencies to the installation scripts.

## Plan

1.  **`lynx`**:
    -   Research the recommended way to install `lynx` on Windows. This is likely available via a package manager like Chocolatey (`choco install lynx`).
    -   Add the installation command to `install_on_windows.ps1`.
    -   Add the corresponding installation command to the `Dockerfile` and `install_on_mac_osx.sh` for consistency.

2.  **`tiktoken_core`**:
    -   The `CopilotChat.nvim` documentation should provide instructions for installing `tiktoken_core`. This typically involves a Rust/Cargo build step.
    -   Ensure that the necessary build tools (like `rustc` and `cargo`) are installed by the scripts.
    -   Add the commands to build and install `tiktoken_core` to all three installation scripts (`install_on_windows.ps1`, `install_on_mac_osx.sh`, `Dockerfile`).

3.  **`tree-sitter-cli`**:
    -   The `tree-sitter` executable is the Tree-sitter CLI. It is usually installed via `npm`.
    -   Add `npm install -g tree-sitter-cli` to all three installation scripts.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 