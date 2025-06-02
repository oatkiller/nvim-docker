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

# Install nvim-lspconfig plugin
mkdir -p ~/.config/nvim/pack/nvim/start
if [ ! -d ~/.config/nvim/pack/nvim/start/nvim-lspconfig ]; then
  git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig
fi

# Install fzf binary and vim plugin
if [ ! -d ~/.config/nvim/pack/nvim/start/fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.config/nvim/pack/nvim/start/fzf
  ~/.config/nvim/pack/nvim/start/fzf/install --bin
fi

# Install fzf.vim plugin
if [ ! -d ~/.config/nvim/pack/nvim/start/fzf.vim ]; then
  git clone https://github.com/junegunn/fzf.vim ~/.config/nvim/pack/nvim/start/fzf.vim
fi

echo "Neovim config and plugins installed!" 