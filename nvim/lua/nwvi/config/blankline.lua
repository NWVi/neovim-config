require('indent_blankline').setup({
  filetype_exclude = {
    'man',
    'diagnosticpopup',
    'lspinfo',
    'packer',
    'TelescopePrompt',
    'TelescopeResults',
    '',
  },
  use_treesitter = true,
  show_current_context = true,
  buftype_exclude = { 'terminal' },
})

-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = '99999'
