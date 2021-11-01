--- Helpers ---
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local g = vim.g      -- a table to access global variables
local opts = { noremap = true, silent = true }

local function map(mode, keys, actions, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, keys, actions, options)
end

--- Keybindings ---
g.mapleader = ' ' -- Set SPACE as leader key
map('', '<leader>c', '"+y') -- Copy to system clipboard
map('n', '<leader>w', ':w<CR>') -- Save
map('n', '<leader>q', ':q<CR>') -- Quit current window
map('n', '<leader>qa', ':qa<CR>') -- Quit all windows
map('n', '<leader>r', [[<cmd>lua require('nwvi.util').reload_config()<CR>]], opts) -- Reload config files
map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
map('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], opts)
map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
map('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
map('n', '<leader>sl', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)
map('n', '<Esc>', ':nohlsearch<Bar>:echo<CR>', { silent = true }) -- Disable highlight and clear any message displayed

--- TMUX ---
g.tmux_navigator_no_mappings = true
map('n', '<M-h>', ':TmuxNavigateLeft<CR>', opts) -- Navigate left (buffer and tmux)
map('n', '<M-j>', ':TmuxNavigateDown<CR>', opts) -- Navigate down (buffer and tmux)
map('n', '<M-k>', ':TmuxNavigateUp<CR>', opts) -- Navigate up (buffer and tmux)
map('n', '<M-l>', ':TmuxNavigateRight<CR>', opts) -- Navigate right (buffer and tmux)

--- Barbar ---
-- Move to previous/next
map('n', '<A-,>', ':BufferPrevious<CR>', opts)
map('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
map('n', '<A->>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferClose<CR>', opts)


if require('nwvi.util.bootstrap-packer')() then
  return
end

require('nwvi.settings')
require('nwvi.plugins')
require('nwvi.util')
