vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.lsp.enable('ts_ls')
vim.lsp.enable('tailwindcss')

-- Modern swapfile and persistence configuration
vim.o.swapfile = false
vim.o.backup = false
vim.o.undofile = true

local undodir = vim.fn.stdpath('data') .. '/undodir'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end
vim.o.undodir = undodir

vim.opt.grepprg = "rg --vimgrep --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"


-- Use treesitter folding by default
vim.o.foldmethod = 'expr'
-- Open all folds by default
vim.o.foldlevel = 99

-- Default to treesitter folding
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      -- Prefer LSP folding if client supports it
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})


-- See https://github.com/neovim/neovim/blob/master/runtime/lua/vim/_defaults.lua


vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {
  desc = "Toggle file explorer"
})

-- which-key.nvim setup
local wk = require('which-key')
wk.setup({
  icons = { mappings = false },
  preset = 'classic',
})
vim.keymap.set('n', '<leader>?', function()
  wk.show()
end, { desc = 'Show which-key' })

-- Automatically generate helptags for the doc directory on startup
local doc_path = vim.fn.stdpath('config') .. '/doc'
if vim.fn.isdirectory(doc_path) == 1 then
  vim.cmd('silent! helptags ' .. doc_path)
else
  vim.notify('Warning: Doc directory not found at ' .. doc_path, vim.log.levels.WARN)
end

vim.g.tsc_makeprg = 'npx tsc -b'
