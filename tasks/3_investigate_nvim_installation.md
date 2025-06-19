# Task 3: Improve Installer Cleanup Logic for Windows and macOS

## Description

The original problem was a `:checkhealth nvim` error on Windows indicating old runtime files, which suggests an incomplete or "dirty" installation. To prevent this and other potential issues from stale configurations or caches, the installers for both Windows and macOS need a more robust cleanup mechanism.

The goal of this task is to enhance the `-Force` option in both installers to perform a comprehensive backup and removal of all Neovim-related directories before proceeding with a fresh installation.

## Plan

1.  Review `install_on_windows.ps1` and `install_on_mac_osx.sh` to understand their current installation and cleanup logic, especially how the `-Force` parameter is handled.
2.  Identify all standard Neovim directories that should be part of the cleanup process. This includes:
    -   **Configuration**: `~/.config/nvim` (macOS/Linux) or `~/AppData/Local/nvim` (Windows).
    -   **Data/State**: `~/.local/share/nvim` (macOS/Linux) or `~/AppData/Local/nvim-data` (Windows).
    -   **Cache**: `~/.cache/nvim` (macOS/Linux) or `~/AppData/Local/nvim-data/cache` (Windows).
3.  Modify the `-Force` logic in both scripts:
    -   Instead of just deleting the directories, the script should first **back them up** with a timestamp (e.g., `nvim-backup-YYYYMMDD-HHMMSS`).
    -   After a successful backup, the script should completely remove the original directories to ensure a clean slate.
4.  Apply these changes to `install_on_windows.ps1`.
5.  Apply the same backup-and-remove logic to `install_on_mac_osx.sh` to ensure consistent behavior across platforms.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 