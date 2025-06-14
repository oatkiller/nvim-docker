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

# Check Node.js version (require >= 20)
$nodeVersion = (node -v).Substring(1).Split('.')[0]
if ($nodeVersion -lt 20) {
    Write-Error "Node.js version >= 20 is required. Please upgrade:"
    Write-Host "  choco upgrade nodejs"
    exit 1
}

# Install global npm packages for LSPs
Write-Host "Installing global npm packages: typescript-language-server, typescript, @tailwindcss/language-server, prettier, eslint_d"
npm install -g typescript-language-server typescript @tailwindcss/language-server prettier eslint_d

# Define Neovim config path
$nvimConfigPath = Join-Path $env:LOCALAPPDATA "nvim"

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

    $packDir = Join-Path $nvimConfigPath "pack" $PackName "start"
    New-Item -Path $packDir -ItemType Directory -Force | Out-Null

    if ($PluginName -and $RepoUrl) {
        $pluginDir = Join-Path $packDir $PluginName
        if (-not (Test-Path $pluginDir)) {
            Write-Host "Cloning $PluginName..."
            git clone --depth 1 $RepoUrl $pluginDir
        }
    }

    if ($ConfigRelativePath) {
        $sourcePath = Join-Path $PSScriptRoot $ConfigRelativePath
        $destPath = Join-Path $nvimConfigPath (Split-Path $ConfigRelativePath -Parent)
        New-Item -Path $destPath -ItemType Directory -Force | Out-Null
        Copy-Item -Path $sourcePath -Destination (Join-Path $destPath (Split-Path $sourcePath -Leaf))
    }
}

# nvim-cmp and sources
Install-Plugin -PackName "cmp" -PluginName "nvim-cmp" -RepoUrl "https://github.com/hrsh7th/nvim-cmp" -ConfigRelativePath "pack\cmp\start\cmp-config\plugin\cmp_config.lua"
Install-Plugin -PackName "cmp" -PluginName "cmp-nvim-lsp" -RepoUrl "https://github.com/hrsh7th/cmp-nvim-lsp"
Install-Plugin -PackName "cmp" -PluginName "cmp-buffer" -RepoUrl "https://github.com/hrsh7th/cmp-buffer"
Install-Plugin -PackName "cmp" -PluginName "cmp-path" -RepoUrl "https://github.com/hrsh7th/cmp-path"
Install-Plugin -PackName "cmp" -PluginName "cmp-cmdline" -RepoUrl "https://github.com/hrsh7th/cmp-cmdline"
Install-Plugin -PackName "cmp" -PluginName "cmp-vsnip" -RepoUrl "https://github.com/hrsh7th/cmp-vsnip"
Install-Plugin -PackName "cmp" -PluginName "cmp-git" -RepoUrl "https://github.com/petertriho/cmp-git"

# lspconfig
Install-Plugin -PackName "lsp" -PluginName "nvim-lspconfig" -RepoUrl "https://github.com/neovim/nvim-lspconfig" -ConfigRelativePath "pack\lsp\start\lsp-config\plugin\lsp_config.lua"

# fzf and fzf.vim
Install-Plugin -PackName "fzf" -PluginName "fzf" -RepoUrl "https://github.com/junegunn/fzf.git"
$fzfInstallScript = Join-Path $nvimConfigPath "pack\fzf\start\fzf\install.ps1"
if (Test-Path $fzfInstallScript) {
    & $fzfInstallScript
} else {
    # Fallback for older fzf versions or if install.ps1 is missing
     $fzfExe = Join-Path $nvimConfigPath "pack\fzf\start\fzf\bin\fzf.exe"
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

# CopilotChat.nvim & config
Install-Plugin -PackName "copilot" -PluginName "CopilotChat.nvim" -RepoUrl "https://github.com/CopilotC-Nvim/CopilotChat.nvim.git"
# Special case for copilot config due to nested path
$copilotConfigSrc = ".\pack\copilot\copilot-config\plugin\copilot_completeopt.lua"
$copilotConfigDestDir = Join-Path $nvimConfigPath "pack\copilot\start\copilot-config\plugin"
New-Item -Path $copilotConfigDestDir -ItemType Directory -Force | Out-Null
Copy-Item -Path $copilotConfigSrc -Destination $copilotConfigDestDir

# nvim-treesitter
Install-Plugin -PackName "nvim-treesitter" -PluginName "nvim-treesitter" -RepoUrl "https://github.com/nvim-treesitter/nvim-treesitter.git" -ConfigRelativePath "pack\nvim-treesitter\start\nvim-treesitter-config\plugin\nvim-treesitter-config.lua"
Install-Plugin -PackName "nvim-treesitter" -PluginName "nvim-treesitter-textobjects" -RepoUrl "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"

# ts-comments
Install-Plugin -PackName "ts-comments" -PluginName "ts-comments.nvim" -RepoUrl "https://github.com/folke/ts-comments.nvim.git" -ConfigRelativePath "pack\ts-comments\start\ts-comments-config\plugin\ts-comments-config.lua"

# OatHealth Plugin
$oathealthDir = Join-Path $nvimConfigPath "pack\oathealth\start\oathealth\lua\oathealth"
New-Item -Path $oathealthDir -ItemType Directory -Force | Out-Null
Copy-Item -Path ".\pack\oathealth\start\oathealth\lua\oathealth\health.lua" -Destination $oathealthDir

# Pre-install Treesitter parsers
Write-Host "Installing Treesitter parsers..."
nvim --headless "+TSInstallSync! typescript tsx" +qa

Write-Host "Neovim config and plugins installed successfully!" 