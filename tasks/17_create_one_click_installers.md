# Task 17: Create One-Click Installers for CI/CD

## Description

To properly implement automated testing (Task 15), we require "one-click" installer scripts for each platform that can set up a complete development environment from a clean slate. These scripts need to handle system-level dependencies, including the installation of package managers if they are not already present.

The goal of this task is to create master setup scripts for Windows and macOS that are capable of running both interactively for users and non-interactively for CI environments.

## Plan

1.  **Create Master Setup Scripts**:
    -   Create `setup_windows.ps1` for Windows.
    -   Create `setup_macos.sh` for macOS.
    -   These scripts will serve as the primary entry point for any new environment setup.

2.  **Implement Automatic Package Manager Installation**:
    -   In `setup_windows.ps1`, add logic to detect if Chocolatey is installed. If not, the script should install it automatically.
    -   In `setup_macos.sh`, add logic to detect if Homebrew is installed. If not, the script should install it.

3.  **Automate Dependency Installation**:
    -   After ensuring the package manager is present, use it to install all required system-level dependencies (e.g., `git`, `ripgrep`, `fd`, `node`, `go`, etc.).

4.  **Integrate Project Installation**:
    -   Once system dependencies are installed, the master scripts should call the existing project installers (`install_on_windows.ps1` and `install_on_mac_osx.sh`).

5.  **Support Interactive and Non-Interactive Modes**:
    -   **Non-Interactive (`-y`/`--yes`)**: The scripts must support a flag that bypasses all user prompts, making them suitable for silent execution in a CI pipeline.
    -   **Interactive (Default)**: Without the flag, the scripts should prompt the user for confirmation before performing major actions, such as installing a package manager or removing existing configurations.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 