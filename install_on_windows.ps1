#Requires -Version 5.1
<#
.SYNOPSIS
    Installs the Neovim configuration on Windows.
.DESCRIPTION
    This script sets up a complete Neovim environment on Windows. It checks for
    dependencies, clones all necessary plugins using Neovim's native package
    management structure, copies configuration files, and installs language
    servers and Treesitter parsers.
.PARAMETER Force
    If specified, the script will delete an existing Neovim configuration at
    $env:LOCALAPPDATA\nvim without prompting.
.EXAMPLE
    .\install_on_windows.ps1
    Installs the configuration, but will stop if a config already exists.
.EXAMPLE
    .\install_on_windows.ps1 -Force
    Deletes any existing Neovim configuration and installs fresh.
#>
param(
    [switch]$Force
)

$ErrorActionPreference = "Stop"

# List of required dependencies and their corresponding Chocolatey packages
$requiredDependencies = @{
    "curl"   = "curl"
    "unzip"  = "unzip"
    "git"    = "git"
    "rg"     = "ripgrep"
    "fd"     = "fd"
    "go"     = "golang"
    "bat"    = "bat"
    "node"   = "nodejs"
    "npm"    = "nodejs"
    "nvim"   = "neovim"
    "gcc"    = "mingw"
}

# Check for missing dependencies
$missingDependencies = @()
foreach ($dep in $requiredDependencies.Keys) {
    if (-not (Get-Command $dep -ErrorAction SilentlyContinue)) {
        $missingDependencies += $requiredDependencies[$dep]
    }
}

if ($missingDependencies.Count -ne 0) {
    $uniqueMissing = $missingDependencies | Sort-Object -Unique
    Write-Error "Missing dependencies: $($uniqueMissing -join ', ')"
    Write-Host "Please install them using Chocolatey (https://chocolatey.org/):"
    Write-Host "  choco install $($uniqueMissing -join ' ')"
    exit 1
}

# Install Nerd Font for icons using Chocolatey
Write-Host "Checking for Nerd Font (firacode)..."
$nerdFontPackage = "nerd-fonts-firacode"
if (choco list --local-only --exact $nerdFontPackage) {
    Write-Host "FiraCode Nerd Font is already installed."
} else {
    Write-Host "Installing FiraCode Nerd Font via Chocolatey..."
    choco install $nerdFontPackage -y
}

# Check Node.js version (require >= 20)
$nodeVersion = (node -v).Substring(1).Split('.')[0]
if ($nodeVersion -lt 20) {
    Write-Error "Node.js version >= 20 is required. Please upgrade:"
    Write-Host "  choco upgrade nodejs"
    exit 1
}

# Install global npm packages for LSPs
Write-Host "Installing global npm packages: typescript-language-server, typescript, @tailwindcss/language-server, vscode-langservers-extracted, prettier, eslint_d"
npm install -g typescript-language-server typescript @tailwindcss/language-server vscode-langservers-extracted prettier eslint_d

# Define Neovim config path
$nvimConfigPath = [System.IO.Path]::Combine($env:LOCALAPPDATA, "nvim")

# Check if nvim config exists
if (Test-Path $nvimConfigPath) {
    if ($Force) {
        Write-Warning "[FORCE] Deleting existing $nvimConfigPath..."
        Remove-Item -Path $nvimConfigPath -Recurse -Force
    } else {
        Write-Warning "$nvimConfigPath already exists."
        Write-Host "Running this script will overwrite your existing Neovim config."
        Write-Host "If you want to keep your current config, move or delete it first."
        Write-Host "Sample commands:"
        Write-Host "  Move-Item -Path $nvimConfigPath -Destination ""$nvimConfigPath.bak"""
        Write-Host "  Remove-Item -Path $nvimConfigPath -Recurse -Force"
        exit 1
    }
}

# Copy nvim-config to destination
New-Item -Path $nvimConfigPath -ItemType Directory -Force | Out-Null
Copy-Item -Path ".\nvim-config\*" -Destination $nvimConfigPath -Recurse

