require('nvim-treesitter.configs').setup {
  ensure_installed = { "typescript", "tsx" },
  auto_install = true,
  highlight = {
    enable = true,
  },
} 