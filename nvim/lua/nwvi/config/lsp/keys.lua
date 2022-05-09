local M = {}

function M.setup(bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', 'vim.lsp.buf.declaration()', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', 'vim.lsp.buf.definition()', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', 'vim.lsp.buf.hover()', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', 'vim.lsp.buf.implementation()', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', 'vim.lsp.buf.signature_help()', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lwa', 'vim.lsp.buf.add_workspace_folder()', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lwr', 'vim.lsp.buf.remove_workspace_folder()', opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    'n',
    '<space>lwl',
    'print(vim.inspect(vim.lsp.buf.list_workspace_folders()))',
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lD', 'vim.lsp.buf.type_definition()', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr', 'vim.lsp.buf.rename()', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<A-CR>', 'vim.lsp.buf.code_action()', opts)
  -- lua_buf_map('n', 'gr', 'vim.lsp.buf.references()') -- Handled by trouble.nvim
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>le', 'vim.lsp.diagnostic.show_line_diagnostics()', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', 'vim.lsp.diagnostic.goto_prev({border = "rounded"})', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', 'vim.lsp.diagnostic.goto_next({border = "rounded"})', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lq', 'vim.lsp.diagnostic.set_loclist()', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', 'vim.lsp.buf.formatting()', opts)

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
end

return M
