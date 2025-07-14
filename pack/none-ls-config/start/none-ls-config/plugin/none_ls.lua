local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- Conditionally enable eslint_d only if the project has an ESLint configuration
    require("none-ls.diagnostics.eslint_d").with({
      condition = function(utils)
        -- Enable if standard ESLint config files exist
        if utils.root_has_file({
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.json",
        }) then
          return true
        end

        -- Fall-back: inspect package.json for eslint hints
        local pkg_path = utils.root_has_file("package.json")
        if not pkg_path then
          return false
        end

        local ok, pkg = pcall(vim.fn.json_decode, table.concat(vim.fn.readfile(pkg_path), "\n"))
        if not ok or type(pkg) ~= "table" then
          return false
        end

        if pkg.eslintConfig then
          return true
        end

        local function has_dep(tbl, name)
          return tbl and tbl[name] ~= nil
        end

        if has_dep(pkg.dependencies, "eslint")
          or has_dep(pkg.devDependencies, "eslint")
          or has_dep(pkg.peerDependencies, "eslint")
        then
          return true
        end

        return false
      end,
    }),
    null_ls.builtins.formatting.prettier,
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