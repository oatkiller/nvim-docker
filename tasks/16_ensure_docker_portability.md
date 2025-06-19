# Task 16: Ensure Docker Image Portability

## Description

The "AI Notes" in `TODO.md` point out that Docker images are architecture-specific. To ensure the `nvim-docker` environment works for users on different CPU architectures (like x86_64 for most Linux/WSL users and ARM64 for Apple Silicon Mac users), the Docker image must be built for multiple architectures.

The goal of this task is to modify the Docker build process to produce a multi-architecture image.

## Plan

1.  **Use a Multi-Arch Base Image**:
    -   Review the `Dockerfile`. Ensure the `FROM` instruction uses an official base image that is already multi-arch. The official `neovim/neovim` images are a good choice. For example: `FROM neovim/neovim:stable`.
2.  **Set Up Docker Buildx**:
    -   The build process should use `docker buildx`, which is Docker's tool for building multi-architecture images.
    -   Create a new builder instance that can compile for multiple platforms: `docker buildx create --name multi-arch-builder --use`.
3.  **Modify the Build Command**:
    -   Update the build command in the `Makefile` or any build scripts to use `docker buildx build`.
    -   The command should specify the target platforms, for example: `docker buildx build --platform linux/amd64,linux/arm64 -t your-repo/nvim-docker:latest --push .`.
    -   The `--push` flag is necessary to push the multi-arch manifest to a container registry (like Docker Hub or GitHub Container Registry).
4.  **Update Documentation**:
    -   Update the `README.md` and any other relevant docs to mention the multi-architecture support.
    -   Explain any prerequisites for users (though typically `docker pull` will automatically select the correct architecture).

## Reference

Remember to follow the development principles outlined in [AI_README.md](mdc:AI_README.md). 