return function()
  local map = require('nwvi.util.helpers').keymap.map
  local navTool = vim.env.KITTY_PID ~= nil and 'Kitty' or 'Tmux'

  if vim.env.KITTY_PID then
    vim.g.kitty_navigator_no_mappings = true
  else
    vim.g.tmux_navigator_no_mappings = true
  end

  map('n', '<C-Left>', ':' .. navTool .. 'NavigateLeft<CR>') -- Navigate left (buffer and tmux)
  map('n', '<C-Down>', ':' .. navTool .. 'NavigateDown<CR>') -- Navigate down (buffer and tmux)
  map('n', '<C-Up>', ':' .. navTool .. 'NavigateUp<CR>') -- Navigate up (buffer and tmux)
  map('n', '<C-Right>', ':' .. navTool .. 'NavigateRight<CR>') -- Navigate right (buffer and tmux)
end
