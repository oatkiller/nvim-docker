local ts_builtin = require('lspconfig.server_configurations.ts_ls')

local function on_attach(client, bufnr)
    ts_builtin.default_config.on_attach(client, bufnr)

    local map = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = bufnr, silent = true, desc = "LSP: " .. desc })
    end

    local caps = client.server_capabilities

    -- Only add things NOT covered by default Neovim LSP mappings:
    -- here are defaults already provided:
    -- - 'omnifunc' is set to |vim.lsp.omnifunc()|, use |i_CTRL-X_CTRL-O| to trigger
    --   completion.
    -- - 'tagfunc' is set to |vim.lsp.tagfunc()|. This enables features like
    --   go-to-definition, |:tjump|, and keymaps like |CTRL-]|, |CTRL-W_]|,
    --   |CTRL-W_}| to utilize the language server.
    -- - 'formatexpr' is set to |vim.lsp.formatexpr()|, so you can format lines via
    --   |gq| if the language server supports it.
    --   - To opt out of this use |gw| instead of gq, or clear 'formatexpr' on |LspAttach|.
    -- - |K| is mapped to |vim.lsp.buf.hover()| unless |'keywordprg'| is customized or
    --   a custom keymap for `K` exists.

    --                                           *grr* *gra* *grn* *gri* *i_CTRL-S*
    -- Some keymaps are created unconditionally when Nvim starts:
    -- - "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
    -- - "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
    -- - "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
    -- - "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
    -- - "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
    -- - CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|

    if caps.definitionProvider then
      map('gd', vim.lsp.buf.definition, 'Go to Definition')
    end

    if caps.typeDefinitionProvider then
      map('go', vim.lsp.buf.type_definition, 'Go to Type Definition')
    end

    if caps.workspaceSymbolProvider then
      map('<leader>ws', vim.lsp.buf.workspace_symbol, 'Workspace Symbols')
    end

    if caps.documentFormattingProvider then
      map('<leader>f', function() vim.lsp.buf.format({ async = false }) end, 'Format File')
    end

    if caps.documentHighlightProvider then
      vim.api.nvim_create_augroup("LspHighlights", { clear = true })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        group = "LspHighlights",
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = bufnr,
        group = "LspHighlights",
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Optional: User commands for inspecting
    vim.api.nvim_buf_create_user_command(bufnr, "LspFeatures", function()
      print(vim.inspect(client.server_capabilities))
    end, {})
  end
end

vim.lsp.config('ts_ls', {
    on_attach = on_attach,
})