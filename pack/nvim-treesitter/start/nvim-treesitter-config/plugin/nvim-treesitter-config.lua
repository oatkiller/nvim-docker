require('nvim-treesitter.configs').setup {
  ensure_installed = { "typescript", "tsx", "diff" },
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
        -- Parameter (arguments)
        ["ip"] = "@parameter.inner",
        ["ap"] = "@parameter.outer",
        ["il"] = "@loop.inner",
        ["al"] = "@loop.outer",
        ["ie"] = "@element.inner",
        ["ae"] = "@element.outer",
        -- Attributes / props
        ["ia"] = "@attribute.inner",
        ["aa"] = "@attribute.outer",
        -- Statements (generic)
        ["is"] = "@statement.outer",
        ["as"] = "@statement.outer",
      },
    },
    -- Movement between functions / classes
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]l"] = "@loop.outer",
        ["]e"] = "@element.outer",
        ["]a"] = "@attribute.outer",
        ["]p"] = "@parameter.outer",
        ["]s"] = "@statement.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[l"] = "@loop.outer",
        ["[e"] = "@element.outer",
        ["[a"] = "@attribute.outer",
        ["[p"] = "@parameter.outer",
        ["[s"] = "@statement.outer",
      },
    },
  },
} 

-- TODO: add code to the installer and dockerfile to pre install needed parser.