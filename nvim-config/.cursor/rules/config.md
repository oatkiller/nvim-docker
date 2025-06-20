---
description: Manages the `nvim-config` directory, which contains core configuration and documentation.
globs: '**'
alwaysApply: true
---

- **Main Goal**: This directory holds the central `init.lua` and all documentation and filetype-specific configurations. It is a blueprint for the files that will be placed in the user's `~/.config/nvim/` directory.

- **Directory Structure**:
    - `init.lua`: The main entry point for the Neovim configuration. It should be kept minimal, primarily loading other modules.
    - `doc/`: Contains all custom help documents.
    - `ftplugin/`: Holds filetype-specific plugin configurations.

---

### Managing Documentation (`doc`)

- **Purpose**: To provide integrated, searchable help for this specific Neovim configuration via `:help`.

- **Adding Documentation**:
    1.  **Create File**: Create a new `.txt` file in `doc/`.
    2.  **Add Helptag**: At the top of the file, add a title and a unique help tag (e.g., `*oatvim-my-feature*`).
    3.  **Link from Main Help**: Add a link to your new tag in `doc/oatvim.txt` so it's discoverable.
    4.  **Write Content**: Document the feature and link to the original plugin's help if available (e.g., `|plugin-help|`).
    5.  **No Manual Helptags**: The `:helptags` command runs automatically on startup.

- **Maintaining Documentation**:
    - Keep documentation in sync with plugin configuration changes.
    - Ensure all custom features and significant configurations are documented.

- **Deleting Documentation**:
    1.  **Remove File**: Delete the `.txt` file from `doc/`.
    2.  **Remove Link**: Remove the corresponding link from `doc/oatvim.txt`.

---

### Managing Filetype Plugins (`ftplugin`)

- **Purpose**: To apply settings for specific filetypes.

- **Adding Configuration**:
    - Create a new `.lua` file named after the filetype (e.g., `python.lua`).
    - Add your filetype-specific settings (options, autocommands, etc.) to this file.

- **Maintaining Configuration**:
    - Update these files as you refine settings for different languages or filetypes.

- **Deleting Configuration**:
    - Simply delete the corresponding `.lua` file from the `ftplugin` directory. 