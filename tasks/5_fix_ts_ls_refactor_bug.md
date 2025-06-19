# Task 5: Investigate TypeScript Language Server Refactor Bug

## Description

A bug has been reported where code refactors performed by the TypeScript Language Server (`ts_ls`) occasionally produce incorrect import paths. For example, an import from `atoms.ts` might be incorrectly changed to `atomms.ts`.

This suggests a possible string manipulation or diff application error within the LSP client or a conflict with an automatic formatting tool like Prettier that runs on buffer writes.

The goal of this task is to identify the root cause of this bug and fix it.

## Plan

1.  **Reproduce the Bug**: Systematically try to reproduce the issue. This involves setting up a sample TypeScript project and performing various refactoring operations (e.g., renaming files, moving symbols).
2.  **Isolate the Cause**:
    -   Temporarily disable any format-on-save or on-write autocmds (`prettier`, etc.) to see if the issue persists. This will rule out conflicts with formatters.
    -   Examine the Neovim LSP logs (`:LspLog`) immediately after a failed refactor to inspect the raw workspace edit being sent by `ts_ls` and what Neovim is doing with it.
    -   Review the configuration for `lspconfig` and `null-ls` to check for any non-standard settings that might affect how workspace edits are applied.
3.  **Implement a Fix**: Based on the findings, implement a fix. This could involve adjusting LSP configuration, fixing an autocmd, or reporting a bug to the relevant plugin repository.

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 