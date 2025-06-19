-- oat-elflord ~ Neovim Colorscheme
--
-- Based on the classic 'elflord' theme from Vim.
-- Adapted for a pure black background with bright, bold colors.

if vim.g.colors_name then
  vim.cmd.highlight('clear')
end

vim.g.colors_name = 'oat-elflord'

local M = {}

-- Color Palette
-- Original elflord had a dark blue background. We're using #000000.
-- Colors have been brightened for better contrast.
M.palette = {
  -- Base
  black      = '#000000',
  white      = '#ffffff',
  light_grey = '#c0c0c0',
  grey       = '#808080',
  dark_grey  = '#404040',
  cursor_line= '#2a2a2a',

  -- Syntax
  cyan       = '#00ffff',
  green      = '#00ff00',
  yellow     = '#ffff00',
  red        = '#ff0000',
  magenta    = '#ff00ff',
  blue       = '#5c5cff',

  -- Diffs
  diff_add   = '#2d4d2d',
  diff_change= '#2d2d4d',
  diff_delete= '#4d2d2d',
  diff_text  = '#6e6e8e',

  -- Visual Selection
  visual     = '#005f87',
}

-- Editor and Plugin Highlights
M.highlights = {
  -- Base
  Normal            = { fg = M.palette.white, bg = M.palette.black },
  Visual            = { bg = M.palette.visual },
  CursorLine        = { bg = M.palette.cursor_line },
  CursorLineNr      = { fg = M.palette.yellow, bg = M.palette.cursor_line },
  LineNr            = { fg = M.palette.grey },
  SignColumn        = { fg = M.palette.grey, bg = M.palette.black },
  StatusLine        = { fg = M.palette.black, bg = M.palette.cyan },
  StatusLineNC      = { fg = M.palette.grey, bg = M.palette.dark_grey },
  TabLine           = { fg = M.palette.light_grey, bg = M.palette.dark_grey },
  TabLineSel        = { fg = M.palette.black, bg = M.palette.cyan },
  TabLineFill       = { bg = M.palette.dark_grey },
  VertSplit         = { fg = M.palette.dark_grey },
  Title             = { fg = M.palette.cyan, bold = true },
  Directory         = { fg = M.palette.blue, bold = true },
  Search            = { bg = M.palette.yellow, fg = M.palette.black },
  IncSearch         = { bg = M.palette.magenta, fg = M.palette.black },
  Pmenu             = { bg = M.palette.dark_grey, fg = M.palette.light_grey },
  PmenuSel          = { bg = M.palette.visual, fg = M.palette.white },
  PmenuSbar         = { bg = M.palette.grey },
  PmenuThumb        = { bg = M.palette.white },
  WildMenu          = { bg = M.palette.visual, fg = M.palette.white },
  Folded            = { fg = M.palette.grey, bg = M.palette.dark_grey },
  DiffAdd           = { bg = M.palette.diff_add },
  DiffChange        = { bg = M.palette.diff_change },
  DiffDelete        = { fg = M.palette.white, bg = M.palette.diff_delete },
  DiffText          = { bg = M.palette.diff_text, fg = M.palette.white },
  ColorColumn       = { bg = M.palette.cursor_line },
  Conceal           = { fg = M.palette.grey },
  CopilotSuggestion = { fg = M.palette.grey },

  -- Syntax
  Comment           = { fg = M.palette.grey, italic = true },
  Constant          = { fg = M.palette.green },
  String            = { fg = M.palette.cyan },
  Character         = { fg = M.palette.cyan },
  Number            = { fg = M.palette.green },
  Boolean           = { fg = M.palette.green, bold = true },
  Float             = { fg = M.palette.green },
  Identifier        = { fg = M.palette.white },
  Function          = { fg = M.palette.yellow, bold = true },
  Statement         = { fg = M.palette.magenta, bold = true },
  Conditional       = { fg = M.palette.magenta, bold = true },
  Repeat            = { fg = M.palette.magenta, bold = true },
  Label             = { fg = M.palette.yellow },
  Operator          = { fg = M.palette.white },
  Keyword           = { fg = M.palette.blue, bold = true },
  PreProc           = { fg = M.palette.green },
  Type              = { fg = M.palette.blue, bold = true },
  StorageClass      = { fg = M.palette.blue, bold = true },
  Structure         = { fg = M.palette.blue },
  Typedef           = { fg = M.palette.blue },
  Special           = { fg = M.palette.red },
  Underlined        = { underline = true },
  Error             = { fg = M.palette.red, bg = M.palette.black, bold = true },
  Todo              = { fg = M.palette.black, bg = M.palette.yellow, bold = true },

  -- Treesitter (links to Syntax highlights)
  ['@text.literal']         = { link = 'String' },
  ['@text.uri']             = { fg = M.palette.cyan, underline = true },
  ['@text.title']           = { link = 'Title' },
  ['@text.emphasis']        = { italic = true },
  ['@text.strong']          = { bold = true },
  ['@comment']              = { link = 'Comment' },
  ['@punctuation.delimiter'] = { fg = M.palette.light_grey },
  ['@punctuation.bracket']  = { fg = M.palette.light_grey },
  ['@constant']             = { link = 'Constant' },
  ['@constant.builtin']     = { link = 'Constant' },
  ['@string']               = { link = 'String' },
  ['@character']            = { link = 'Character' },
  ['@number']               = { link = 'Number' },
  ['@boolean']              = { link = 'Boolean' },
  ['@float']                = { link = 'Float' },
  ['@function']             = { link = 'Function' },
  ['@function.builtin']     = { link = 'Function' },
  ['@function.macro']       = { link = 'PreProc' },
  ['@method']               = { link = 'Function' },
  ['@keyword']              = { link = 'Keyword' },
  ['@operator']             = { link = 'Operator' },
  ['@variable']             = { link = 'Identifier' },
  ['@variable.builtin']     = { fg = M.palette.cyan, bold = true },
  ['@variable.parameter']   = { fg = M.palette.light_grey, italic = true },
  ['@type']                 = { link = 'Type' },
  ['@type.builtin']         = { link = 'Type' },
  ['@tag']                  = { fg = M.palette.blue },
  ['@tag.attribute']        = { fg = M.palette.green },
  ['@tag.delimiter']        = { fg = M.palette.light_grey },

  -- LSP Diagnostics
  LspDiagnosticsDefaultError       = { fg = M.palette.red },
  LspDiagnosticsDefaultWarning     = { fg = M.palette.yellow },
  LspDiagnosticsDefaultInformation = { fg = M.palette.cyan },
  LspDiagnosticsDefaultHint        = { fg = M.palette.grey },
  LspDiagnosticsUnderlineError     = { undercurl = true, sp = M.palette.red },
  LspDiagnosticsUnderlineWarning   = { undercurl = true, sp = M.palette.yellow },
  LspDiagnosticsUnderlineInformation = { undercurl = true, sp = M.palette.cyan },
  LspDiagnosticsUnderlineHint      = { undercurl = true, sp = M.palette.grey },

  -- nvim-tree
  NvimTreeRootFolder      = { fg = M.palette.yellow, bold = true },
  NvimTreeFolderIcon      = { fg = M.palette.blue, bold = true },
  NvimTreeFolderName      = { fg = M.palette.blue },
  NvimTreeOpenedFolderName= { fg = M.palette.blue, bold = true, italic = true },
  NvimTreeFileIcon        = { fg = M.palette.light_grey },
  NvimTreeFileName        = { fg = M.palette.light_grey },
  NvimTreeGitDirty        = { fg = M.palette.yellow },
  NvimTreeGitNew          = { fg = M.palette.green },
  NvimTreeImageFile       = { fg = M.palette.magenta },
  NvimTreeSymlink         = { fg = M.palette.cyan, italic = true },

  -- nvim-cmp
  CmpItemAbbr           = { fg = M.palette.light_grey },
  CmpItemAbbrDeprecated = { fg = M.palette.grey, strikethrough = true },
  CmpItemAbbrMatch      = { fg = M.palette.yellow, bold = true },
  CmpItemKind           = { fg = M.palette.blue },
  CmpItemMenu           = { fg = M.palette.grey },

  -- fzf-lua
  FzfLuaBorder          = { fg = M.palette.dark_grey },
  FzfLuaTitle           = { fg = M.palette.cyan, bold = true },

  -- which-key
  WhichKey              = { fg = M.palette.blue },
  WhichKeyGroup         = { fg = M.palette.yellow },
  WhichKeyDesc          = { fg = M.palette.magenta },
  WhichKeySeparator     = { fg = M.palette.grey },
}

function M.load()
  for group, settings in pairs(M.highlights) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

M.load()

return M 