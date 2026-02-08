-- ~/.config/nvim/colors/zigshot.lua
-- Warm Dracula-inspired theme based on your Zig screenshot

vim.opt.background = "dark"
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end

vim.g.colors_name = "zigshot"

local c = {
    -- Background & foreground
    bg         = "#1e222a", -- slightly warmer than pure Dracula
    bg_dark    = "#191d24",
    bg_light   = "#282d36",
    fg         = "#f8f8f2",
    fg_gutter  = "#4d5566",

    -- Main accent colors (warm orange/red from your screenshot)
    orange     = "#ffb86c", -- statements, keywords
    red        = "#ff5555",
    purple     = "#bd93f9",
    green      = "#50fa7b",
    yellow     = "#f1fa8c",
    pink       = "#ff79c6",
    cyan       = "#8be9fd",

    -- Slightly muted versions
    comment    = "#6272a4",
    selection  = "#44475a",
    visual     = "#3e4456",
    menu       = "#21252b",

    -- Git & diff
    git_add    = "#50fa7b",
    git_delete = "#ff5555",
    git_change = "#ffb86c",
}

-- Helper to apply highlights
local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- Editor highlights
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg_dark })
hi("CursorLine", { bg = c.bg_light })
hi("CursorColumn", { bg = c.bg_light })
hi("ColorColumn", { bg = c.bg_light })
hi("LineNr", { fg = c.fg_gutter })
hi("CursorLineNr", { fg = c.orange, bg = c.bg_light, bold = true })
hi("SignColumn", { bg = c.bg })
hi("Visual", { bg = c.visual })
hi("Search", { fg = "#000000", bg = c.yellow })
hi("IncSearch", { fg = "#000000", bg = c.orange })
hi("Pmenu", { fg = c.fg, bg = c.menu })
hi("PmenuSel", { fg = c.bg, bg = c.orange })
hi("PmenuSbar", { bg = c.bg_light })
hi("PmenuThumb", { bg = c.orange })

-- Syntax highlighting (matching your screenshot)
hi("Comment", { fg = c.comment, italic = true })

hi("Constant", { fg = c.cyan })
hi("String", { fg = c.green })
hi("Character", { fg = c.green })
hi("Number", { fg = c.orange })
hi("Boolean", { fg = c.orange })
hi("Float", { fg = c.orange })

hi("Identifier", { fg = c.fg })
hi("Function", { fg = c.yellow, bold = true })

hi("Statement", { fg = c.orange, bold = true }) -- fn, pub, const, var, return, etc.
hi("Conditional", { fg = c.orange, bold = true })
hi("Repeat", { fg = c.orange, bold = true })
hi("Label", { fg = c.orange })
hi("Operator", { fg = c.pink })
hi("Keyword", { fg = c.orange, bold = true })
hi("Exception", { fg = c.orange })

hi("PreProc", { fg = c.pink })
hi("Include", { fg = c.purple })
hi("Define", { fg = c.purple })
hi("Macro", { fg = c.purple })

hi("Type", { fg = c.cyan, bold = true })
hi("StorageClass", { fg = c.orange })
hi("Structure", { fg = c.cyan })
hi("Typedef", { fg = c.cyan })

hi("Special", { fg = c.yellow })
hi("SpecialComment", { fg = c.comment, bold = true })
hi("Error", { fg = c.red, bold = true })
hi("Todo", { fg = c.purple, bold = true })

-- LSP & Diagnostics
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.cyan })
hi("DiagnosticHint", { fg = c.comment })

-- Treesitter (recommended for modern Neovim)
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.orange, bold = true })
hi("@function", { link = "Function" })
hi("@function.builtin", { fg = c.yellow, bold = true })
hi("@keyword.function", { fg = c.orange, bold = true })
hi("@keyword.return", { fg = c.orange, bold = true })
hi("@punctuation", { fg = c.fg })
hi("@string.escape", { fg = c.pink })
hi("@type.builtin", { fg = c.cyan, bold = true })
hi("@namespace", { fg = c.purple })

-- Statusline / Tabline
hi("StatusLine", { fg = c.fg, bg = c.bg_light })
hi("StatusLineNC", { fg = c.comment, bg = c.bg_dark })
hi("TabLineFill", { bg = c.bg_dark })
hi("TabLine", { fg = c.comment, bg = c.bg_dark })
hi("TabLineSel", { fg = c.fg, bg = c.bg_light, bold = true })
