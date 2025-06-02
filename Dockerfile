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

# fzf and fzf.vim
RUN mkdir -p /root/.config/nvim/pack/fzf/start
RUN git clone https://github.com/junegunn/fzf.git /root/.config/nvim/pack/fzf/start/fzf
RUN cd /root/.config/nvim/pack/fzf/start/fzf && make install
RUN git clone https://github.com/junegunn/fzf.vim /root/.config/nvim/pack/fzf/start/fzf.vim

CMD ["bash"]

