; extends
; lighter — TypeScript-specific keyword coloring.
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
