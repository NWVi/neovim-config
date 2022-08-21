return function()
  local autopairs = safe_require('nvim-autopairs')
  if not autopairs then
    return
  end

  autopairs.setup({
    chck_ts = true,
    ts_config = {
      lua = { 'string', 'source' },
      javascript = { 'string', 'template_string' },
      java = false,
    },
    disable_filetype = { 'TelescopePrompt' },
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
      offset = 0, -- Offset from pattern match
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      highlight = 'PmenuSel',
      highlight_grey = 'LineNr',
    },
  })

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = safe_require('cmp')
  if not cmp then
    return
  end
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end
