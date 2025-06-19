-- oat-colors-config.lua
--
-- Provides commands to cycle through the OatVim colorschemes.

-- Exit if the oat-colors pack doesn't seem to be installed.
if not pcall(require, 'oat-desert') then
  return
end

local M = {}

-- List of available OatVim colorschemes
M.themes = {
  'oat-desert',
  'oat-elflord',
  'oat-murphy',
  'oat-zellner',
  'oat-evening',
}

-- Store the initial colorscheme to allow resetting
M.initial_theme = vim.g.colors_name or M.themes[1]
M.current_index = 1

-- Find the initial index
for i, theme in ipairs(M.themes) do
  if theme == M.initial_theme then
    M.current_index = i
    break
  end
end

--- Sets a colorscheme and provides feedback.
-- @param theme_name string The name of the colorscheme to set.
local function set_colorscheme(theme_name)
  if vim.g.colors_name == theme_name then return end
  vim.cmd.colorscheme(theme_name)
  vim.notify('Colorscheme: ' .. theme_name, vim.log.levels.INFO, { title = "OatVim" })
end

--- Cycles to the next colorscheme in the list.
function M.next_theme()
  M.current_index = M.current_index + 1
  if M.current_index > #M.themes then
    M.current_index = 1 -- Wrap around to the start
  end
  local next_theme_name = M.themes[M.current_index]
  set_colorscheme(next_theme_name)
end

--- Cycles to the previous colorscheme in the list.
function M.previous_theme()
  M.current_index = M.current_index - 1
  if M.current_index < 1 then
    M.current_index = #M.themes -- Wrap around to the end
  end
  local prev_theme_name = M.themes[M.current_index]
  set_colorscheme(prev_theme_name)
end

--- Resets to the original colorscheme loaded at startup.
function M.reset_theme()
  -- Find the index of the initial theme again in case it was lost
  for i, theme in ipairs(M.themes) do
    if theme == M.initial_theme then
      M.current_index = i
      break
    end
  end
  set_colorscheme(M.initial_theme)
end

-- Create user commands
vim.api.nvim_create_user_command('OatColorsNext', M.next_theme, {})
vim.api.nvim_create_user_command('OatColorsPrevious', M.previous_theme, {})
vim.api.nvim_create_user_command('OatColorsReset', M.reset_theme, {})

-- Create keymaps
vim.keymap.set('n', '<leader>cn', ':OatColorsNext<CR>', { desc = 'Next OatVim Colorscheme' })
vim.keymap.set('n', '<leader>cp', ':OatColorsPrevious<CR>', { desc = 'Previous OatVim Colorscheme' })
vim.keymap.set('n', '<leader>cr', ':OatColorsReset<CR>', { desc = 'Reset To Default Colorscheme' })

return M 