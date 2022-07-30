local lsp_lines_ok, lsp_lines = pcall(require, 'lsp_lines')
if not lsp_lines_ok then
  return
end

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- LSP lines things
lsp_lines.setup()

local vtext = { prefix = '●' }

vim.diagnostic.config({
  virtual_text = vtext, -- removes duplication of diagnostic messages due to lsp_lines
  virtual_lines = false,
  severity_sort = true,
})

vim.keymap.set('n', '<leader>le', function()
  local virtual_lines_enabled = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({
    virtual_lines = virtual_lines_enabled,
    virtual_text = not virtual_lines_enabled and vtext or false,
  })
end, { desc = 'Toggle lsp_lines' })
