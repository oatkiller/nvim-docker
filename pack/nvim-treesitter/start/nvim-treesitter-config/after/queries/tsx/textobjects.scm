; ----------------------------------------------------------------------------
;  Tree-sitter text-objects for TSX / JSX
;
;  This file lives under:
;    after/queries/tsx/textobjects.scm
;  Neovim loads it automatically (thanks to nvim-treesitter) and merges it
;  with the built-in queries.  Each top-level S-expression describes a pattern
;  in the syntax tree and assigns one or more *captures* (the @names) to the
;  matched nodes.  Those capture names are what the Lua config refers to in
;  keymaps, e.g.  `@element.outer` or `@attribute.inner`.
;
;  Naming convention used here:
;    @thing.outer – whole syntax node including delimiters and whitespace.
;    @thing.inner – just the meaningful part inside the delimiters.
;
;  Captures defined below:
;    element.outer / element.inner   – React element (`<Tag …>` … `</Tag>`)
;    attribute.outer / attribute.inner – JSX attribute / prop
; ----------------------------------------------------------------------------

; === Elements ==============================================================
; Match opening tags and self-closing tags as the *outer* element.  This gives
; the user a way to yank/change/delete the whole element including brackets.
((jsx_opening_element) @element.outer)
((jsx_self_closing_element) @element.outer)

; *Inner* element – everything between the opening and closing tags, without
; the angle brackets themselves.
((jsx_element (jsx_opening_element) @_start (_) @body (jsx_closing_element) @_end)
  (#make-range! "element.inner" @_start @_end))

; === Attributes / props ====================================================
; Whole attribute: includes name, equal sign and possible value
((jsx_attribute) @attribute.outer)

; Inner attribute: just the identifier / value (no whitespace or equal sign)
((jsx_attribute (property_identifier) @attribute.inner)) 