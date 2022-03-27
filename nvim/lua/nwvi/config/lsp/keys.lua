local lua_buf_map = require('nwvi.util.helpers').keymap.lua_buf_map

local M = {}

function M.setup(client, bufnr)
  lua_buf_map('n', 'gD', 'vim.lsp.buf.declaration()')
  lua_buf_map('n', 'gd', 'vim.lsp.buf.definition()')
  lua_buf_map('n', 'K', 'vim.lsp.buf.hover()')
  lua_buf_map('n', 'gi', 'vim.lsp.buf.implementation()')
  lua_buf_map('n', '<C-k>', 'vim.lsp.buf.signature_help()')
  lua_buf_map('n', '<space>lwa', 'vim.lsp.buf.add_workspace_folder()')
  lua_buf_map('n', '<space>lwr', 'vim.lsp.buf.remove_workspace_folder()')
  lua_buf_map('n', '<space>lwl', 'print(vim.inspect(vim.lsp.buf.list_workspace_folders()))')
  lua_buf_map('n', '<leader>lD', 'vim.lsp.buf.type_definition()')
  lua_buf_map('n', '<leader>lr', 'vim.lsp.buf.rename()')
  lua_buf_map('n', '<leader>lca', 'vim.lsp.buf.code_action()')
  -- lua_buf_map('n', 'gr', 'vim.lsp.buf.references()') -- Handled by trouble.nvim
  lua_buf_map('n', '<leader>le', 'vim.lsp.diagnostic.show_line_diagnostics()')
  lua_buf_map('n', '[d', 'vim.lsp.diagnostic.goto_prev()')
  lua_buf_map('n', ']d', 'vim.lsp.diagnostic.goto_next()')
  lua_buf_map('n', '<space>lq', 'vim.lsp.diagnostic.set_loclist()')
  lua_buf_map('n', '<leader>f', 'vim.lsp.buf.formatting()')
end

return M
