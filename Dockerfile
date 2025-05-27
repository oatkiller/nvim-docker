ARG NVIM_CONFIG
FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl unzip git ripgrep fd-find tmux build-essential libtool libtool-bin \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js LTS version
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# Install Neovim ARM64 version
RUN curl -LO https://github.com/neovim/neovim/releases/download/v0.11.1/nvim-linux-arm64.tar.gz && \
    tar xzf nvim-linux-arm64.tar.gz && \
    mv nvim-linux-arm64 /opt/nvim && \
    ln -s /opt/nvim/bin/nvim /usr/local/bin/nvim

# Copy Neovim config into container (for build-time plugin install)
COPY nvim-config/ /root/.config/nvim/

# Run Lazy.nvim sync to install plugins during build
RUN nvim --headless "+Lazy! sync" +qa

WORKDIR /workspace
CMD ["bash"]

