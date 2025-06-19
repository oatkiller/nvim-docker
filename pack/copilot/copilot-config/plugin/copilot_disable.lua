-- Disable GitHub Copilot's default key-mappings so it only serves as an
-- authentication back-end for CopilotChat.nvim.
-- Place in pack/copilot/copilot-config/plugin/ so it loads *after* copilot.vim.
--
-- We do *not* touch <Plug> mappings – they are inert unless explicitly used.

-- 1. Prevent copilot.vim from creating <Tab> mapping
vim.g.copilot_no_tab_map = true

-- 2. Prevent copilot.vim from creating any of its other insert-mode mappings
vim.g.copilot_no_maps = true

-- 3. Start Copilot in a disabled state so it never suggests inline completions
--    (CopilotChat will enable the HTTP agent lazily when it needs it.)
vim.g.copilot_enabled = false 