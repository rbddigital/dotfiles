-- Custom Ruby-themed Highlights
-- Matches your Starship 'color_ruby' (#991b1b) and 'color_berry' (#be123c)
-- Custom Ruby-themed Highlights (The proper Lua way)
local set_hl = vim.api.nvim_set_hl

-- Matches your Starship 'color_ruby' (#991b1b) and 'color_berry' (#be123c)
set_hl(0, "CursorLine", { bg = "#3e4452" })
set_hl(0, "Search",     { bg = "#991b1b", fg = "#f8f8f2" })
set_hl(0, "Visual",     { bg = "#be123c", fg = "#f8f8f2" })
set_hl(0, "LineNr",     { fg = "#5c6370" })
set_hl(0, "CursorLineNr", { fg = "#be123c", bold = true })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        -- This ensures the binaries are downloaded to your Mac
        ensure_installed = { "solargraph", "vtsls" } 
      })

      -- THE NEW WAY (Neovim 0.11+)
      -- Instead of require('lspconfig'), we use the new vim.lsp.config interface
      
      -- Ruby Setup
      vim.lsp.config('solargraph', {
        default_config = {
          cmd = { 'solargraph', 'stdio' },
          filetypes = { 'ruby' },
          root_markers = { 'Gemfile', '.git' },
          settings = {
            solargraph = { diagnostics = true }
          },
        },
      })
      vim.lsp.enable('solargraph')

      -- TypeScript/Bun Setup
      vim.lsp.config('vtsls', {
        default_config = {
          cmd = { 'vtsls', '--stdio' },
          filetypes = { 'javascript', 'typescript', 'typescriptreact' },
          root_markers = { 'package.json', 'bun.lockb', '.git' },
        },
      })
      vim.lsp.enable('vtsls')

      -- Global Keybindings
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    end
  },
})

-- Basic Settings
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = false -- Makes jumping to lines faster (e.g., 5j)
vim.opt.mouse = 'a'            -- Enable mouse support
vim.opt.ignorecase = true      -- Smart searching
vim.opt.smartcase = true
vim.opt.hlsearch = false       -- Don't keep highlights after searching
vim.opt.wrap = true            -- Wrap lines

-- Tabs & Indentation
vim.opt.tabstop = 2            -- Standard for Ruby/TS
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- System Clipboard
vim.opt.clipboard = "unnamedplus" -- Sync with macOS clipboard

-- Appearance
vim.opt.termguicolors = true   -- Use Ghostty's high-res colors
vim.opt.cursorline = true      -- Highlight the line you are on

-- Set leader key to Space (this is the pro way)
vim.g.mapleader = " "

-- Quick save with Space + w
vim.keymap.set("n", "<leader>w", ":w<CR>")
