; extends
; lighter — TSX-specific keyword coloring (mirrors typescript).
; Appended to nvim-treesitter's query so these captures win (highest priority).

; Module keywords (import / export / from) — de-emphasized.
[
  "import"
  "export"
  "from"
] @keyword.lighter.import

; Variable-declaration keywords (const / let / var) — dark red.
(lexical_declaration ["const" "let"] @keyword.lighter.const)
(variable_declaration "var" @keyword.lighter.const)

; `return` keyword — same dark red as const / let.
"return" @keyword.lighter.return

; Type-alias declaration name (`type Props = ...`) — the "type" color.
; priority 200 beats LSP semantic tokens; scoped to the declaration only,
; so type *references* keep the regular type color.
((type_alias_declaration name: (type_identifier) @type.lighter.declaration) (#set! "priority" 200))

; JSX element names (built-in + components) — function blue.
; priority 200 beats LSP semantic tokens (125) so this wins for components too.

; simple names: <div>, <Foo>
((jsx_opening_element      name: (identifier) @tag.lighter.element) (#set! "priority" 200))
((jsx_closing_element      name: (identifier) @tag.lighter.element) (#set! "priority" 200))
((jsx_self_closing_element name: (identifier) @tag.lighter.element) (#set! "priority" 200))

; compound / namespaced names: <Foo.Bar>, <motion.div>
((jsx_opening_element      name: (member_expression (identifier) @tag.lighter.element (property_identifier) @tag.lighter.element)) (#set! "priority" 200))
((jsx_closing_element      name: (member_expression (identifier) @tag.lighter.element (property_identifier) @tag.lighter.element)) (#set! "priority" 200))
((jsx_self_closing_element name: (member_expression (identifier) @tag.lighter.element (property_identifier) @tag.lighter.element)) (#set! "priority" 200))
