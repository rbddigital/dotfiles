-- =============================================================================
-- Neovim 0.11.6 — Ruby/Rails Development Config (macOS ARM M1)
-- =============================================================================
-- Single-file init.lua — no LazyVim, no bootstrap script.
-- Plugin manager: lazy.nvim (self-bootstrapping)
-- LSP: Solargraph (via rbenv shim)
-- Completion: blink.cmp
-- Formatter: conform.nvim (rubocop)
-- Fuzzy finder: Telescope
-- =============================================================================

-- Default file formats
vim.opt.fileformats = { "unix" }

-- Disable providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_go_provider = 0
-- Disable Mason health checks you don't need
vim.g.mason_binaries_list = false

-- ─── Leader key (must come before lazy) ──────────────────────────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.editorconfig = true

-- ─── Options ─────────────────────────────────────────────────────────────────
local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = false
opt.signcolumn = "yes"

-- Indentation (Ruby convention: 2 spaces)
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = true
opt.showmode = false
opt.colorcolumn = "120"

-- Increase gutter spacing
vim.opt.statuscolumn = "%s%=%l  "
-- Disable fill character (in gutter)
vim.opt.fillchars = "eob: ,vert:¦"

-- Splits
opt.splitbelow = true
opt.splitright = true

-- Persistent undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.swapfile = false
opt.backup = false
opt.undolevels = 5000
opt.undoreload = 5000

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 12

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300
opt.lazyredraw = false

-- Misc
opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.fillchars = { eob = " " }
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.confirm = true
opt.inccommand = "split"

-- Disable built-in plugins we don't need
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor = 1
vim.g.loaded_2html_plugin = 1

-- Better highlighting for Ruby operators (e.g. +, -, ==, &&)
vim.g.ruby_operators = 1

-- Highlight pseudo-operators (e.g. ., ::, ->, &. )
vim.g.ruby_pseudo_operators = 1

-- Other useful ones many devs enable:
vim.g.ruby_spellcheck_strings = 1 -- Spellcheck inside strings/comments
vim.g.ruby_minlines = 500 -- Scan more lines for syntax (default 200; helps with large files)
vim.g.ruby_no_expensive = 0 -- Allow "expensive" folding/syntax features (set to 1 to disable if slow)

-- For Rails-specific extras (if you want them aggressive):
vim.g.ruby_rails = 1

-- Last place
-- Ignore these filetypes
vim.g.lastplace_ignore = "gitcommit,gitrebase,hgcommit,svn,xxd"

-- Ignore these buffer types
vim.g.lastplace_ignore_buftype = "help,nofile,quickfix"

-- Disable automatically opening folds when jumping to last place
vim.g.lastplace_open_folds = 0

-- Function to create command-line abbreviations
local function cmd_abbrev(abbrev, correct)
	vim.cmd("cabbrev " .. abbrev .. " " .. correct)
end

-- Common misspellings for :w (write/save)
cmd_abbrev("W", "w")
cmd_abbrev("wW", "w")
cmd_abbrev("Wq", "w")
cmd_abbrev("WQ", "w")

-- Common misspellings for :q (quit)
cmd_abbrev("Q", "q")
cmd_abbrev("qQ", "q")
cmd_abbrev("Qa", "q")
cmd_abbrev("QA", "q")

-- Common misspellings for :wq (write and quit)
cmd_abbrev("Wq", "wq")
cmd_abbrev("WQ", "wq")
cmd_abbrev("wQ", "wq")

-- Common misspellings for :wqa (write and quit all)
cmd_abbrev("Wqa", "wqa")
cmd_abbrev("WQA", "wqa")
cmd_abbrev("wQA", "wqa")
cmd_abbrev("wQa", "wqa")
cmd_abbrev("Wa", "wqa")
cmd_abbrev("WA", "wqa")

-- Common misspellings for :qa (quit all)
cmd_abbrev("Qa", "qa")
cmd_abbrev("QA", "qa")
cmd_abbrev("qA", "qa")

-- Map wrapper
function _G.map(mode, lhs, rhs, desc)
	-- normalize mode value: allow "n" or { "n" }
	if type(mode) == "table" and #mode == 1 then
		mode = mode[1]
	end

	vim.keymap.set(mode, lhs, rhs, {
		noremap = true,
		silent = true,
		desc = desc,
	})
