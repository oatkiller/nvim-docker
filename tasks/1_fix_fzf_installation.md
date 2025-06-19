# Task 1: Fix fzf Installation on Windows

## Description

The `:checkhealth` output shows two critical errors related to `fzf`:
1.  `fzf_lua: ERROR One of \`fzf\`, \`sk\` is required`
2.  `oathealth: ERROR fzf is not installed.`

This indicates that the `fzf` binary is not correctly installed or not available in the system's `PATH` on Windows. The `oathealth` check suggests running an installation script located within the `fzf` plugin's directory.

The goal of this task is to ensure `fzf` is properly installed by the Windows installation script.

## Plan

1.  Investigate the `install_on_windows.ps1` script to understand how plugins, specifically `fzf`, are installed.
2.  Locate the `fzf` plugin directory, which is likely cloned from a Git repository (e.g., `junegunn/fzf`).
3.  The `fzf` repository contains an install script (`install.ps1`) that needs to be executed to build/install the `fzf` binary.
4.  Modify `install_on_windows.ps1` to execute the `fzf` installation script after cloning the repository.
5.  Ensure the script handles the installation idempotently and correctly adds `fzf` to the `PATH`.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 