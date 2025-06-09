print("Loaded none_ls.lua (with none-ls-extras)")
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    require("none-ls.diagnostics.eslint_d").with({
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