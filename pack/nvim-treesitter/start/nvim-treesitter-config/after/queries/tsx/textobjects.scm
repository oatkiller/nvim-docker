((jsx_opening_element) @element.outer)
((jsx_self_closing_element) @element.outer)

; inner element without the opening/closing tags
((jsx_element (jsx_opening_element) @_start (_) @body (jsx_closing_element) @_end)
  (#make-range! "element.inner" @_start @_end))

; attributes / props
((jsx_attribute) @attribute.outer)
((jsx_attribute (property_identifier) @attribute.inner)) 