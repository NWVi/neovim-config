return function()
  require('indent_blankline').setup({
    use_treesitter = true,
    show_current_context = true,
    buftype_exclude = { 'terminal' },
    filetype_exclude = {
      'help',
      'man',
      'diagnosticpopup',
      'lspinfo',
      'lsp-installer',
      'packer',
      'TelescopePrompt',
      'TelescopeResults',
      'Trouble',
      'starter',
      'norg',
      '',
    },
  })

  -- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
  vim.wo.colorcolumn = '99999'
end
