require('cmp_config')

vim.lsp.enable('ts_ls')
vim.lsp.enable('tailwindcss')

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