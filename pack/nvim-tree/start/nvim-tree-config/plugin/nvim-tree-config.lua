-- configure nvim-tree
-- see https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local nvim_tree = require("nvim-tree")

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  renderer = {
    root_folder_label = function(path)
      return "󰉖 " .. vim.fn.fnamemodify(path, ":t")
    end,
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  view = {
    width = 60,
    side = "left",
  },
  git = {
    enable = true,
    ignore = false,
  },
}) 