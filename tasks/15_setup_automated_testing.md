# Task 15: Set Up Automated Testing for Installers

## Description

The configuration currently lacks automated testing for its installation scripts. This makes it difficult to ensure that the installers work correctly across different platforms (macOS, Windows/WSL, Linux) and that all plugins are installed and loaded without errors.

The goal of this task is to set up a CI/CD pipeline (e.g., using GitHub Actions) to automate the testing of the installers.

## Plan

1.  **Create a CI Workflow File**:
    -   Create a new GitHub Actions workflow file under `.github/workflows/ci.yml`.
2.  **Define Test Matrix**:
    -   Set up a test matrix to run jobs on different operating systems: `ubuntu-latest`, `macos-latest`, and a Windows environment suitable for WSL.
3.  **Implement Test Steps for Each OS**:
    -   For each OS in the matrix, the job should:
        -   Check out the repository code.
        -   Run the corresponding installer script (`install_on_mac_osx.sh`, `install_on_windows.ps1` within WSL, or the Docker build).
        -   Run Neovim in a headless mode to execute a test script.
4.  **Create a Headless Test Script**:
    -   Create a Lua script (e.g., `scripts/test.lua`) that Neovim can execute with `nvim --headless -c "luafile scripts/test.lua"`.
    -   This script should:
        -   Attempt to load all expected plugins.
        -   Run `:checkhealth` and parse the output for any `ERROR` or `WARNING` messages.
        -   Exit with a non-zero status code if any errors are found, causing the CI job to fail.
5.  **Use the Test Suite as a Source of Truth**: The test script should define the list of "officially supported" packs that must pass the health checks on all platforms.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 