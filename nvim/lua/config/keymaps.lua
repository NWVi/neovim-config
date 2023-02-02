vim.keymap.set('n', ' ', '<Nop>', { silent = true, remap = false })
vim.g.mapleader = ' ' -- make sure to set `mapleader` before lazy so your mappings are correct

local function map(mode, lhs, rhs, opts)
  local keys = require('lazy.core.handler').handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- better up/down
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Move Lines
map('n', '<A-j>', ':m .+1<cr>==', { desc = 'Move down' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
map('i', '<A-j>', '<Esc>:m .+1<cr>==gi', { desc = 'Move down' })
map('n', '<A-k>', ':m .-2<cr>==', { desc = 'Move up' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })
map('i', '<A-k>', '<Esc>:m .-2<cr>==gi', { desc = 'Move up' })
