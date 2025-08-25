# Task Interdependencies

Here is the list of tasks and their dependencies.

## Tier 1: Core Health and Installation

These tasks must be completed first as they address fundamental issues with the installation process and environment health.

1.  **[Task 3: Investigate Neovim Installation on Windows](mdc:tasks/3_investigate_nvim_installation.md)**
    -   **Priority**: Critical
    -   **Dependencies**: None.

2.  **[Task 1: Fix fzf Installation](mdc:tasks/1_fix_fzf_installation.md)**
    -   **Priority**: High
    -   **Dependencies**: Task 3.

4.  **[Task 4: Address Optional Dependency Warnings](mdc:tasks/4_address_optional_warnings.md)**
    -   **Priority**: Low
    -   **Dependencies**: Task 3.

## Tier 2: Configuration Refactoring

These tasks improve the structure and modularity of the codebase. They can be worked on after the core installation is stable.

5.  **[Task 8: Refactor nvim-tree Configuration](mdc:tasks/8_refactor_nvim_tree_config.md)**
    -   **Priority**: Medium
    -   **Dependencies**: None.

6.  **[Task 9: Refactor which-key Configuration](mdc:tasks/9_refactor_which_key_config.md)**
    -   **Priority**: Medium
    -   **Dependencies**: None.

7.  **[Task 10: Refactor Helptags Autogeneration](mdc:tasks/10_refactor_helptags_autogen.md)**
    -   **Priority**: Medium
    -   **Dependencies**: None.

## Tier 3: New Features & Bug Fixes

These tasks introduce new functionality or fix existing bugs.

8.  **[Task 5: Investigate TypeScript Language Server Refactor Bug](mdc:tasks/5_fix_ts_ls_refactor_bug.md)**
    -   **Priority**: High
    -   **Dependencies**: Tier 1 tasks.

9.  **[Task 6: Improve Neovim and External Editor Workflow](mdc:tasks/6_improve_nvim_cursor_workflow.md)**
    -   **Priority**: Medium
    -   **Dependencies**: None.

10. **[Task 11: Implement Mapping Conflict Detection](mdc:tasks/11_implement_mapping_conflict_detection.md)**
    -   **Priority**: Medium
    -   **Dependencies**: None.

## Tier 4: Installers & DevOps

These tasks focus on the build, test, and deployment infrastructure.

11. **[Task 13: Improve nvim-docker Script](mdc:tasks/13_improve_nvim_docker_script.md)**
    -   **Priority**: High
    -   **Dependencies**: None.

12. **[Task 16: Ensure Docker Image Portability](mdc:tasks/16_ensure_docker_portability.md)**
    -   **Priority**: High
    -   **Dependencies**: Task 13.

13. **[Task 17: Create One-Click Installers for CI/CD](mdc:tasks/17_create_one_click_installers.md)**
    -   **Priority**: Critical
    -   **Dependencies**: None.

14. **[Task 15: Set Up Automated Testing for Installers](mdc:tasks/15_setup_automated_testing.md)**
    -   **Priority**: High
    -   **Dependencies**: Task 16, Task 17.

## Tier 5: Documentation

These tasks are focused on improving the project's documentation.

15. **[Task 7: Update Documentation for All Packs](mdc:tasks/7_update_pack_documentation.md)**
    -   **Priority**: Low
    -   **Dependencies**: All refactoring and feature tasks.

16. **[Task 12: Refactor to a Centralized Plugin Loading Strategy](mdc:tasks/12_refactor_plugin_loading_strategy.md)**
    -   **Priority**: Low
    -   **Dependencies**: None. 