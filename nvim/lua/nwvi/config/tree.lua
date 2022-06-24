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
      adaptive_size = true
    },
    filters = {
      dotfiles = true,
      custom = { '.git' }, -- Hide these files
    },
    git = {
      ignore = true,
    },
  })

  vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
      unstaged = '✗',
      staged = '✓',
      unmerged = '',
      renamed = '➜',
      untracked = '*',
      deleted = '',
      ignored = '◌',
    },
    folder = {
      arrow_open = '',
      arrow_closed = '',
      default = '',
      open = '',
      empty = '',
      empty_open = '',
      symlink = '',
      symlink_open = '',
    },
    lsp = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  }

  map('n', '<F3>', '<cmd>NvimTreeFindFileToggle<CR>')
end
