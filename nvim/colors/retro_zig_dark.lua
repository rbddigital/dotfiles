-- File: ~/.config/nvim/colors/retro_zig_dark.lua
-- Retro-Zig Dark: Brownish retro theme with Treesitter and LSP

local M = {}

function M.setup()
    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    vim.o.background = "dark"
    vim.o.termguicolors = true

    local colors = {
        bg                  = "#2a241c",
        fg                  = "#e0d9d1",
        black               = "#1c1613",
        red                 = "#d27b4c",
        green               = "#a6b48f",
        yellow              = "#d9bd5e",
        blue                = "#6c8fa4",
        magenta             = "#917fa3",
        cyan                = "#7eb0a1",
        comment             = "#6b6358",
        string              = "#b8a88f",
        cursorline          = "#3b3229",
        mode_normal_bg      = "#6d5233",

        -- New colors for lualine
        status_bg           = "#4a4034", -- A slightly lighter, more visible background for the status line
        status_fg           = "#e0d9d1", -- Foreground for normal status line sections
        lualine_inactive_bg = "#3b3229", -- Background for inactive windows (same as CursorLine)
        lualine_inactive_fg = "#9e968b", -- Faded foreground for inactive windows
        insert_mode_bg      = "#a6b48f", -- Green for INSERT mode
        insert_mode_fg      = "#2a241c",
        visual_mode_bg      = "#917fa3", -- Magenta for VISUAL mode
        visual_mode_fg      = "#2a241c",
        command_mode_bg     = "#d27b4c", -- Red/Orange for COMMAND mode
        command_mode_fg     = "#2a241c",
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

    --- Lualine Highlights (Crucial for custom theme) ---

    -- A: Mode indicator (e.g., NORMAL, INSERT)
    hi(0, "LualineA", { fg = colors.bg, bg = colors.mode_normal_bg, bold = true })
    hi(0, "LualineModeNormal", { fg = colors.bg, bg = colors.mode_normal_bg, bold = true })

    -- B: File info (e.g., filename)
    hi(0, "LualineB", { fg = colors.status_fg, bg = colors.status_bg })

    -- C: Main middle section (e.g., git branch, LSP status)
    hi(0, "LualineC", { fg = colors.fg, bg = colors.bg })

    -- X: Right side info (e.g., filetype, encoding)
    hi(0, "LualineX", { fg = colors.status_fg, bg = colors.status_bg })

    -- Y: Position info (e.g., line/col, percentage)
    hi(0, "LualineY", { fg = colors.bg, bg = colors.yellow, bold = true })

    -- Far-right percentage / line:column section
    hi(0, "LualineZ", { fg = colors.bg, bg = colors.mode_normal_bg, bold = true })

    -- Inactive status line highlights
    hi(0, "LualineInactiveA", { fg = colors.lualine_inactive_fg, bg = colors.lualine_inactive_bg })
    hi(0, "LualineInactiveB", { fg = colors.lualine_inactive_fg, bg = colors.lualine_inactive_bg })
    hi(0, "LualineInactiveC", { fg = colors.lualine_inactive_fg, bg = colors.lualine_inactive_bg })

    -- Mode-specific highlights (optional, but highly recommended for A-section)
    hi(0, "LualineModeNormal", { fg = colors.bg, bg = colors.red, bold = true })
    hi(0, "LualineModeInsert", { fg = colors.insert_mode_fg, bg = colors.insert_mode_bg, bold = true })
    hi(0, "LualineModeVisual", { fg = colors.visual_mode_fg, bg = colors.visual_mode_bg, bold = true })
    hi(0, "LualineModeReplace", { fg = colors.visual_mode_fg, bg = colors.red, bold = true }) -- Reusing red
    hi(0, "LualineModeCommand", { fg = colors.command_mode_fg, bg = colors.command_mode_bg, bold = true })
    hi(0, "LualineModeTerminal", { fg = colors.bg, bg = colors.cyan, bold = true })           -- Reusing cyan
    hi(0, "LualineModeOther", { fg = colors.bg, bg = colors.blue, bold = true })              -- Reusing blue

    -- Status line and highlights
    hi(0, "StatusLine", { fg = colors.status_fg, bg = colors.status_bg })
    hi(0, "StatusLineNC", { fg = colors.lualine_inactive_fg, bg = colors.lualine_inactive_bg })
end

M.setup()
return M
