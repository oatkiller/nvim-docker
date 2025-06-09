-- none-ls setup for eslint_d and prettier via npx
local ok, null_ls = pcall(require, "null-ls")
if ok then
  null_ls.setup({
    sources = {
      null_ls.builtins.diagnostics.eslint_d.with({
        command = "npx",
        args = { "eslint_d", "-" },
      }),
      null_ls.builtins.formatting.prettier.with({
        command = "npx",
        args = { "prettier", "--stdin-filepath", "$FILENAME" },
      }),
    },
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end,
  })
end 