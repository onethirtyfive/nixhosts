-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = {"*.tf", "*.tfvars"},
--   callback = function()
--     vim.lsp.buf.formatting_sync()
--   end,
-- })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Basic Keymaps ]]

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { noremap = true, desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { noremap = true, desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { noremap = true, desc = "Open diagnostics list" })

require('fidget').setup{}
require('nvim-web-devicons').setup{}
require('which-key').setup{}
require('Comment').setup{}
require('nvim-ts-autotag').setup{}

require("nvim-tree").setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
  filters = {
    custom = {
      "^.git$",
      "^._*$",
      "^.DS_Store",
      "__pycache__",
      "^.mypy_cache"
    },
  },
})

-- Setup neovim lua configuration
require('neodev').setup()

local luasnip = require('luasnip')
luasnip.setup{}
luasnip.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })

require('gitsigns').setup{
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  }
}

-- not using copilot for now
-- require("copilot").setup({
--   suggestion = { enabled = false },
--   panel = { enabled = false },
-- })

local lspkind = require("lspkind")
lspkind.init({
  symbol_map = {
    -- Copilot = "",
  },
})

-- nvim-projects
require("project_nvim").setup {
  patterns = {
    "!^nixhosts",
    ".git",
    "package.json",
    "pyproject.toml", "requirements.txt",
    "Gemfile",
    "Cargo.toml",
  },
  exclude_dirs = {
    "~/.cargo/*",
    "rustlings/exercises",
  }
}

-- vim-tmux-navigator

vim.keymap.set('n', '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'window left' })
vim.keymap.set('n', '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'window right' })
vim.keymap.set('n', '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'window down' })
vim.keymap.set('n', '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'window up' })

-- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

vim.api.nvim_command([[
  silent! colorscheme solarized
  silent! set bg=dark
]]);

vim.api.nvim_command([[
  silent! set et tabstop=2 shiftwidth=2 softtabstop=2
  silent! set autoindent
]]);

vim.diagnostic.config {
  float = { border = "rounded" },
}

-- vim.g.python3_host_prog = ""

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

