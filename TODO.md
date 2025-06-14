# TODO

- [ ] figure out why the import strings produced by ts_ls refactors are sometimes a few chars off. e.g. atoms.ts -> atomms.ts. Something like an overwrite or diff application issue. maybe something automatic like buffer write formatting via prettier conflicting?
- [ ] Come up with a better way to work with nvim and cursor at the same time. I need a command that refreshing all open buffers when i switch back to nvim. i also need a command that applies formatting to all open buffers when i do `:wall`.
- [ ] Update docs for all packs 
- [ ] Move nvim-tree keymap config from init.lua to its pack config
- [ ] Move which-key config from init.lua to its pack config
- [ ] Move helptags autogen code from init.lua to a new pack (doc management)
- [ ] Deal with missing deps for CopilotChat (see checkhealth for this plugin) 
- [ ] come up with a way to detect and fix mapping conflicts
- [ ] explain how to disable packs. enabling and disabling packs is done by changing the 'start' part of the path to 'opt' (i think.) its in the neovim documentation. 

# Done

- [x] get typescript and tsx motions working
- [x] Sometimes the <Leader>oi mapping isn't available, even when the related command is. 
- [x] Add code to the installer and dockerfile to pre-install needed treesitter parsers

# AI Notes

TODO: convert these to projects full of todo lists

Ran tool
Ran tool
Read file: scripts/nvim-docker
Here’s a detailed response to your points, with actionable recommendations and technical insights:

---

### 1. **Pack Enable/Disable (start/opt)**
- **Correct:** In Neovim, plugins in `pack/*/start/` are loaded automatically, while those in `pack/*/opt/` are only loaded manually (`:packadd`). This is a great, simple way to let users enable/disable packs.
- **Recommendation:** Document this in your README, and consider a helper script or CLI flag in your installer to move packs between `start` and `opt` for users.

---

### 2. **Configurable List of Packs**
- **Current:** You have an "opinionated" default set, which is good for onboarding.
- **Improvement:** Allow users to pass a config file or CLI flags to select packs at install time. You can still default to your curated set, but let advanced users override.

---

### 3. **`scripts/nvim-docker` Analysis & Issues**

#### **Current Script:**
```bash
docker run --rm -it \
  --name nvim-docker \
  -v "$PWD":/workspace \
  -w /workspace \
  nvim-docker nvim "$@"
```

#### **Problems & Solutions:**

- **Single Container Name:** Only one instance can run at a time.
  - *Solution:* Use a unique name per invocation (e.g., `nvim-docker-$(date +%s%N)` or `nvim-docker-$$`), or allow the user to specify a name.
  - *Alternative:* Check if a container with the name exists and re-use it, or attach to it.

- **Mounting Only `$PWD`:** Can't access files outside the current directory, including hidden files.
  - *Solution:* Mount the user's home directory (`-v "$HOME":"$HOME"`) and set the working directory (`-w "$PWD"`). This allows editing any file the user can access.

- **Editing Hidden Files:** Should be fixed by mounting higher up (see above).

- **Multiple Mounts at Runtime:** Docker cannot add new mounts to a running container. You must specify all mounts at container start.

- **Better CLI Usability:** Consider a wrapper that:
  - Accepts a file or directory as an argument.
  - Mounts the home directory.
  - Sets the working directory to the file’s directory.
  - Optionally, re-uses a running container (advanced, but possible with `docker exec`).

- **No Docs:** Add usage instructions and caveats to your README.

---

### 4. **Installer Packaging (RPM, DEB, etc.)**
- **Tools:** `fpm`, `dpkg-deb`, `rpmbuild`, `pkgbuild` (macOS), etc.
- **Pros:** System-level install, easy uninstall, dependency management.
- **Cons:** More complex, less cross-platform, less flexible for user customization.
- **Recommendation:** For now, stick with shell scripts for flexibility and cross-platform support. Consider packaging only if you want to distribute via system package managers.

---

### 5. **Automated Testing of Installers**
- **Approach:** Use CI (GitHub Actions, etc.) to:
  - Spin up VMs/containers for each target OS (macOS, Ubuntu, WSL2).
  - Run the installer.
  - Run Neovim headless, execute Lua commands, open/edit files, check for errors.
- **Central Pack List:** Use the test suite as the source of truth for required packs. Only packs tested on all platforms are "officially supported."
- **Tools:** `docker`, `vagrant`, `act` (for local GitHub Actions), or cloud CI runners.

---

### 6. **Cross-Platform Installer Tech**
- **Options:** `asdf`, `nix`, `brew` (Linuxbrew), `conda`, or a custom shell script with OS detection.
- **Best Fit:** For your needs (modularity, user customization, cross-platform), a shell script with OS detection and modular logic is best. `nix` is powerful but has a learning curve and can be overkill.

---

### 7. **Docker, ARM, and Portability**
- **ARM vs x86:** Docker images are architecture-specific. Apple Silicon Macs use ARM64, most Linux/WSL2 is x86_64.
- **Solutions:**
  - **Multi-arch Images:** Build and publish both ARM64 and x86_64 images using Docker Buildx and manifest lists.
  - **Base Images:** Use `FROM neovim/neovim:stable` (official image, multi-arch) as your base, then add your packs/configs.
  - **Portability:** Docker is portable *if* you build/publish for all target architectures.
- **No Cross-Platform Package Manager in Docker:** But you can use multi-arch images and official base images.

---

### 8. **Generic Installer Wrapper**
- **Features:**
  - Detect OS (macOS, Ubuntu, WSL2, etc.).
  - Allow user to select packs (via CLI or config).
  - Call the appropriate platform-specific installer logic.
  - Print post-install instructions for customization.

---

## **Actionable Recommendations**

1. **Improve `scripts/nvim-docker`:**
   - Use a unique container name or allow user to specify.
   - Mount `$HOME` and set `-w "$PWD"`.
   - Add usage docs.
   - Optionally, add logic to re-use or attach to a running container.

2. **Installer Logic:**
   - Modularize pack selection (CLI/config).
   - Add OS detection to a wrapper script.
   - Document how to enable/disable packs (`start` vs `opt`).

3. **Testing:**
   - Set up CI to test installers and packs on all platforms.
   - Use the test suite as the source of truth for supported packs.

4. **Docker Portability:**
   - Use multi-arch images or official Neovim base images.
   - Document architecture requirements.

5. **Docs:**
   - Add clear usage and customization instructions for all scripts.

---

Would you like:
- A revised `nvim-docker` script with the above improvements?
- A template for a generic cross-platform installer wrapper?
- Guidance on setting up multi-arch Docker images?
- A sample CI test plan for your setup?

Let me know which you want to tackle first!