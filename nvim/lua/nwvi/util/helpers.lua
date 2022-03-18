local M = {}

-- Make directory
function M.mkdir()
  local dir = vim.fn.expand('%:p:h')

  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

-- Reloads config for nvim so I don't need to reopen buffer in some cases
M.reload_config = function()
  for pkg, _ in pairs(package.loaded) do
    if pkg:match('^nwvi') then
      package.loaded[pkg] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.cmd('PackerCompile')

  vim.api.nvim_echo({ { 'Reloaded config' } }, true, {})
end

-- Mapping helpers
M.keymap = {}

local options = { noremap = true, silent = true }

function M.keymap.map(mode, keys, actions, opts)
  vim.api.nvim_set_keymap(mode, keys, actions, opts or options)
end

function M.keymap.buf_map(mode, keys, actions, opts)
  vim.api.nvim_buf_set_keymap(0, mode, keys, actions, opts or options)
end

function M.keymap.lua_map(mode, keys, cmd)
  M.keymap.map(mode, keys, '<cmd>lua ' .. cmd .. '<CR>')
end

function M.keymap.lua_buf_map(mode, keys, cmd)
  M.keymap.buf_map(mode, keys, '<cmd>lua ' .. cmd .. '<CR>')
end

return M
