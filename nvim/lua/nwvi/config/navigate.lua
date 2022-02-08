local map = require('nwvi.util.helpers').keymap.map
local navTool = vim.env.KITTY_PID ~= nil and 'Kitty' or 'Tmux'

if vim.env.KITTY_PID then
  vim.g.kitty_navigator_no_mappings = true
else
  vim.g.tmux_navigator_no_mappings = true
end

map('n', '<M-h>', ':'..navTool..'NavigateLeft') -- Navigate left (buffer and tmux)
map('n', '<M-j>', ':'..navTool..'NavigateDown<CR>') -- Navigate down (buffer and tmux)
map('n', '<M-k>', ':'..navTool..'NavigateUp<CR>') -- Navigate up (buffer and tmux)
map('n', '<M-l>', ':'..navTool..'NavigateRight<CR>') -- Navigate right (buffer and tmux)
