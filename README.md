# Neovim Plugins Installed

This project installs the following Neovim plugins directly (without a plugin manager):

| Plugin Name      | GitHub URL                                         | Description                                                      |
|------------------|----------------------------------------------------|------------------------------------------------------------------|
| nvim-lspconfig   | https://github.com/neovim/nvim-lspconfig           | Configurations for built-in LSP support in Neovim                |
| fzf              | https://github.com/junegunn/fzf                    | General-purpose command-line fuzzy finder, with Vim/Neovim plugin |
| fzf.vim          | https://github.com/junegunn/fzf.vim                | Vim/Neovim plugin that integrates fzf with useful commands        |
| nvim-cmp         | https://github.com/hrsh7th/nvim-cmp                  | Autocompletion plugin for Neovim                                      |

These plugins are installed automatically by the Dockerfile and the install_on_mac_osx.sh script. 

# Adding new plugins

To add a new plugin:

1. Add it to this README.md file
1. If the plugin requries dependencies, add those as well. When changing dependencies, evaluate the dependency graph and ensure the right dependencies are added.
2. Add lines to `Dockerfile` that git clone or otherwise add the plugin files to the container. Also add any required lines to run install commands. 
3. Add corresponding lines to `./install_on_mac_osx.sh` that install the same plugins / dependencies.