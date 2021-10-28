vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_auto_open = 1 -- Auto open tree if no file is specified when opening 'nvim'
vim.g.nvim_tree_auto_close = 1 -- Auto close when last window
vim.g.nvim_tree_follow = 1 -- Allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_auto_ignore_ft = { "dashboard", "startify" }
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_lsp_diagnostics = 1

vim.g.nvim_tree_icons = {
  default= '',
  symlink= '',
  git= {
    unstaged = "✗",
    staged = "✓",
    unmerged = "",
    renamed = "➜",
    untracked = "★",
    deleted = "",
    ignored = "◌"
  },
  folder= {
    arrow_open= "",
    arrow_closed= "",
    default= "",
    open= "",
    empty= "",
    empty_open= "",
    symlink= "",
    symlink_open= "",
  },
  lsp= {
    hint= "",
    info= "",
    warning= "",
    error= "",
  }
}

require("nvim-tree.events").on_nvim_tree_ready(function()
  vim.cmd("NvimTreeRefresh")
end)
