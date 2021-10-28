
require('nwvi.util')
require('nwvi.plugins')

require("indent_blankline").setup {
    char = "|",
    buftype_exclude = {"terminal"}
}


require('nvim-web-devicons').setup() -- ensable devicons

require('colorizer').setup() -- enable color higlighting

--- Helpers ---
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opt = vim.opt  -- to set options

local function map(mode, keys, actions, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, keys, actions, options)
end

--- Options  ---
opt.mouse = 'a' -- enable mouse mode
opt.tabstop = 2 -- default spaces for tab
opt.shiftwidth = 2 -- size of an indent
opt.shiftround = true -- round indent to multiple of shiftwidth
opt.expandtab = true -- use spaces instead of tabs
opt.number = true -- show numbers
opt.ignorecase = true -- Case insensitive
opt.smartcase = true -- Case insensitive unless /C or capital in search
opt.breakindent = true -- Enable break indent
opt.smartindent = true -- Smart autoindenting on new line
opt.updatetime = 250 -- milliseconds from typing to saving swap file
opt.list = true -- show some invisible characters
opt.termguicolors=true -- True color support
opt.hidden = true -- Do not save when switching buffers

--- Keybindings ---
vim.g.mapleader = ' ' -- Set SPACE as leader key
map('', '<leader>c', '"+y') -- Copy to system clipboard
map('n', '<leader>w', ':w<CR>') -- Save
map('n', '<leader>q', ':q<CR>') -- Quit current window
map('n', '<leader>qa', ':qa<CR>') -- Quit all windows
map('n', '<leader>r', [[<cmd>lua require('nwvi.util').reload_config()<CR>]], {noremap = true, silent = true}) -- Reload config files
map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
map('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

vim.g.tmux_navigator_no_mappings = true
map('n', '<M-h>', ':TmuxNavigateLeft<CR>', { silent = true } ) -- Navigate left (buffer and tmux)
map('n', '<M-j>', ':TmuxNavigateDown<CR>', { silent = true }) -- Navigate down (buffer and tmux)
map('n', '<M-k>', ':TmuxNavigateUp<CR>', { silent = true }) -- Navigate up (buffer and tmux)
map('n', '<M-l>', ':TmuxNavigateRight<CR>', { silent = true }) -- Navigate right (buffer and tmux)
map('n', '<C-n>', ':bnext<CR>') -- Next buffer
map('n', '<C-p>', ':bprev<CR>') -- Previous buffer
