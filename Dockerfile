ARG NVIM_CONFIG
FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl unzip git ripgrep fd-find build-essential libtool libtool-bin \
    ca-certificates bat golang-go && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js LTS version
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# Install TypeScript LSP and TypeScript
RUN npm install -g typescript-language-server typescript

# Install Tailwind CSS Language Server
RUN npm install -g @tailwindcss/language-server

# Install Neovim ARM64 version
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-arm64.tar.gz && \
    tar xzf nvim-linux-arm64.tar.gz && \
    mv nvim-linux-arm64 /opt/nvim && \
    ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim

# Copy Neovim config into container
COPY nvim-config/ /root/.config/nvim/

# nvim-cmp and sources
RUN mkdir -p /root/.config/nvim/pack/cmp/start
RUN git clone https://github.com/hrsh7th/nvim-cmp /root/.config/nvim/pack/cmp/start/nvim-cmp
RUN git clone https://github.com/hrsh7th/cmp-nvim-lsp /root/.config/nvim/pack/cmp/start/cmp-nvim-lsp
RUN git clone https://github.com/hrsh7th/cmp-buffer /root/.config/nvim/pack/cmp/start/cmp-buffer
RUN git clone https://github.com/hrsh7th/cmp-path /root/.config/nvim/pack/cmp/start/cmp-path
RUN git clone https://github.com/hrsh7th/cmp-cmdline /root/.config/nvim/pack/cmp/start/cmp-cmdline
RUN git clone https://github.com/hrsh7th/cmp-vsnip /root/.config/nvim/pack/cmp/start/cmp-vsnip
RUN git clone https://github.com/petertriho/cmp-git /root/.config/nvim/pack/cmp/start/cmp-git

# lspconfig
RUN mkdir -p /root/.config/nvim/pack/lsp/start
RUN git clone https://github.com/neovim/nvim-lspconfig /root/.config/nvim/pack/lsp/start/nvim-lspconfig
COPY pack/lsp/start/lsp-config/plugin/lsp_config.lua /root/.config/nvim/pack/lsp/start/lsp-config/plugin/lsp_config.lua

# fzf and fzf.vim
RUN mkdir -p /root/.config/nvim/pack/fzf/start
RUN git clone https://github.com/junegunn/fzf.git /root/.config/nvim/pack/fzf/start/fzf
RUN cd /root/.config/nvim/pack/fzf/start/fzf && make install
RUN git clone https://github.com/ibhagwan/fzf-lua.git /root/.config/nvim/pack/fzf/start/fzf-lua
COPY pack/fzf/start/fzf-lua-config/plugin/fzf-lua-config.lua /root/.config/nvim/pack/fzf/start/fzf-lua-config/plugin/fzf-lua-config.lua

# which-key.nvim
RUN mkdir -p /root/.config/nvim/pack/which-key/start
RUN git clone https://github.com/folke/which-key.nvim /root/.config/nvim/pack/which-key/start/which-key.nvim

# nvim-tree.lua
RUN mkdir -p /root/.config/nvim/pack/nvim-tree/start
RUN git clone https://github.com/nvim-tree/nvim-tree.lua.git /root/.config/nvim/pack/nvim-tree/start/nvim-tree.lua
RUN git clone https://github.com/nvim-tree/nvim-web-devicons.git /root/.config/nvim/pack/nvim-tree/start/nvim-web-devicons
RUN nvim -u NONE --headless -c "helptags /root/.config/nvim/pack/nvim-tree/start/nvim-tree.lua/doc" -c q

# none-ls and plenary (native package management)
RUN mkdir -p /root/.config/nvim/pack/none-ls/start
RUN git clone https://github.com/nvim-lua/plenary.nvim /root/.config/nvim/pack/none-ls/start/plenary.nvim
RUN git clone https://github.com/nvimtools/none-ls.nvim /root/.config/nvim/pack/none-ls/start/none-ls.nvim

# none-ls-extras (native package management)
RUN mkdir -p /root/.config/nvim/pack/none-ls-extras/start
RUN git clone https://github.com/nvimtools/none-ls-extras.nvim /root/.config/nvim/pack/none-ls-extras/start/none-ls-extras.nvim

# Copy custom configs
COPY pack/none-ls-config/start/none-ls-config/plugin/none_ls.lua /root/.config/nvim/pack/none-ls-config/start/none-ls-config/plugin/none_ls.lua
COPY pack/nvim-tree/start/nvim-tree-config/plugin/nvim-tree-config.lua /root/.config/nvim/pack/nvim-tree/start/nvim-tree-config/plugin/nvim-tree-config.lua
COPY pack/cmp/start/cmp-config/plugin/cmp_config.lua /root/.config/nvim/pack/cmp/start/cmp-config/plugin/cmp_config.lua

# Install Prettier and ESLint_D globally
RUN npm install -g prettier eslint_d

# nvim-lsp-file-operations
RUN mkdir -p /root/.config/nvim/pack/lsp-file-ops/start
RUN git clone https://github.com/antosha417/nvim-lsp-file-operations.git /root/.config/nvim/pack/lsp-file-ops/start/nvim-lsp-file-operations
COPY pack/lsp-file-ops/start/lsp-file-ops-config/plugin/lsp-file-ops-config.lua /root/.config/nvim/pack/lsp-file-ops/start/lsp-file-ops-config/plugin/lsp-file-ops-config.lua

# CopilotChat.nvim
RUN mkdir -p /root/.config/nvim/pack/copilot/start
RUN git clone https://github.com/CopilotC-Nvim/CopilotChat.nvim.git /root/.config/nvim/pack/copilot/start/CopilotChat.nvim
COPY pack/copilot/copilot-config/plugin/copilot_completeopt.lua /root/.config/nvim/pack/copilot/start/copilot-config/plugin/copilot_completeopt.lua

# nvim-treesitter
RUN mkdir -p /root/.config/nvim/pack/nvim-treesitter/start
RUN git clone https://github.com/nvim-treesitter/nvim-treesitter.git /root/.config/nvim/pack/nvim-treesitter/start/nvim-treesitter
RUN git clone https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git /root/.config/nvim/pack/nvim-treesitter/start/nvim-treesitter-textobjects
RUN mkdir -p /root/.config/nvim/pack/nvim-treesitter/start/nvim-treesitter-config/plugin
COPY pack/nvim-treesitter/start/nvim-treesitter-config/plugin/nvim-treesitter-config.lua /root/.config/nvim/pack/nvim-treesitter/start/nvim-treesitter-config/plugin/nvim-treesitter-config.lua

# ts-comments
RUN mkdir -p /root/.config/nvim/pack/ts-comments/start
RUN git clone https://github.com/folke/ts-comments.nvim.git /root/.config/nvim/pack/ts-comments/start/ts-comments.nvim
RUN mkdir -p /root/.config/nvim/pack/ts-comments/start/ts-comments-config/plugin
COPY pack/ts-comments/start/ts-comments-config/plugin/ts-comments-config.lua /root/.config/nvim/pack/ts-comments/start/ts-comments-config/plugin/ts-comments-config.lua

# OatHealth Plugin
COPY pack/oathealth/start/oathealth/lua/oathealth/health.lua /root/.config/nvim/pack/oathealth/start/oathealth/lua/oathealth/health.lua

CMD ["bash"]

