local lsp_lines_ok, lsp_lines = pcall(require, 'lsp_lines')
if not lsp_lines_ok then
  return
end

-- From https://github.com/folke/dot/
-- Automatically update diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
  virtual_text = false, -- Redundant due to lsp_lines
  severity_sort = true,
})

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- LSP lines things
lsp_lines.setup()

vim.keymap.set('', '<leader>le', lsp_lines.toggle, { desc = 'Toggle lsp_lines' })
