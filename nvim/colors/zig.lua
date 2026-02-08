-- ziglight.nvim colorscheme
-- Drop this file into: ~/.config/nvim/colors/ziglight.lua
-- Then load with: :colorscheme ziglight

local c = {
    -- bg       = "#242a34", -- Warmer and a touch lighter – much easier on the eyes
    bg_dark  = "#1e222a",
    bg       = "#152638",
    fg       = "#C8D0E0",
    comment  = "#5A6B8C",

    keyword  = "#FF9E64",
    func     = "#FFD06A",
    string   = "#E6DB74",
    type     = "#5EC4C7",
    constant = "#80BFFF",

    red      = "#FF6E6E",
    green    = "#8CD97C",
    yellow   = "#FFD06A",
    blue     = "#80BFFF",
    magenta  = "#D27FFF",
    cyan     = "#5EC4C7",

    border   = "#293345",
}

vim.cmd("hi clear")
vim.o.background = "dark"
vim.g.colors_name = "zig"

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
hi("Visual", { bg = "#243040" })

-- Syntax ----------------------------------------------------------

hi("Comment", { fg = c.comment, italic = true })
hi("Keyword", { fg = c.keyword, bold = true })
hi("Statement", { fg = c.keyword, bold = true })
hi("Function", { fg = c.func, bold = true })
hi("Identifier", { fg = c.fg })
hi("Constant", { fg = c.constant })
hi("Type", { fg = c.type })
hi("String", { fg = c.string })
hi("Operator", { fg = c.keyword })
hi("Number", { fg = c.constant })
hi("Boolean", { fg = c.constant })

-- Diagnostics -----------------------------------------------------

hi("Error", { fg = c.red })
hi("Warning", { fg = c.yellow })
hi("Info", { fg = c.blue })
hi("Hint", { fg = c.cyan })

-- Optional: Treesitter ------------------------------------------------

hi("@comment", { fg = c.comment, italic = true })
hi("@keyword", { fg = c.keyword, bold = true })
hi("@function", { fg = c.func })
hi("@string", { fg = c.string })
hi("@type", { fg = c.type })
hi("@constant", { fg = c.constant })

-- Make def, end, class, module, etc. bold in Ruby
hi("@keyword.function", { fg = c.keyword, bold = true }) -- covers 'def'
hi("@keyword.return", { fg = c.keyword, bold = true })   -- covers 'end' in blocks

-- Done with main theme ------------------------------------------------

-- IndentLine (or indent-blankline.nvim equivalent)
vim.g.indent_blankline_char_highlight = "LineNr" -- Uses your dim LineNr colour
-- For older indentLine plugin:
vim.g.indentLine_color_gui = c.bg_dark           -- #1e222a or whatever your bg_dark is

-- NERDTree highlights (keyword colour for arrows)
hi("NERDTreeOpenable", { fg = c.keyword })
hi("NERDTreeClosable", { fg = c.keyword })

-- GitGutter (vim-gitgutter or signs in general)
hi("GitGutterAdd", { link = "Constant" })          -- uses your constant colour (blue)
hi("GitGutterChange", { link = "Normal" })
hi("GitGutterDelete", { fg = c.red, bold = true }) -- make delete stand out

-- Optional line highlights if you want background fills
-- hi("GitGutterAddLine",      { bg = "#2a3a2a" })  -- dark green tint
-- hi("GitGutterChangeLine",   { bg = c.bg_dark })
-- hi("GitGutterDeleteLine",   { bg = "#3a2a2a" })  -- dark red tint

-- FZF colours
hi("fzf1", { fg = c.red, bg = c.bg })
hi("fzf2", { fg = c.fg, bg = c.bg }) -- using fg as "variable" stand-in
hi("fzf3", { fg = c.func, bg = c.bg })
hi("fzfNormal", { fg = c.fg })
hi("fzfFgPlus", { fg = c.fg })
hi("fzfBorder", { fg = c.bg })

vim.g.fzf_colors = {
    fg      = { "fg", "fzfNormal" },
    bg      = { "bg", "Normal" },
    hl      = { "fg", "Number" },
    ["fg+"] = { "fg", "fzfFgPlus" },
    ["bg+"] = { "bg", "Pmenu" },
    ["hl+"] = { "fg", "Number" },
    info    = { "fg", "String" },
    border  = { "fg", "fzfBorder" },
    prompt  = { "fg", "fzf2" },
    pointer = { "fg", "Exception" },
    marker  = { "fg", "StorageClass" },
    spinner = { "fg", "Type" },
    header  = { "fg", "CursorLineNr" },
}
