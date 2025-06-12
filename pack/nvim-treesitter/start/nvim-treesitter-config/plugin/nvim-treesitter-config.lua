require('nvim-treesitter.configs').setup {
  ensure_installed = { "typescript", "tsx" },
  auto_install = true,
  highlight = {
    enable = true,
  },
} 

-- TODO: add code to the installer and dockerfile to pre install needed parser.