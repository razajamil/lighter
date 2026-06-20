-- LSP diagnostics + semantic token highlights, see `:h lsp-highlight`.
local M = {}

---@param c lighter.Palette
function M.get_hl(c)
  -- stylua: ignore
  return {
    DiagnosticError                          = { fg = c.danger },
    DiagnosticHint                           = { fg = c.info },
    DiagnosticInfo                           = { fg = c.fg },
    DiagnosticOK                             = { fg = c.success },
    DiagnosticWarn                           = { fg = c.warning },
    LspInlayHint                             = { fg = c.comment },
    ["@lsp.type.comment"]                    = {}, -- defer to treesitter styles
    ["@lsp.type.lifetime"]                   = { fg = c.const },
    ["@lsp.type.modifier"]                   = { link = "Keyword" },
    ["@lsp.type.struct"]                     = { fg = c.fg },
    ["@lsp.typemod.namespace.attribute"]     = { link = "Keyword" },
    ["@lsp.typemod.interface.declaration"]   = { fg = c.fg },
    ["@lsp.typemod.interface.public"]        = { fg = c.fg },
    ["@lsp.typemod.struct.declaration"]      = { fg = c.fg },
    ["@lsp.typemod.enum.declaration"]        = { fg = c.fg },
    ["@lsp.typemod.type.declaration"]        = { fg = c.fg },
    ["@lsp.typemod.class.declaration"]       = { fg = c.fg },
    ["@lsp.typemod.class.globalScope"]       = { fg = c.fg },
    ["@lsp.typemod.generic.attribute"]       = { fg = c.fg },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
  }
end

return M
