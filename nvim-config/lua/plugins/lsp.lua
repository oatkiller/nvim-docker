vim.lsp.config('typescript',{
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact', 'javascript.jsx' },
  -- root_markers = { { 'tsconfig.json', 'jsconfig.json', 'package.json' }, '.git' },
})

vim.lsp.enable('typescript') 
print("TypeScript LSP enabled")