# Helper function for cloning and copying configs
function Install-Plugin {
    param(
        [string]$PackName,
        [string]$PluginName,
        [string]$RepoUrl,
        [string]$ConfigRelativePath = ""
    )

    $packDir = [System.IO.Path]::Combine($nvimConfigPath, "pack", $PackName, "start")
    New-Item -Path $packDir -ItemType Directory -Force | Out-Null

    if ($PluginName -and $RepoUrl) {
        $pluginDir = [System.IO.Path]::Combine($packDir, $PluginName)
        if (-not (Test-Path $pluginDir)) {
            Write-Host "Cloning $PluginName..."
            git clone --depth 1 $RepoUrl $pluginDir
        }
    }

    if ($ConfigRelativePath) {
        $sourcePath = [System.IO.Path]::Combine($PSScriptRoot, $ConfigRelativePath)
        $destPath = [System.IO.Path]::Combine($nvimConfigPath, (Split-Path $ConfigRelativePath -Parent))
        New-Item -Path $destPath -ItemType Directory -Force | Out-Null
        Copy-Item -Path $sourcePath -Destination ([System.IO.Path]::Combine($destPath, (Split-Path $sourcePath -Leaf)))
    }
}

# nvim-cmp and sources
Install-Plugin -PackName "nvim-cmp" -PluginName "nvim-cmp" -RepoUrl "https://github.com/hrsh7th/nvim-cmp" -ConfigRelativePath "pack\nvim-cmp\start\cmp-config\plugin\cmp_config.lua"
Install-Plugin -PackName "nvim-cmp" -PluginName "cmp-nvim-lsp" -RepoUrl "https://github.com/hrsh7th/cmp-nvim-lsp"
Install-Plugin -PackName "nvim-cmp" -PluginName "cmp-buffer" -RepoUrl "https://github.com/hrsh7th/cmp-buffer"
Install-Plugin -PackName "nvim-cmp" -PluginName "cmp-path" -RepoUrl "https://github.com/hrsh7th/cmp-path"
Install-Plugin -PackName "nvim-cmp" -PluginName "cmp-cmdline" -RepoUrl "https://github.com/hrsh7th/cmp-cmdline"
Install-Plugin -PackName "nvim-cmp" -PluginName "cmp-vsnip" -RepoUrl "https://github.com/hrsh7th/cmp-vsnip"
Install-Plugin -PackName "nvim-cmp" -PluginName "cmp-git" -RepoUrl "https://github.com/petertriho/cmp-git"

# lspconfig
Install-Plugin -PackName "lsp" -PluginName "nvim-lspconfig" -RepoUrl "https://github.com/neovim/nvim-lspconfig" -ConfigRelativePath "pack\lsp\start\lsp-config\plugin\lsp_config.lua"

# schemastore.nvim for JSON Schema support
Install-Plugin -PackName "lsp" -PluginName "schemastore.nvim" -RepoUrl "https://github.com/b0o/schemastore.nvim.git"

# fzf and fzf.vim
Install-Plugin -PackName "fzf" -PluginName "fzf" -RepoUrl "https://github.com/junegunn/fzf.git"
$fzfInstallScript = [System.IO.Path]::Combine($nvimConfigPath, "pack", "fzf", "start", "fzf", "install.ps1")
if (Test-Path $fzfInstallScript) {
    $currentPath = Get-Location
    & $fzfInstallScript
    Set-Location $currentPath
} else {
    # Fallback for older fzf versions or if install.ps1 is missing
     $fzfExe = [System.IO.Path]::Combine($nvimConfigPath, "pack", "fzf", "start", "fzf", "bin", "fzf.exe")
     if (Test-Path $fzfExe) {
        Write-Host "fzf.exe found, skipping install script."
     } else {
        Write-Warning "fzf install script not found at $fzfInstallScript"
     }
}
Install-Plugin -PackName "fzf" -PluginName "fzf-lua" -RepoUrl "https://github.com/ibhagwan/fzf-lua.git" -ConfigRelativePath "pack\fzf\start\fzf-lua-config\plugin\fzf-lua-config.lua"

# none-ls and plenary
Install-Plugin -PackName "none-ls" -PluginName "plenary.nvim" -RepoUrl "https://github.com/nvim-lua/plenary.nvim"
Install-Plugin -PackName "none-ls" -PluginName "none-ls.nvim" -RepoUrl "https://github.com/nvimtools/none-ls.nvim"

# none-ls-extras
Install-Plugin -PackName "none-ls-extras" -PluginName "none-ls-extras.nvim" -RepoUrl "https://github.com/nvimtools/none-ls-extras.nvim"

# Custom none-ls config
Install-Plugin -PackName "none-ls-config" -ConfigRelativePath "pack\none-ls-config\start\none-ls-config\plugin\none_ls.lua"

