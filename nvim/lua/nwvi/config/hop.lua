return function()
  local hop = safe_require('hop')
  local wk = safe_require('which-key')
  if not hop and not wk then
    return
  end

  hop.setup({ keys = 'etovxqpdygfblzhckisuran' })

  wk.register({
    g = {
      w = { '<Cmd>HopWord<CR>', 'Hop word' },
      l = { '<Cmd>HopLine<CR>', 'Hop line' },
      s = { '<Cmd>HopPattern<CR>', 'Hop regex' },
      ['1'] = { '<Cmd>HopChar1<CR>', 'Hop 1 character' },
      ['2'] = { '<Cmd>HopChar2<CR>', 'Hop 2 characters' },
    },
  }, { mode = 'n' })
end
