-- ziglight-light colorscheme
-- Drop into: ~/.config/nvim/colors/ziglight-light.lua

local c = {
    bg       = "#F4F6FA",
    bg_dark  = "#E6E9EF",
    fg       = "#2B3340",
    comment  = "#8A96A8",

    keyword  = "#D06A21",
    func     = "#B88700",
    string   = "#A08040",
    type     = "#207E80",
    constant = "#1E63AA",

    red      = "#D64545",
    green    = "#4FA35B",
    yellow   = "#C09300",
    blue     = "#1E63AA",
    magenta  = "#A259CA",
    cyan     = "#207E80",

    border   = "#CBD2DD",
}

vim.cmd("hi clear")
vim.o.background = "light"
vim.g.colors_name = "ziglight-light"

local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- UI --------------------------------------------------------------

hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg_dark })
hi("FloatBorder", { fg = c.border, bg = c.bg_dark })

hi("CursorLine", { bg = c.bg_dark })
hi("CursorLineNr", { fg = c.yellow, bold = true })
hi("LineNr", { fg = c.comment })

hi("VertSplit", { fg = c.border })
hi("Visual", { bg = "#D8DDE6" })

-- Syntax ----------------------------------------------------------

hi("Comment", { fg = c.comment, italic = true })
hi("Keyword", { fg = c.keyword })
hi("Statement", { fg = c.keyword })
hi("Function", { fg = c.func, bold = true })
hi("Identifier", { fg = c.fg })
hi("Constant", { fg = c.constant })
hi("Type", { fg = c.type })
hi("String", { fg = c.string })
hi("Operator", { fg = c.keyword })
hi("Number", { fg = c.constant })
hi("Boolean", { fg = c.constant })

-- Treesitter (optional) -------------------------------------------

hi("@comment", { fg = c.comment, italic = true })
hi("@keyword", { fg = c.keyword })
hi("@function", { fg = c.func })
hi("@string", { fg = c.string })
hi("@type", { fg = c.type })
hi("@constant", { fg = c.constant })
