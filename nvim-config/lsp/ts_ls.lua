local function on_attach(client, bufnr)
  -- Replicate built-in ts_ls :LspTypescriptSourceAction logic
  if client.name == "ts_ls" then
    vim.api.nvim_buf_create_user_command(bufnr, 'LspTypescriptSourceAction', function()
      local kinds = client.server_capabilities.codeActionProvider
        and client.server_capabilities.codeActionProvider.codeActionKinds
        or {}
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, 'source.')
      end, kinds)
      vim.lsp.buf.code_action({ context = { only = source_actions } })
    end, { desc = "Run source.* code actions (e.g. organize imports)" })
  end

  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  local caps = client.server_capabilities

  if caps.definitionProvider then
    map("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")
  end

  if caps.typeDefinitionProvider then
    map("n", "go", vim.lsp.buf.type_definition, "LSP: Type Definition")
  end

  if caps.workspaceSymbolProvider then
    map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "LSP: Workspace Symbols")
  end

  if caps.documentFormattingProvider then
    map("n", "<leader>f", function() vim.lsp.buf.format({ async = false }) end, "LSP: Format File")
  end

  if caps.documentHighlightProvider then
    local group = "lsp_document_highlight_" .. bufnr
    vim.api.nvim_create_augroup(group, { clear = true })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = group,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      group = group,
      callback = vim.lsp.buf.clear_references,
    })
  end

  map("n", "<leader>oi", "<Cmd>LspTypescriptSourceAction<CR>", "LSP: Organize Imports")

  vim.api.nvim_buf_create_user_command(bufnr, "LspFeatures", function()
    print(vim.inspect(client.server_capabilities))
  end, { desc = "Print LSP Capabilities" })

  vim.notify("LSP [" .. client.name .. "] attached to buffer " .. bufnr)
end

return {
  on_attach = on_attach,
}