-- From https://github.com/folke/dot/
-- Automatically update diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- underline = true,
  -- update_in_insert = false,
  virtual_text = { spacing = 4, prefix = '●' },
  severity_sort = true,
  signs = false,
})

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
