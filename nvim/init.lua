--- Keybindings ---
local map = require('nwvi.util.helpers').keymap.map
vim.g.mapleader = ' ' -- Set SPACE as leader key
map('', '<leader>y', '"+y') -- Copy to system clipboard
map('', '<leader>p', '"+p') -- Paste from system clipboard
map('n', '<leader>w', ':w<CR>') -- Save
map('n', '<leader>q', ':q<CR>') -- Quit current window
map('n', '<leader>qa', ':qa<CR>') -- Quit all windows
map('n', '<leader>cc', ':lcd %:p:h<CR>') -- cd to current file dir
map('n', '<leader>r', [[<cmd>lua require('nwvi.util.helpers').reload_config()<CR>]]) -- Reload config files
map('n', '<Esc>', ':nohlsearch<Bar>:echo<CR>', { silent = true }) -- Disable highlight and clear any message displayed

if require('nwvi.util.bootstrap-packer')() then
  return
end

require('nwvi.settings')
require('nwvi.plugins')
require('nwvi.util')

vim.cmd([[set clipboard=unnamedplus]])
vim.cmd([[autocmd BufWritePre * lua require('nwvi.util.helpers').mkdir()]])
