--- Keybindings ---
local map = require('nwvi.util.helpers').keymap.map
vim.g.mapleader = ' ' -- Set SPACE as leader key
map('', '<leader>c', '"+y') -- Copy to system clipboard
map('n', '<leader>w', ':w<CR>') -- Save
map('n', '<leader>q', ':q<CR>') -- Quit current window
map('n', '<leader>qa', ':qa<CR>') -- Quit all windows
map('n', '<leader>r', [[<cmd>lua require('nwvi.util').reload_config()<CR>]]) -- Reload config files
map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
map('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]])
map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]])
map('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
map('n', '<leader>sl', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]])
map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
map('n', '<Esc>', ':nohlsearch<Bar>:echo<CR>', { silent = true }) -- Disable highlight and clear any message displayed

--- TMUX ---
vim.g.tmux_navigator_no_mappings = true
map('n', '<M-h>', ':TmuxNavigateLeft<CR>') -- Navigate left (buffer and tmux)
map('n', '<M-j>', ':TmuxNavigateDown<CR>') -- Navigate down (buffer and tmux)
map('n', '<M-k>', ':TmuxNavigateUp<CR>') -- Navigate up (buffer and tmux)
map('n', '<M-l>', ':TmuxNavigateRight<CR>') -- Navigate right (buffer and tmux)

if require('nwvi.util.bootstrap-packer')() then
  return
end

require('nwvi.settings')
require('nwvi.plugins')
require('nwvi.util')
