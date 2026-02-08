-- File: ~/.config/nvim/colors/retro_zig_light.lua
-- Retro-Zig Light: Light retro theme with Treesitter and LSP

local M = {}

function M.setup()
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    vim.o.background = "light"
    vim.o.termguicolors = true

    local colors = {
        bg         = "#f5f0e6",
        fg         = "#2a241c",
        black      = "#2a241c",
        red        = "#c65f3a",
        green      = "#7b946d",
        yellow     = "#bfa758",
        blue       = "#4c6d7a",
        magenta    = "#7d6a87",
        cyan       = "#5b8b81",
        comment    = "#8c7f6e",
        string     = "#9f8f73",
        cursorline = "#e6dfd2",
    }

    local hi = vim.api.nvim_set_hl

    -- Core highlights
    hi(0, "Normal", { fg = colors.fg, bg = colors.bg })
    hi(0, "CursorLine", { bg = colors.cursorline })
    hi(0, "Comment", { fg = colors.comment, italic = true })
    hi(0, "Constant", { fg = colors.cyan })
    hi(0, "String", { fg = colors.string })
    hi(0, "Identifier", { fg = colors.blue })
    hi(0, "Function", { fg = colors.yellow })
    hi(0, "Statement", { fg = colors.red, bold = true })
    hi(0, "Type", { fg = colors.magenta })
    hi(0, "Keyword", { fg = colors.red, bold = true })
    hi(0, "Operator", { fg = colors.yellow })
    hi(0, "Special", { fg = colors.magenta })
    hi(0, "Number", { fg = colors.cyan })
    hi(0, "Boolean", { fg = colors.cyan })

    -- Treesitter highlights
    hi(0, "@comment", { fg = colors.comment, italic = true })
    hi(0, "@constant", { fg = colors.cyan })
    hi(0, "@constant.builtin", { fg = colors.cyan, bold = true })
    hi(0, "@function", { fg = colors.yellow })
    hi(0, "@function.builtin", { fg = colors.yellow, bold = true })
    hi(0, "@keyword", { fg = colors.red, bold = true })
    hi(0, "@variable", { fg = colors.fg })
    hi(0, "@type", { fg = colors.magenta })
    hi(0, "@operator", { fg = colors.yellow })
    hi(0, "@string", { fg = colors.string })
    hi(0, "@number", { fg = colors.cyan })
    hi(0, "@boolean", { fg = colors.cyan })
    hi(0, "@constant.macro", { fg = colors.red })
    hi(0, "@namespace", { fg = colors.blue })
    hi(0, "@punctuation.bracket", { fg = colors.fg })

    -- LSP diagnostics
    hi(0, "DiagnosticError", { fg = colors.red })
    hi(0, "DiagnosticWarn", { fg = colors.yellow })
    hi(0, "DiagnosticInfo", { fg = colors.blue })
    hi(0, "DiagnosticHint", { fg = colors.cyan })
end

M.setup()
return M
