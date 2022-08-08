return function()
  local navTool = vim.env.KITTY_PID ~= nil and 'Kitty' or 'Tmux'

  if vim.env.KITTY_PID then
    vim.g.kitty_navigator_no_mappings = true
  else
    vim.g.tmux_navigator_no_mappings = true
  end

  vim.keymap.set('n', '<C-Left>', '<Cmd>' .. navTool .. 'NavigateLeft<CR>') -- Navigate left (buffer and tmux)
  vim.keymap.set('n', '<C-Down>', '<Cmd>' .. navTool .. 'NavigateDown<CR>') -- Navigate down (buffer and tmux)
  vim.keymap.set('n', '<C-Up>', '<Cmd>' .. navTool .. 'NavigateUp<CR>') -- Navigate up (buffer and tmux)
  vim.keymap.set('n', '<C-Right>', '<Cmd>' .. navTool .. 'NavigateRight<CR>') -- Navigate right (buffer and tmux)
end
