return function()
  local wk = safe_require('which-key')
  local gitsigns = safe_require('gitsigns')
  if not gitsigns and not wk then
    return
  end

  gitsigns.setup({
    signs = {
      add = { hl = 'GitSignsAdd', text = '▎' },
      change = { hl = 'GitSignsChange', text = '▎' },
      delete = { hl = 'GitSignsDelete', text = '契' },
      topdelete = { hl = 'GitSignsDelete', text = '契' },
      changedelete = { hl = 'GitSignsChange', text = '▎' },
    },
  })

  wk.register({
    g = {
      m = { '<Cmd>GitSigns change_base main<CR>', 'Change base main' },
      h = { '<Cmd>GitSigns change_base<CR>', 'Change base original' },
      n = { '<Cmd>GitSigns change_base ', 'Change base ...' },
    }
  }, { prefix = '<leader>' })

  wk.register({
    ["["] = {
      g = {'&diff ? "[g" : "<cmd>Gitsigns prev_hunk<CR>"', 'Jump to prev hunk', expr = true}
    },
    ["]"] = {
      g = {'&diff ? "]g" : "<cmd>Gitsigns next_hunk<CR>"', 'Jump to next hunk', expr = true}
    }
  }, { mode = 'n' })
end
