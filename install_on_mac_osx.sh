#!/usr/bin/env bash
set -e

# List of required dependencies
REQUIRED=(curl unzip git rg fd go bat node npm nvim)

# Check for missing dependencies
MISSING=()
for dep in "${REQUIRED[@]}"; do
  if ! command -v "$dep" >/dev/null 2>&1; then
    MISSING+=("$dep")
  fi
done

if [ ${#MISSING[@]} -ne 0 ]; then
  echo "Missing dependencies: ${MISSING[*]}"
  echo "Please install them using Homebrew:"
  echo "  brew install ${MISSING[*]}"
  echo "(For node and npm: brew install node)"
  exit 1
fi

# Check Node.js version (require >=20)
NODE_VERSION=$(node -v | sed 's/v//;s/\..*//')
if [ "$NODE_VERSION" -lt 20 ]; then
  echo "Node.js version >= 20 is required. Please upgrade:"
  echo "  brew upgrade node"
  exit 1
fi

# Install global npm packages for LSPs
echo "Installing global npm packages: typescript-language-server, typescript, @tailwindcss/language-server, prettier, eslint_d"
npm install -g typescript-language-server typescript @tailwindcss/language-server prettier eslint_d

# Parse arguments for -f or --force
FORCE=0
for arg in "$@"; do
  if [ "$arg" = "-f" ] || [ "$arg" = "--force" ]; then
    FORCE=1
  fi
done

# Check if ~/.config/nvim exists
if [ -d "$HOME/.config/nvim" ]; then
  if [ $FORCE -eq 1 ]; then
    echo "[FORCE] Deleting existing ~/.config/nvim..."
    rm -rf "$HOME/.config/nvim"
  else
    echo "[WARNING] ~/.config/nvim already exists."
    echo "Running this script will overwrite your existing Neovim config."
    echo "If you want to keep your current config, move or delete it first."
    echo "Sample commands:"
    echo "  mv ~/.config/nvim ~/.config/nvim.bak"
    echo "  rm -rf ~/.config/nvim"
    exit 1
  fi
fi

# Copy nvim-config to ~/.config/nvim
mkdir -p ~/.config/nvim
cp -R ./nvim-config/* ~/.config/nvim/

# nvim-cmp and sources
mkdir -p ~/.config/nvim/pack/cmp/start/cmp-config/lua
cp ./pack/nvim-cmp/start/cmp-config/lua/cmp_config.lua ~/.config/nvim/pack/cmp/start/cmp-config/lua/cmp_config.lua
if [ ! -d ~/.config/nvim/pack/cmp/start/nvim-cmp ]; then
  git clone https://github.com/hrsh7th/nvim-cmp ~/.config/nvim/pack/cmp/start/nvim-cmp
fi
if [ ! -d ~/.config/nvim/pack/cmp/start/cmp-nvim-lsp ]; then
  git clone https://github.com/hrsh7th/cmp-nvim-lsp ~/.config/nvim/pack/cmp/start/cmp-nvim-lsp
fi
if [ ! -d ~/.config/nvim/pack/cmp/start/cmp-buffer ]; then
  git clone https://github.com/hrsh7th/cmp-buffer ~/.config/nvim/pack/cmp/start/cmp-buffer
fi
if [ ! -d ~/.config/nvim/pack/cmp/start/cmp-path ]; then
  git clone https://github.com/hrsh7th/cmp-path ~/.config/nvim/pack/cmp/start/cmp-path
fi
if [ ! -d ~/.config/nvim/pack/cmp/start/cmp-cmdline ]; then
  git clone https://github.com/hrsh7th/cmp-cmdline ~/.config/nvim/pack/cmp/start/cmp-cmdline
fi
if [ ! -d ~/.config/nvim/pack/cmp/start/cmp-vsnip ]; then
  git clone https://github.com/hrsh7th/cmp-vsnip ~/.config/nvim/pack/cmp/start/cmp-vsnip
fi
if [ ! -d ~/.config/nvim/pack/cmp/start/cmp-git ]; then
  git clone https://github.com/petertriho/cmp-git ~/.config/nvim/pack/cmp/start/cmp-git
fi

# lspconfig
mkdir -p ~/.config/nvim/pack/lsp/start
if [ ! -d ~/.config/nvim/pack/lsp/start/nvim-lspconfig ]; then
  git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/lsp/start/nvim-lspconfig
fi

# fzf and fzf.vim
mkdir -p ~/.config/nvim/pack/fzf/start
if [ ! -d ~/.config/nvim/pack/fzf/start/fzf ]; then
  git clone https://github.com/junegunn/fzf.git ~/.config/nvim/pack/fzf/start/fzf
  ~/.config/nvim/pack/fzf/start/fzf/install --bin
fi
if [ ! -d ~/.config/nvim/pack/fzf/start/fzf.vim ]; then
  git clone https://github.com/junegunn/fzf.vim ~/.config/nvim/pack/fzf/start/fzf.vim
fi

# none-ls and plenary (native package management)
mkdir -p ~/.config/nvim/pack/none-ls/start
if [ ! -d ~/.config/nvim/pack/none-ls/start/plenary.nvim ]; then
  git clone https://github.com/nvim-lua/plenary.nvim ~/.config/nvim/pack/none-ls/start/plenary.nvim
fi
if [ ! -d ~/.config/nvim/pack/none-ls/start/none-ls.nvim ]; then
  git clone https://github.com/nvimtools/none-ls.nvim ~/.config/nvim/pack/none-ls/start/none-ls.nvim
fi

# none-ls-extras (native package management)
mkdir -p ~/.config/nvim/pack/none-ls-extras/start
if [ ! -d ~/.config/nvim/pack/none-ls-extras/start/none-ls-extras.nvim ]; then
  git clone https://github.com/nvimtools/none-ls-extras.nvim ~/.config/nvim/pack/none-ls-extras/start/none-ls-extras.nvim
fi

# Custom none-ls config (native package management)
mkdir -p ~/.config/nvim/pack/none-ls-config/start/none-ls-config/plugin
cp ./pack/none-ls-config/start/none-ls-config/plugin/none_ls.lua ~/.config/nvim/pack/none-ls-config/start/none-ls-config/plugin/none_ls.lua

# which-key.nvim
mkdir -p ~/.config/nvim/pack/which-key/start
if [ ! -d ~/.config/nvim/pack/which-key/start/which-key.nvim ]; then
  git clone https://github.com/folke/which-key.nvim ~/.config/nvim/pack/which-key/start/which-key.nvim
fi

# nvim-tree.lua
mkdir -p ~/.config/nvim/pack/nvim-tree/start
if [ ! -d ~/.config/nvim/pack/nvim-tree/start/nvim-tree.lua ]; then
  git clone https://github.com/nvim-tree/nvim-tree.lua.git ~/.config/nvim/pack/nvim-tree/start/nvim-tree.lua
  nvim -u NONE --headless -c "helptags ~/.config/nvim/pack/nvim-tree/start/nvim-tree.lua/doc" -c q
fi
if [ ! -d ~/.config/nvim/pack/nvim-tree/start/nvim-web-devicons ]; then
  git clone https://github.com/nvim-tree/nvim-web-devicons.git ~/.config/nvim/pack/nvim-tree/start/nvim-web-devicons
fi

# Custom nvim-tree config (native package management)
mkdir -p ~/.config/nvim/pack/nvim-tree/start/nvim-tree-config/lua
cp ./pack/nvim-tree/start/nvim-tree-config/lua/nvim-tree-config.lua ~/.config/nvim/pack/nvim-tree/start/nvim-tree-config/lua/nvim-tree-config.lua

# nvim-lsp-file-operations
mkdir -p ~/.config/nvim/pack/lsp-file-ops/start
if [ ! -d ~/.config/nvim/pack/lsp-file-ops/start/nvim-lsp-file-operations ]; then
  git clone https://github.com/antosha417/nvim-lsp-file-operations.git ~/.config/nvim/pack/lsp-file-ops/start/nvim-lsp-file-operations
fi

# Custom lsp-file-ops config (native package management)
mkdir -p ~/.config/nvim/pack/lsp-file-ops/start/lsp-file-ops-config/lua
cp ./pack/lsp-file-ops/start/lsp-file-ops-config/lua/lsp-file-ops-config.lua ~/.config/nvim/pack/lsp-file-ops/start/lsp-file-ops-config/lua/lsp-file-ops-config.lua

# CopilotChat.nvim
mkdir -p ~/.config/nvim/pack/copilot/start
if [ ! -d ~/.config/nvim/pack/copilot/start/CopilotChat.nvim ]; then
  git clone https://github.com/CopilotC-Nvim/CopilotChat.nvim.git ~/.config/nvim/pack/copilot/start/CopilotChat.nvim
fi

# Custom Copilot completeopt config (native package management)
mkdir -p ~/.config/nvim/pack/copilot/start/copilot-config/lua
cp ./pack/copilot/copilot-config/lua/copilot_completeopt.lua ~/.config/nvim/pack/copilot/start/copilot-config/lua/copilot_completeopt.lua

echo "Neovim config and plugins installed!" 