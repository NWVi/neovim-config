return function()
  local nvim_tree = safe_require('nvim-tree')
  if not nvim_tree then
    return
  end
  local map = require('nwvi.util.helpers').keymap.map

  require('nvim-tree.events').on_nvim_tree_ready(function()
    vim.cmd('NvimTreeRefresh')
  end)

  nvim_tree.setup({
    view = {
      adaptive_size = true,
    },
    filters = {
      dotfiles = true,
      custom = { '.git' }, -- Hide these files
    },
    git = {
      ignore = true,
    },
  })

  map('n', '<F3>', '<cmd>NvimTreeFindFile<CR>')
end