# which-key.nvim
Install-Plugin -PackName "which-key" -PluginName "which-key.nvim" -RepoUrl "https://github.com/folke/which-key.nvim"

# nvim-tree.lua
Install-Plugin -PackName "nvim-tree" -PluginName "nvim-tree.lua" -RepoUrl "https://github.com/nvim-tree/nvim-tree.lua.git" -ConfigRelativePath "pack\nvim-tree\start\nvim-tree-config\plugin\nvim-tree-config.lua"
nvim -u NONE --headless -c "helptags $($nvimConfigPath)\pack\nvim-tree\start\nvim-tree.lua\doc" -c q
Install-Plugin -PackName "nvim-tree" -PluginName "nvim-web-devicons" -RepoUrl "https://github.com/nvim-tree/nvim-web-devicons.git"

# nvim-lsp-file-operations
Install-Plugin -PackName "lsp-file-ops" -PluginName "nvim-lsp-file-operations" -RepoUrl "https://github.com/antosha417/nvim-lsp-file-operations.git" -ConfigRelativePath "pack\lsp-file-ops\start\lsp-file-ops-config\plugin\lsp-file-ops-config.lua"

# Copilot plugins & config
Install-Plugin -PackName "copilot" -PluginName "CopilotChat.nvim" -RepoUrl "https://github.com/CopilotC-Nvim/CopilotChat.nvim.git"
Install-Plugin -PackName "copilot" -PluginName "copilot.vim" -RepoUrl "https://github.com/github/copilot.vim.git"
# Special case for copilot config due to nested path
$copilotConfigSrc = [System.IO.Path]::Combine($PSScriptRoot, "pack", "copilot", "copilot-config", "plugin", "copilot_completeopt.lua")
$copilotConfigDestDir = [System.IO.Path]::Combine($nvimConfigPath, "pack", "copilot", "start", "copilot-config", "plugin")
New-Item -Path $copilotConfigDestDir -ItemType Directory -Force | Out-Null
Copy-Item -Path $copilotConfigSrc -Destination $copilotConfigDestDir

# copy copilot_disable.lua as well
$copilotDisableSrc = [System.IO.Path]::Combine($PSScriptRoot, "pack", "copilot", "copilot-config", "plugin", "copilot_disable.lua")
Copy-Item -Path $copilotDisableSrc -Destination $copilotConfigDestDir

# nvim-treesitter
Install-Plugin -PackName "nvim-treesitter" -PluginName "nvim-treesitter" -RepoUrl "https://github.com/nvim-treesitter/nvim-treesitter.git" -ConfigRelativePath "pack\nvim-treesitter\start\nvim-treesitter-config\plugin\nvim-treesitter-config.lua"
Install-Plugin -PackName "nvim-treesitter" -PluginName "nvim-treesitter-textobjects" -RepoUrl "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"

# ts-comments
Install-Plugin -PackName "ts-comments" -PluginName "ts-comments.nvim" -RepoUrl "https://github.com/folke/ts-comments.nvim.git" -ConfigRelativePath "pack\ts-comments\start\ts-comments-config\plugin\ts-comments-config.lua"

# OatVim Colorschemes
Write-Host "Installing OatVim colorschemes..."
$oatColorsSource = [System.IO.Path]::Combine($PSScriptRoot, "pack", "oat-colors")
$oatColorsDest = [System.IO.Path]::Combine($nvimConfigPath, "pack")
New-Item -Path $oatColorsDest -ItemType Directory -Force | Out-Null
Copy-Item -Path $oatColorsSource -Destination $oatColorsDest -Recurse

# OatHealth Plugin
$oathealthDir = [System.IO.Path]::Combine($nvimConfigPath, "pack", "oathealth", "start", "oathealth", "lua", "oathealth")
New-Item -Path $oathealthDir -ItemType Directory -Force | Out-Null
Copy-Item -Path ([System.IO.Path]::Combine($PSScriptRoot, "pack", "oathealth", "start", "oathealth", "lua", "oathealth", "health.lua")) -Destination $oathealthDir

# Pre-install Treesitter parsers
Write-Host "Installing Treesitter parsers..."
nvim --headless "+TSInstallSync! typescript tsx" +qa

Write-Host "Neovim config and plugins installed successfully!"

Write-Host "Running OatHealth check..."
nvim --headless -c "checkhealth oathealth" -c "q" 