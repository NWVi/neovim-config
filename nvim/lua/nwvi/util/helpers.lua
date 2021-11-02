local M = {}

-- Mapping helpers
M.keymap = {}

local options = { noremap = true, silent = true }

function M.keymap.map(mode, keys, actions, opts)
  vim.api.nvim_set_keymap(mode, keys, actions, opts or options)
end

return M
