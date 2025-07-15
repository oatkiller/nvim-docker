
# Using Neovim with Docker

This repository provides a blueprint and installer scripts to build and run a complete, ready-to-use Neovim environment using Docker. Follow the steps below to build the Docker image and run Neovim inside a container.

## 1. Build the Docker Image

You can build the Docker image using the provided `Makefile` or directly with Docker:

**Using Makefile:**
```sh
make build
```

**Or directly with Docker:**
```sh
docker build . -t nvim-docker
```

This will create a Docker image named `nvim-docker` with all required dependencies, plugins, and configuration.

## 2. Run Neovim in Docker

You can run Neovim inside the Docker container using the Makefile or directly with Docker:

**Using Makefile:**
```sh
make run
```

**Or directly with Docker:**
```sh
docker run -it --rm --name nvim-container -v $(pwd):/workspace nvim-docker
```

This will start a container, mount your current directory to `/workspace` inside the container, and launch Neovim.

## 3. (Recommended) Use the Provided Script

For convenience, a script is provided to make running Neovim in Docker as easy as running a local command:

### Install the Script

```sh
make install
```

This will copy the script to `~/.local/bin/nvim-docker` and make it executable. Ensure `~/.local/bin` is in your `$PATH`.

### Usage

From any project directory, simply run:
```sh
nvim-docker
```

This will launch Neovim inside the Docker container, mounting your current working directory for seamless editing.

You can pass any arguments to Neovim as usual:
```sh
nvim-docker myfile.txt
```

## 4. Health Check (Optional)

To check the health of your Neovim environment (including custom health checks):

```sh
make checkhealth
```

This will run Neovim's health checks inside the Docker container.

---

**Note:**
- The Dockerfile is configured for Apple Silicon (ARM64). If you are on x86-64, you may need to adjust the Neovim download URL in the Dockerfile.
- All plugins and configuration are managed via the `pack` and `nvim-config` directories and are automatically set up during the Docker build.
- For more details on the structure and plugin management, see [CONTRIBUTING.md](CONTRIBUTING.md).
