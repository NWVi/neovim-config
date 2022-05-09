local lsp_sign = safe_require('lsp_signature')

lsp_sign.setup({
  debug = false,
  hint_enable = false,
  floating_window_above_cur_line = false,
  handler_opts = { border = 'rounded' },
  max_width = 80,
})
