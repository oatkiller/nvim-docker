-- Health check for the Neovim setup

local M = {}

local function check_executable(exe)
  return vim.fn.executable(exe) == 1
end

local function check_plugin(name)
  return package.loaded[name] ~= nil
end

local function check_npm_package(pkg)
  local handle = io.popen('npm list -g ' .. pkg .. ' > /dev/null 2>&1')
  local status = handle:close()
  return status
end

local function print_status(name, status)
  if status then
    vim.api.nvim_echo({{'[OK]', 'HealthSuccess'}}, false, {})
    vim.api.nvim_echo({' ' .. name}, false, {})
  else
    vim.api.nvim_echo({{'[FAIL]', 'HealthError'}}, false, {})
    vim.api.nvim_echo({' ' .. name}, false, {})
  end
end

function M.check()
  vim.api.nvim_echo({{'--- Neovim Health Check ---', 'HealthSuccess'}}, true, {})

  vim.api.nvim_echo({{'', ''}}, true, {})
  vim.api.nvim_echo({{'External Dependencies:', 'HealthInfo'}}, true, {})
  print_status('ripgrep (rg)', check_executable('rg'))
  print_status('fd', check_executable('fd'))
  print_status('go', check_executable('go'))
  print_status('bat', check_executable('bat'))
  print_status('node', check_executable('node'))
  print_status('npm', check_executable('npm'))

  vim.api.nvim_echo({{'', ''}}, true, {})
  vim.api.nvim_echo({{'Neovim Plugins:', 'HealthInfo'}}, true, {})
  print_status('nvim-cmp', check_plugin('cmp'))
  print_status('lspconfig', check_plugin('lspconfig'))
  print_status('nvim-tree', check_plugin('nvim-tree'))
  print_status('CopilotChat.nvim', check_plugin('CopilotChat'))
  print_status('none-ls.nvim (null-ls)', check_plugin('null-ls'))
  print_status('which-key.nvim', check_plugin('which-key'))

  vim.api.nvim_echo({{'', ''}}, true, {})
  vim.api.nvim_echo({{'NPM Packages:', 'HealthInfo'}}, true, {})
  print_status('typescript-language-server', check_npm_package('typescript-language-server'))
  print_status('typescript', check_npm_package('typescript'))
  print_status('@tailwindcss/language-server', check_npm_package('@tailwindcss/language-server'))
  print_status('prettier', check_npm_package('prettier'))
  print_status('eslint_d', check_npm_package('eslint_d'))
end

vim.api.nvim_create_user_command('OatHealth', M.check, {})

return M 