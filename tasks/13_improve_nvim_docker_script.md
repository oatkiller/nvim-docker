# Task 13: Improve nvim-docker Script

## Description

The "AI Notes" in `TODO.md` identified several issues with the `scripts/nvim-docker` script that limit its usability and robustness.
- It uses a static container name (`nvim-docker`), preventing multiple instances from running.
- It only mounts the current working directory (`$PWD`), preventing access to files outside this directory.

The goal of this task is to refactor the `scripts/nvim-docker` script to address these limitations.

## Plan

1.  **Use Unique Container Names**:
    -   Modify the `docker run` command to generate a unique container name for each invocation. A simple way is to use the process ID or a timestamp, e.g., `--name nvim-docker-$$`.
2.  **Mount Home Directory**:
    -   Change the volume mount from `-v "$PWD":/workspace` to `-v "$HOME":"$HOME"`.
    -   Keep the working directory as `-w "$PWD"` to ensure the user starts in the directory where they ran the script.
    -   This allows Neovim inside the container to access any file the user has permission to access on their host machine.
3.  **Update Script Logic**:
    -   The script should be able to accept a file or directory as an argument and open Neovim with it. The `"$@"` at the end of the `nvim` command already handles this.
4.  **Add Documentation**: Add comments to the script explaining the changes, especially the mounting strategy and unique container naming.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 