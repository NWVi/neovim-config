return function()
  local map = require('nwvi.util.helpers').keymap.map
  local gitsigns = safe_require('gitsigns')
  if not gitsigns then
    return
  end

  gitsigns.setup({
    signs = {
      add = { hl = 'GitSignsAdd', text = '▎' },
      change = { hl = 'GitSignsChange', text = '▎' },
      delete = { hl = 'GitSignsDelete', text = '契' },
      topdelete = { hl = 'GitSignsDelete', text = '契' },
      changedelete = { hl = 'GitSignsChange', text = '▎' },
    }
  })

  map('n', ']g', '&diff ? "]g" : "<cmd>Gitsigns next_hunk<CR>"', { expr = true })
  map('n', '[g', '&diff ? "[g" : "<cmd>Gitsigns prev_hunk<CR>"', { expr = true })
  map('n', '<space>hm', '<cmd>Gitsigns change_base master<CR>') -- Change base to master
  map('n', '<space>hh', '<cmd>Gitsigns change_base<CR>') -- Change base to original base
  map('n', '<space>hn', '<cmd>Gitsigns change_base ')
end
