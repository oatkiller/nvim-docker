ARG NVIM_CONFIG
FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl unzip git ripgrep fd-find tmux build-essential libtool libtool-bin \
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

# Install nvim-lspconfig plugin
RUN git clone https://github.com/neovim/nvim-lspconfig /root/.config/nvim/pack/nvim/start/nvim-lspconfig

# install fzf binary and vim plugin
RUN git clone https://github.com/junegunn/fzf.git /root/.config/nvim/pack/nvim/start/fzf \
    && cd /root/.config/nvim/pack/nvim/start/fzf \
    && make install

# Install fzf.vim vim plugin
RUN git clone https://github.com/junegunn/fzf.vim /root/.config/nvim/pack/nvim/start/fzf.vim

WORKDIR /workspace
CMD ["bash"]

