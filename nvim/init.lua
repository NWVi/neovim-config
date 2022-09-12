--- Keybindings ---
vim.keymap.set('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' ' -- Set SPACE as leader key
vim.keymap.set('', '<leader>y', '"+y') -- Copy to system clipboard
vim.keymap.set('', '<leader>p', '"_dP', { desc = 'Paste without copy' })
vim.keymap.set('n', '<leader>w', ':w<CR>') -- Save
vim.keymap.set('n', '<leader>q', ':q<CR>') -- Quit current window
vim.keymap.set('n', '<leader>qa', ':qa<CR>') -- Quit all windows
vim.keymap.set('n', '<leader>cc', ':lcd %:p:h<CR>') -- cd to current file dir
vim.keymap.set('n', '<leader>r', [[<cmd>lua require('nwvi.util.helpers').reload_config()<CR>]]) -- Reload config files
vim.keymap.set('n', '<Esc>', ':nohlsearch<Bar>:echo<CR>', { silent = true }) -- Disable highlight and clear any message displayed
vim.keymap.set('n', '<F5>', ':!dotnet build && cp -r source/EsetServerApi/bin/Debug/net6.0/win-x64 ~/mnt/Desktop/eset-api/<CR>') -- Quit all windows

require('nwvi.settings')
require('nwvi.plugins')
require('nwvi.util')

vim.cmd([[set clipboard=unnamedplus]])
vim.cmd([[autocmd BufWritePre * lua require('nwvi.util.helpers').mkdir()]])
