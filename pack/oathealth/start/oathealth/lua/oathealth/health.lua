-- oathealth health.lua
-- Implements the :checkhealth interface for the custom nvim setup.

local M = {}

local function check_executable(exe)
  return vim.fn.executable(exe) == 1
end

local function check_plugin(name)
  return pcall(require, name)
end

M.check = function()
  vim.health.start("oathealth: Custom Neovim Setup")

  -- Check External Dependencies
  vim.health.info("Checking external dependencies...")
  if check_executable("rg") then
    vim.health.ok("ripgrep (rg) is installed.")
  else
    vim.health.error("ripgrep (rg) is not installed.", "Please install ripgrep.")
  end
  if check_executable("fd") then
    vim.health.ok("fd is installed.")
  else
    vim.health.error("fd is not installed.", "Please install fd.")
  end
  if check_executable("go") then
    vim.health.ok("go is installed.")
  else
    vim.health.error("go is not installed.", "Please install go.")
  end
    if check_executable("bat") then
    vim.health.ok("bat is installed.")
  else
    vim.health.error("bat is not installed.", "Please install bat.")
  end
  if check_executable("node") then
    vim.health.ok("node is installed.")
  else
    vim.health.error("node is not installed.", "Please install node.")
  end
  if check_executable("npm") then
    vim.health.ok("npm is installed.")
  else
    vim.health.error("npm is not installed.", "Please install npm.")
  end
  if check_executable("fzf") then
    vim.health.ok("fzf is installed.")
  else
    vim.health.error("fzf is not installed.", "Please run the install script inside ~/.config/nvim/pack/fzf/start/fzf/ or re-run the main install script.")
  end

  -- Check Neovim Plugins
  vim.health.info("Checking Neovim plugins...")
  if check_plugin("cmp") then
    vim.health.ok("nvim-cmp is loaded.")
  else
    vim.health.error("nvim-cmp is not loaded.")
  end
  if check_plugin("lspconfig") then
    vim.health.ok("lspconfig is loaded.")
  else
    vim.health.error("lspconfig is not loaded.")
  end
  if check_plugin("nvim-tree") then
    vim.health.ok("nvim-tree is loaded.")
  else
    vim.health.error("nvim-tree is not loaded.")
  end
  if check_plugin("CopilotChat") then
    vim.health.ok("CopilotChat.nvim is loaded.")
  else
    vim.health.error("CopilotChat.nvim is not loaded.")
  end
    if check_plugin("null-ls") then
    vim.health.ok("none-ls.nvim (null-ls) is loaded.")
  else
    vim.health.error("none-ls.nvim (null-ls) is not loaded.")
  end
  if check_plugin("which-key") then
    vim.health.ok("which-key.nvim is loaded.")
  else
    vim.health.error("which-key.nvim is not loaded.")
  end
  if check_plugin("fzf-lua") then
    vim.health.ok("fzf-lua is loaded.")
  else
    vim.health.error("fzf-lua is not loaded.")
  end

  -- Check NPM-installed Executables
  vim.health.info("Checking NPM-installed executables...")
  if check_executable("typescript-language-server") then
    vim.health.ok("typescript-language-server is installed.")
  else
    vim.health.error("typescript-language-server is not installed.", "Run: npm install -g typescript-language-server")
  end
  if check_executable("tsc") then
    vim.health.ok("typescript (tsc) is installed.")
  else
    vim.health.error("typescript (tsc) is not installed.", "Run: npm install -g typescript")
  end
  if check_executable("tailwindcss-language-server") then
    vim.health.ok("@tailwindcss/language-server is installed.")
  else
    vim.health.error("@tailwindcss/language-server is not installed.", "Run: npm install -g @tailwindcss/language-server")
  end
    if check_executable("prettier") then
    vim.health.ok("prettier is installed.")
  else
    vim.health.error("prettier is not installed.", "Run: npm install -g prettier")
  end
  if check_executable("eslint_d") then
    vim.health.ok("eslint_d is installed.")
  else
    vim.health.error("eslint_d is not installed.", "Run: npm install -g eslint_d")
  end
end

return M 