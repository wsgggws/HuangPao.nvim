local M = {}

function M.get(p)
  return {
    LspReferenceText = { bg = p.bg_selected },
    LspReferenceRead = { bg = p.bg_selected },
    LspReferenceWrite = { fg = p.text_strong, bg = p.bg_selected, bold = true },
    LspReferenceTarget = { fg = p.text_strong, bg = p.match, underline = true },
    LspSignatureActiveParameter = { fg = p.orange, bg = p.match, bold = true },
    LspCodeLens = { fg = p.text_faint },
    LspCodeLensSeparator = { fg = p.text_faint },
    LspInlayHint = { fg = p.text_faint, bg = p.bg_alt },

    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.comment"] = { link = "@comment" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.macro"] = { link = "@constant.macro" },
    ["@lsp.type.method"] = { link = "@function.method" },
    ["@lsp.type.modifier"] = { link = "@keyword" },
    ["@lsp.type.namespace"] = { link = "@namespace" },
    ["@lsp.type.number"] = { link = "@number" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.regexp"] = { link = "@string.regexp" },
    ["@lsp.type.string"] = { link = "@string" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type" },
    ["@lsp.type.variable"] = { link = "@variable" },
    ["@lsp.typemod.function.defaultLibrary"] = { fg = p.aqua },
    ["@lsp.typemod.method.defaultLibrary"] = { fg = p.aqua },
    ["@lsp.typemod.variable.defaultLibrary"] = { fg = p.purple },
    ["@lsp.typemod.variable.readonly"] = { fg = p.orange },
  }
end

return M