end

function _G.lsp_map(bufnr, mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, {
		noremap = true,
		silent = true,
		desc = desc,
		buffer = bufnr, -- buffer-local!
	})
end

-- ── Diagnostics appearance ────────────────────────────────────────
vim.diagnostic.config({
	virtual_text = { spacing = 4, prefix = "●" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})

-- Diagnostics
vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "Error" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "󰈸", texthl = "Warn" })
vim.fn.sign_define("DiagnosticSignSpell", { text = "X", texthl = "Warn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "󰋽", texthl = "Info" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "Hint" })

-- Show diagnostics in a floating window on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})

-- ─── Bootstrap lazy.nvim ─────────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
	-- start of lazy manager
	-- Icons for keymaps and UI
	{ "nvim-tree/nvim-web-devicons" },
	-- Mini icons (required by mini.starter for better UI)
	{ "echasnovski/mini.icons", version = false },
	-- Highlight word under cursor
	{
		"tzachar/local-highlight.nvim",
		event = "VeryLazy",
		config = function()
			require("local-highlight").setup({
				min_match_len = 2,
				max_match_len = 30,
				cw_hlgroup = "LocalHighlight",
				highlight_single_match = true,
				debounce_timeout = 50,
				animate = {
					enabled = false,
				},
			})

			vim.cmd("LocalHighlightOn")
		end,
	},
	-- Color column as a characters
	{
		"lukas-reineke/virt-column.nvim",
		opts = {},
		config = function()
			require("virt-column").setup({
				char = "¦",
				virtcolumn = "80,120",
			})
		end,
	},
	-- Mini starter
	{
		"echasnovski/mini.starter",
		version = false, -- use latest commit
		lazy = false, -- load immediately
		config = function()
			local starter = require("mini.starter")

			starter.setup({
				evaluate_single = true, -- auto-open item if only one matches when typing
				autoopen = true, -- we'll handle opening manually via autocmd
				header = table.concat({
					"",
					" ██████╗ █████╗  ██████╗ ",
					" ██╔══██╗██╔══██╗██╔══██╗",
					" ██████╔╝█████╔╝ ██║  ██║",
					" ██╔══██╗██╔══██╗██║  ██║",
					" ██║  ██║█████╔╝ ██████╔╝",
					" ╚═╝  ╚═╝╚════╝  ╚═════╝ ",
					"",
					"   RBD digital — Neovim",
					"",
				}, "\n"),
				footer = "",
			})
		end,
	},
	-- Colorscheme
	{
		"nkxxll/ghostty-default-style-dark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("ghostty-default-style-dark").setup({})
		end,
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Treesitter – syntax highlighting & textobj  │
	-- └──────────────────────────────────────────────┘
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			-- Install parsers declaratively
			require("nvim-treesitter").setup({
				ensure_installed = {
					"ruby",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"html",
					"css",
					"javascript",
					"json",
					"yaml",
					"toml",
					"bash",
					"regex",
					"markdown",
					"markdown_inline",
					"erb",
					"embedded_template",
					"sql",
				},
			})

			-- Highlighting and indent are now enabled via vim options
			vim.treesitter.language.register("ruby", "ruby")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local ts_select = require("nvim-treesitter-textobjects.select")
			local ts_move = require("nvim-treesitter-textobjects.move")

			-- Textobject selection keymaps
			local select_maps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
			}
			for key, query in pairs(select_maps) do
				vim.keymap.set({ "x", "o" }, key, function()
					ts_select.select_textobject(query, "textobjects", "o")
				end, { desc = "Select " .. query })
			end

			-- Movement keymaps
			local move_maps = {
				["]m"] = { query = "@function.outer", method = "goto_next_start" },
				["]]"] = { query = "@class.outer", method = "goto_next_start" },
				["[m"] = { query = "@function.outer", method = "goto_previous_start" },
				["[["] = { query = "@class.outer", method = "goto_previous_start" },
			}
			for key, conf in pairs(move_maps) do
				vim.keymap.set({ "n", "x", "o" }, key, function()
					ts_move[conf.method](conf.query, "textobjects")
				end, { desc = conf.method .. " " .. conf.query })
			end
		end,
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  LSP progress indicator                      │
	-- └──────────────────────────────────────────────┘
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		opts = {
			notification = { window = { winblend = 0 } },
		},
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Endwise – auto-add `end` for Ruby blocks    │
	-- └──────────────────────────────────────────────┘
	-- endwise: auto-add `end` for Ruby/Lua blocks
	-- RRethy/nvim-treesitter-endwise is incompatible with newer treesitter,
	-- so we use tpope's classic vim-endwise instead.
	{
		"tpope/vim-endwise",
		ft = { "ruby", "eruby", "lua", "bash", "elixir", "vim" },
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Which-key – show keybinding hints           │
	-- └──────────────────────────────────────────────┘
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			spec = {
				{ "<leader>f", group = "find" },
				{ "<leader>g", group = "git" },
				{ "<leader>h", group = "hunks" },
				{ "<leader>l", group = "lsp" },
				{ "<leader>x", group = "diagnostics" },
			},
		},
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Indent guides                               │
	-- └──────────────────────────────────────────────┘
	{
		"echasnovski/mini.indentscope",
		version = "*",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "lazy", "mason", "oil" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Statusline – lualine                        │
	-- └──────────────────────────────────────────────┘
	{
		"zaldih/themery.nvim",
		lazy = false,
		config = function()
			require("themery").setup({
				themes = { "catppuccin", "tokyonight", "kanagawa", "gruvbox" }, -- Add yours here
				livePreview = true,
			})
		end,
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Statusline – lualine                        │
	-- └──────────────────────────────────────────────┘

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			options = {
				-- theme = "catppuccin",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = {
					"diagnostics",
					{
						"filetype",
						icon_only = true,
					},
					"encoding",
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		},
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Git signs in gutter                         │
	-- └──────────────────────────────────────────────┘
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local map = function(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
				end
				map("n", "]h", gs.next_hunk, "Next hunk")
				map("n", "[h", gs.prev_hunk, "Prev hunk")
				map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
				map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
				map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end, "Blame line")
				map("n", "<leader>hd", gs.diffthis, "Diff this")
			end,
		},
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Last place – restore cursor position        │
	-- └──────────────────────────────────────────────┘
	{
		"ethanholz/nvim-lastplace",
		lazy = false,
		opts = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
			lastplace_open_folds = true,
		},
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Trouble – better diagnostics list           │
	-- └──────────────────────────────────────────────┘
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
			{ "<leader>xl", "<cmd>Trouble lsp toggle focus=false<cr>", desc = "LSP definitions / refs" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
		},
		opts = {},
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  TailwindCSS plugins                         │
	-- └──────────────────────────────────────────────┘
	{
		"brenoprata10/nvim-highlight-colors",
		event = "VeryLazy",
		config = function()
			require("nvim-highlight-colors").setup({
				render = "background", -- or "foreground" or "virtual"
				enable_tailwind = true,
			})
		end,
	},

	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  LSP – Solargraph + lua_ls for Neovim config  │
	-- └──────────────────────────────────────────────┘
	-- nvim-lspconfig is still useful as a source of default configs
	-- that get loaded into vim.lsp.config automatically, but we
	-- configure and enable servers via the native 0.11 API.
	{
		"neovim/nvim-lspconfig",
		lazy = true, -- loaded by vim.lsp.enable below
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Completion – blink.cmp                      │
	-- └──────────────────────────────────────────────┘
	{
		"saghen/blink.cmp",
		version = "1.*",
		lazy = false,
		opts = {
			keymap = { preset = "super-tab" },
			appearance = {
				nerd_font_variant = "mono",
			},
			completion = {
				menu = { border = "rounded" },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded" },
				},
				ghost_text = { enabled = true },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = { enabled = true },
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Formatting – conform.nvim (rubocop)          │
	-- └──────────────────────────────────────────────┘
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				ruby = { "rubocop" },
				eruby = { "erb_format" },
				lua = { "stylua" },
				json = { "jq" },
				yaml = { "yamlfmt" },
				markdown = { "prettier" },
				["_"] = { "trim_whitespace" },
			},
			default_format_opts = {
				timeout_ms = 3000,
				lsp_format = "fallback",
			},
			format_on_save = {
				timeout_ms = 3000,
				lsp_format = "fallback",
			},
			formatters = {
				rubocop = {
					-- Use rbenv shim so it picks up project-local rubocop version
					command = os.getenv("HOME") .. "/.rbenv/shims/rubocop",
					args = { "--server", "-a", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" },
				},
			},
		},
	},

	-- ┌──────────────────────────────────────────────┐
	-- │  Telescope – fuzzy finder                    │
	-- └──────────────────────────────────────────────┘
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		cmd = "Telescope",
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
			{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
			{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
			{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
			{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
			{ "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace symbols" },
			{ "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
			{ "<leader>th", "<cmd>Telescope colorscheme enable_preview=true<cr>", desc = "Themes" },
			{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
			{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
			{ "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
			{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy find in buffer" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					prompt_prefix = "   ",
					selection_caret = "  ",
					path_display = { "smart" },
					file_ignore_patterns = {
						"node_modules",
						".git/",
						"tmp/",
						"log/",
						"vendor/bundle",
						"coverage/",
						".bundle/",
						"ruby-lsp/",
						"cache/",
					},
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<esc>"] = actions.close,
						},
					},
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = { preview_width = 0.55 },
						width = 0.87,
						height = 0.80,
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						find_command = { "fd", "--type", "f", "--strip-cwd-prefix", "--hidden", "--exclude", ".git" },
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
		end,
	},

	-- end of lazy manager
}, {
	-- lazy.nvim configuration
	checker = { enabled = true, notify = false },
	change_detection = { notify = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	ui = { border = "rounded" },
})

-- Colorscheme theme
-- vim.cmd.colorscheme("ghostty-default-style-dark")
vim.cmd.colorscheme("zig")

-- Custom Ruby-themed Highlights
local set_hl = vim.api.nvim_set_hl

-- Matches your Starship 'color_ruby' (#991b1b) and 'color_berry' (#be123c)
set_hl(0, "CursorLine", { bg = "#3e4452" })
set_hl(0, "Search", { bg = "#991b1b", fg = "#f8f8f2" })
set_hl(0, "Visual", { bg = "#be123c", fg = "#f8f8f2" })
set_hl(0, "LineNr", { fg = "#5c6370" })
set_hl(0, "CursorLineNr", { fg = "#be123c", bold = true })

-- Clear search highlight
map({ "n" }, "<Esc>", ":nohlsearch<CR>", "Switch off search highlight")
map({ "n" }, "<C-a>", "ggVG", "Select all")
map({ "n" }, "<leader>w", ":bdelete<CR>", "Close buffer")

-- ─── LSP Configuration (native Neovim 0.11 API) ─────────────────────────────

-- Global capabilities for all LSP servers (blink.cmp integration)
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", ".git" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})

-- Ruby LSP (for code actions + RuboCop integration)
vim.lsp.config("ruby_lsp", {
	cmd = { "bundle", "exec", "ruby-lsp" },
	filetypes = { "ruby" },

	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		if fname == "" then
			on_dir(vim.fn.getcwd())
			return
		end
		local root = vim.fs.root(bufnr, { "Gemfile", ".git", ".ruby-version" })
		on_dir(root or vim.fn.getcwd())
	end,
	cmd_env = { RUBYOPT = "", BUNDLE_GEMFILE = nil },
	init_options = {
		formatter = "rubocop", -- Keep RuboCop for formatting/code actions
		-- Disable diagnostics server-side (stops ruby-lsp from publishing them)
		enabledFeatures = {
			diagnostics = true,
			-- Keep everything else enabled (code actions, etc.)
			codeActions = true,
			completion = true,
			definition = true,
			documentHighlights = true,
			documentLink = true,
			documentSymbols = true,
			folding = true,
			hover = true,
			inlayHints = true,
			references = true,
			rename = true,
			selectionRange = true,
			semanticHighlighting = true,
			signatureHelp = true,
		},
	},
})

-- ── Solargraph (Ruby) ───────────────────────────────────────────────────────
-- Prerequisites:
--   gem install solargraph solargraph-rails
--   solargraph config          (generates .solargraph.yml)
vim.lsp.config("solargraph", {
	cmd = { os.getenv("HOME") .. "/.rbenv/shims/solargraph", "stdio" },
	filetypes = { "ruby" },
	root_markers = { "Gemfile", ".git" },
	init_options = { formatting = false }, -- let conform handle formatting
	settings = {
		solargraph = {
			diagnostics = false,
			codeActions = false,
			completion = true,
			definition = true,
			documentHighlights = true,
			documentLink = true,
			documentSymbols = true,
			folding = true,
			hover = true,
			inlayHints = true,
			references = true,
			rename = true,
			selectionRange = true,
			semanticHighlighting = true,
			signatureHelp = true,
			useBundler = false, -- set to true if you prefer `bundle exec solargraph`
		},
	},
})

-- TOML → taplo (real TOML LSP)
vim.lsp.config("taplo", {
	cmd = { "taplo", "lsp", "stdio" },
	filetypes = { "toml" },
	root_dir = require("lspconfig.util").root_pattern("Cargo.toml", ".taplo.toml", ".git"),
	single_file_support = true,
	settings = {}, -- taplo uses its own config file (.taplo.toml)
})

-- TailwindCSS
vim.lsp.config("tailwindcss", {
	cmd = { "tailwindcss-language-server", "--stdio" },

	filetypes = {
		"html",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"eruby",
	},

	root_dir = vim.fs.root(0, {
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.mjs",
		"package.json",
	}),
})

vim.lsp.config("cssls", {
	filetypes = { "css" },
})

vim.lsp.config("html", {
	filetypes = { "html" },
	settings = {
		html = {
			format = { indentInnerHtml = true },
		},
	},
})

vim.lsp.config("astro", {
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	root_markers = { "package.json", "astro.config.mjs", ".git" },
	init_options = {
		typescript = {}, -- Lets it auto-detect TS server path
	},
	single_file_support = true,
})

vim.lsp.enable({ "solargraph", "ruby_lsp", "lua_ls", "tailwindcss", "taplo", "html", "cssls", "astro" })

-- ── LSP keymaps ──────────────────────────────────────
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
	callback = function(ev)
		-- local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = "LSP: " .. desc })
		end

		-- Basic Mappings
		map("n", "<leader>ld", vim.lsp.buf.definition, "Go to definition")
		map("n", "<leader>lD", vim.lsp.buf.declaration, "Go to declaration")
		map("n", "<leader>lr", vim.lsp.buf.references, "References")
		map("n", "<leader>li", vim.lsp.buf.implementation, "Implementation")
		map("n", "<leader>lh", vim.lsp.buf.hover, "Hover docs")
		map("n", "<leader>ls", vim.lsp.buf.signature_help, "Signature help")
		map("n", "<leader>ln", vim.lsp.buf.rename, "Rename symbol")
		map("n", "<leader>la", vim.lsp.buf.code_action, "Code action")

		-- Formatting (Conform)
		map("n", "<leader>lf", function()
			require("conform").format({ bufnr = ev.buf })
		end, "Format buffer")
	end,
})

-- General keymaps
local map = vim.keymap.set

-- Better window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize windows with arrows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- J keeps cursor position
map("n", "J", "mzJ`z")

-- Better indenting (stay in visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Clear search highlight
map("n", "<esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Buffer navigation
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- Quickfix navigation
map("n", "]q", "<cmd>cnext<cr>zz", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<cr>zz", { desc = "Prev quickfix" })

-- Paste without overwriting register in visual mode
map("x", "<leader>p", '"_dP', { desc = "Paste without yank" })

-- ─── Autocommands ────────────────────────────────────────────────────────────
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
	group = augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

-- Ruby file settings
autocmd("FileType", {
	group = augroup("RubySettings", { clear = true }),
	pattern = { "ruby", "eruby" },
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
		vim.opt_local.colorcolumn = "120"
	end,
})

-- Remove trailing whitespace on save (unless conform handles it)
autocmd("BufWritePre", {
	group = augroup("TrimWhitespace", { clear = true }),
	pattern = "*",
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})

-- Auto-resize splits when terminal is resized
autocmd("VimResized", {
	group = augroup("AutoResize", { clear = true }),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
	group = augroup("CloseWithQ", { clear = true }),
	pattern = { "help", "lspinfo", "notify", "qf", "checkhealth" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Force LF line endings on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.cmd("set fileformat=unix")
	end,
})
