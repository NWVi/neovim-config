return function()
  local lsp_sign = safe_require('lsp_signature')

  lsp_sign.setup({
    debug = true,
    hint_enable = false,
    floating_window_above_cur_line = false,
    handler_opts = { border = 'single' },
    max_width = 80,
  })
end
