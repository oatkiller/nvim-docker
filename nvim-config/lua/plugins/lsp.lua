-- vim.lsp.config('typescript',{
--   cmd = { 'typescript-language-server', '--stdio' },
--   filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
--   root_markers = { 'tsconfig.json' },
-- })

vim.lsp.enable('ts_ls') 
print("TypeScript LSP enabled")
