require('nvim-treesitter.configs').setup {
  ensure_installed = { "typescript", "tsx" },
  auto_install = true,
  highlight = {
    enable = true,
  },
  -- Enable Treesitter-powered text-objects & motions
  textobjects = {
    -- Selection textobjects (v, i = inner, a = outer)
    select = {
      enable = true,
      lookahead = true, -- automatically jump forward to object
      include_surrounding_whitespace = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["as"] = "@statement.outer",
        ["is"] = "@statement.outer",
      },
    },
    -- Movement between functions / classes
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
    },
  },
} 

-- TODO: add code to the installer and dockerfile to pre install needed parser.