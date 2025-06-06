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
echo "Installing global npm packages: typescript-language-server, typescript, @tailwindcss/language-server"
npm install -g typescript-language-server typescript @tailwindcss/language-server

# Check if ~/.config/nvim exists
if [ -d "$HOME/.config/nvim" ]; then
  echo "[WARNING] ~/.config/nvim already exists."
  echo "Running this script will overwrite your existing Neovim config."
  echo "If you want to keep your current config, move or delete it first."
  echo "Sample commands:"
  echo "  mv ~/.config/nvim ~/.config/nvim.bak"
  echo "  rm -rf ~/.config/nvim"
  exit 1
fi

# Copy nvim-config to ~/.config/nvim
mkdir -p ~/.config/nvim
cp -R ./nvim-config/* ~/.config/nvim/

# nvim-cmp and sources
mkdir -p ~/.config/nvim/pack/cmp/start
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

# which-key.nvim
mkdir -p ~/.config/nvim/pack/which-key/start
if [ ! -d ~/.config/nvim/pack/which-key/start/which-key.nvim ]; then
  git clone https://github.com/folke/which-key.nvim ~/.config/nvim/pack/which-key/start/which-key.nvim
fi

echo "Neovim config and plugins installed!" 