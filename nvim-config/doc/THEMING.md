# OatVim Theming Guide

This document outlines the highlight groups that need to be defined for a complete
OatVim colorscheme.

## Base Highlight Groups

These are the standard Neovim highlight groups that form the foundation of any
colorscheme.

- `Normal`: Default text, background, foreground.
- `Visual`: Selected text in visual mode.
- `CursorLine`: The line the cursor is on.
- `CursorLineNr`: The number of the cursor line.
- `LineNr`: Line numbers.
- `SignColumn`: Column for signs (e.g., git changes, diagnostics).
- `StatusLine`: The status line at the bottom of a window.
- `StatusLineNC`: Status line for non-active windows.
- `TabLine`: The tab line when multiple tabs are open.
- `TabLineSel`: The selected tab.
- `TabLineFill`: The background of the tab line.
- `VertSplit`: The vertical separators between windows.
- `Title`: The title of windows (e.g., in `:help`).
- `Directory`: Directory names.
- `Search`: Search results.
- `IncSearch`: Incremental search highlights.
- `Pmenu`: Popup menu background.
- `PmenuSel`: Selected item in a popup menu.
- `PmenuSbar`: Popup menu scrollbar.
- `PmenuThumb`: Popup menu scrollbar thumb.
- `WildMenu`: Command-line completion menu.
- `Folded`: A folded line of code.
- `DiffAdd`: Added line in a diff.
- `DiffChange`: Changed line in a diff.
- `DiffDelete`: Deleted line in a diff.
- `DiffText`: Text on a changed line in a diff.
- `ColorColumn`: The column highlighted by `colorcolumn`.
- `Conceal`: For concealed text (e.g., in markdown).

## Syntax and Language

- `Comment`: Code comments.
- `Constant`: Constants (e.g., numbers, booleans).
- `String`: String literals.
- `Character`: Character literals.
- `Number`: Numbers.
- `Boolean`: Booleans (`true`, `false`).
- `Float`: Floating-point numbers.
- `Identifier`: Variable names, function names.
- `Function`: Function names.
- `Statement`: Keywords like `if`, `else`, `for`, `while`.
- `Conditional`: `if`, `then`, `else`, `endif`, `switch`, etc.
- `Repeat`: `for`, `while`, etc.
- `Label`: `case`, `default`, etc.
- `Operator`: `+`, `-`, `*`, `/`, `==`, etc.
- `Keyword`: Other keywords (`return`, `import`, `export`).
- `PreProc`: Pre-processor directives (`#include`, `#define`).
- `Type`: Type definitions (`int`, `string`, `bool`).
- `StorageClass`: `static`, `const`, `let`.
- `Structure`: `struct`, `union`, `enum`.
- `Typedef`: `typedef`.
- `Special`: Special characters (e.g., wildcards).
- `Underlined`: Underlined text.
- `Error`: Errors.
- `Todo`: `TODO`, `FIXME`, `XXX` comments.

## Treesitter Highlight Groups

Treesitter provides more granular syntax highlighting. These are some of the most
common groups. A full list can be found with `:help treesitter-highlight-groups`.

- `@text.literal`: Literals (strings, numbers, etc.).
- `@text.uri`: URLs, emails, etc.
- `@text.title`: Titles in markup.
- `@text.emphasis`: Emphasized text (italics).
- `@text.strong`: Strong text (bold).
- `@comment`: Comments.
- `@punctuation.delimiter`: Delimiters like `,`, `;`.
- `@punctuation.bracket`: `(`, `)`, `[`, `]`, `{`, `}`.
- `@constant`: General constants.
- `@constant.builtin`: Built-in constants.
- `@string`: Strings.
- `@character`: Characters.
- `@number`: Numbers.
- `@boolean`: Booleans.
- `@float`: Floats.
- `@function`: Functions.
- `@function.builtin`: Built-in functions.
- `@function.macro`: Macros.
- `@method`: Methods.
- `@keyword`: Keywords.
- `@operator`: Operators.
- `@variable`: Variables.
- `@variable.builtin`: Built-in variables.
- `@variable.parameter`: Function parameters.
- `@type`: Types.
- `@type.builtin`: Built-in types.
- `@tag`: Tags (e.g., in HTML, XML).
- `@tag.attribute`: Tag attributes.
- `@tag.delimiter`: Tag delimiters (`<`, `>`, `/>`).

## LSP Diagnostics

- `LspDiagnosticsDefaultError`: Error-level diagnostics.
- `LspDiagnosticsDefaultWarning`: Warning-level diagnostics.
- `LspDiagnosticsDefaultInformation`: Info-level diagnostics.
- `LspDiagnosticsDefaultHint`: Hint-level diagnostics.
- `LspDiagnosticsUnderlineError`: Underline for errors.
- `LspDiagnosticsUnderlineWarning`: Underline for warnings.
- `LspDiagnosticsUnderlineInformation`: Underline for info.
- `LspDiagnosticsUnderlineHint`: Underline for hints.

## Plugin Support

### nvim-tree

- `NvimTreeRootFolder`: The root folder in the tree.
- `NvimTreeFolderIcon`: The icon for folders.
- `NvimTreeFolderName`: The name of folders.
- `NvimTreeOpenedFolderName`: The name of an opened folder.
- `NvimTreeFileIcon`: The icon for files.
- `NvimTreeFileName`: The name of files.
- `NvimTreeGitDirty`: Git dirty status.
- `NvimTreeGitNew`: Git new file status.
- `NvimTreeImageFile`: Image file names.
- `NvimTreeSymlink`: Symlinks.

### nvim-cmp (Completion)

- `CmpItemAbbr`: Abbreviation in the completion menu.
- `CmpItemAbbrDeprecated`: Deprecated item.
- `CmpItemAbbrMatch`: Matched characters in the abbreviation.
- `CmpItemKind`: The "kind" of completion (e.g., Text, Method).
- `CmpItemMenu`: Extra info in the menu.

### fzf-lua

- `FzfLuaBorder`: The border of the FZF window.
- `FzfLuaTitle`: The title of the FZF window.

### which-key

- `WhichKey`: The main text for which-key.
- `WhichKeyGroup`: The group description.
- `WhichKeyDesc`: The description of the mapping.
- `WhichKeySeperator`: The separator (`->`).

### Copilot

- `CopilotSuggestion`: The greyed-out suggestion text from Copilot. 