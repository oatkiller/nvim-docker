---
description: Governs the root directory of the nvim-docker project.
globs: '*'
alwaysApply: true
---

- **Main Goal**: The root directory contains the primary files for building and installing the Neovim environment. It serves as the entry point for the installation process across different platforms.

- **Key Files**:
    - `Dockerfile`: Defines the Docker image for the Neovim environment.
    - `install_on_mac_osx.sh`: Installation script for macOS.
    - `install_on_windows.ps1`: Installation script for Windows.
    - `Makefile`: Provides convenience commands for building and running the Docker image.
    - `README.md`: General information about the project.
    - `AI_README.md`: **Source of truth** for AI-assisted plugin management and development workflow. All rules are derived from this file.

---

### Subdirectory Rules
Rules for subdirectories go in the subdirectory nested in `.cursor/rules`. e.g. for `nvim-config` rules, put them in `nvim-config/.cursor/rules`. See @https://docs.cursor.com/context/rules#project-rules

### Adding a New Feature (e.g., a new plugin)

- **Process**: Adding a new feature, like a plugin, requires updating the installation scripts to ensure it's included in the final Neovim configuration.
    1. **Modify `pack`**: First, add the plugin and its configuration to the `pack/` directory following the guidelines in its own [rules](mdc:pack/.cursor/rules/pack.md).
    2. **Update Install Scripts**:
        - **`install_on_mac_osx.sh`**: Add the necessary `git clone` and `cp`/`mkdir` commands to install the new plugin and its configuration.
        - **`install_on_windows.ps1`**: Add the corresponding `Install-Plugin` call or other PowerShell commands.
        - **`Dockerfile`**: Add the `git clone` and `COPY` commands to the `Dockerfile`.
    3. **Update Documentation**: Update or create new documentation in `nvim-config/doc` following the guidelines in its [rules](mdc:nvim-config/.cursor/rules/config.md) and update health checks in `pack/oathealth` if applicable.

### Maintaining Files

- **Consistency is Key**: When updating one installation script (e.g., `Dockerfile`), ensure that the others (`install_on_mac_osx.sh`, `install_on_windows.ps1`) are updated with equivalent changes to maintain platform consistency.
- **`AI_README.md`**: If the core development process changes, update `AI_README.md` first, then propagate those changes to the other rules.

### Deleting a Feature

- **Reverse the Process**: To remove a feature, reverse the steps for adding it.
    1. **Remove from `pack`**: Delete the plugin and its configuration from the `pack/` directory.
    2. **Update Install Scripts**: Remove the corresponding lines from `install_on_mac_osx.sh`, `install_on_windows.ps1`, and `Dockerfile`.
    3. **Clean Documentation**: Remove any related documentation from `nvim-config/doc` and health checks. 