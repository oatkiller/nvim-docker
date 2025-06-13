local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function on_attach(client, bufnr)
  -- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
  -- `vim.lsp.buf.code_action()` if specified in `context.only`.
  if client.name == 'ts_ls' then
    vim.api.nvim_buf_create_user_command(0, 'LspTypescriptSourceAction', function()
      local source_actions = vim.tbl_filter(function(action)
        return vim.startswith(action, 'source.')
      end, client.server_capabilities.codeActionProvider.codeActionKinds)

      vim.lsp.buf.code_action({
        context = {
          only = source_actions,
        },
      })
    end, {})

    -----------------------------------------------------------------------------
    -- Buffer-local commands for common TypeScript source actions. These allow
    -- us to invoke the action directly (with no intermediate picker) which can
    -- then be mapped globally.  We purposefully set `apply = true` because
    -- each `only` filter is guaranteed to return at most one action.
    -----------------------------------------------------------------------------

    -- Add all missing imports
    vim.api.nvim_buf_create_user_command(0, 'LspTypescriptAddMissingImports', function()
      vim.lsp.buf.code_action({
        context = { only = { 'source.addMissingImports.ts' } },
        apply = true,
      })
    end, {})

    -- Remove all unused code (imports, variables, etc.)
    vim.api.nvim_buf_create_user_command(0, 'LspTypescriptRemoveUnused', function()
      vim.lsp.buf.code_action({
        context = { only = { 'source.removeUnused.ts' } },
        apply = true,
      })
    end, {})
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

  vim.api.nvim_buf_create_user_command(bufnr, "LspFeatures", function()
    print(vim.inspect(client.server_capabilities))
  end, { desc = "Print LSP Capabilities" })

  vim.notify("LSP [" .. client.name .. "] attached to buffer " .. bufnr)
end

local function rename_file()
  local source_file, target_file
  vim.ui.input({
    prompt = "Source : ",
    completion = "file",
    default = vim.api.nvim_buf_get_name(0)
  }, function(input)
    source_file = input
  end)
  vim.ui.input({
    prompt = "Target : ",
    completion = "file",
    default = source_file
  }, function(input)
    target_file = input
  end)
  local params = {
    command = "_typescript.applyRenameFile",
    arguments = {
      {
        sourceUri = source_file,
        targetUri = target_file,
      },
    },
    title = ""
  }
  vim.lsp.util.rename(source_file, target_file)
  vim.lsp.buf.execute_command(params)
end

-- Use lspconfig's setup function for ts_ls.
-- This will merge nvim-lspconfig's default capabilities with our custom settings.
lspconfig.ts_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  commands = {
    LspRenameFile = {
      rename_file,
      description = "Rename File and Update Imports"
    },
  }
})

-- Setup for tailwindcss
lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- -----------------------------------------------------------------------------
-- Global keymap: <leader>oi → Organize Imports (TypeScript)
--
-- A buffer-local mapping inside `on_attach` frequently went missing because it
-- was tied to the lifetime of the buffer that first triggered the attach.  We
-- instead register a single, global mapping that attempts to run
-- `:LspTypescriptSourceAction` only if the user command is available for the
-- current buffer.  This guarantees the mapping is always present while still
-- failing gracefully in non-TypeScript buffers.
-- -----------------------------------------------------------------------------

vim.keymap.set("n", "<leader>oi", function()
  if vim.fn.exists(":LspTypescriptSourceAction") == 2 then
    vim.cmd("silent! LspTypescriptSourceAction")
  else
    vim.notify("Typescript Source Actions not available in this buffer.", vim.log.levels.WARN)
  end
end, { silent = true, desc = "LSP: Source Actions (TypeScript)" })

-- <leader>ai → Add all missing imports (TypeScript)
vim.keymap.set('n', '<leader>ai', function()
  if vim.fn.exists(':LspTypescriptAddMissingImports') == 2 then
    vim.cmd('silent! LspTypescriptAddMissingImports')
  else
    vim.notify('Add-Missing-Imports action not available in this buffer.', vim.log.levels.WARN)
  end
end, { silent = true, desc = 'LSP: Add Missing Imports (TypeScript)' })

-- <leader>ru → Remove all unused code (TypeScript)
vim.keymap.set('n', '<leader>ru', function()
  if vim.fn.exists(':LspTypescriptRemoveUnused') == 2 then
    vim.cmd('silent! LspTypescriptRemoveUnused')
  else
    vim.notify('Remove-Unused action not available in this buffer.', vim.log.levels.WARN)
  end
end, { silent = true, desc = 'LSP: Remove Unused (TypeScript)' }) 