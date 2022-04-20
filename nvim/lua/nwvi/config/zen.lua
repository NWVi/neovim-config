return function()
  local map = require('nwvi.util.helpers').keymap.map
  local zen = safe_require('zen-mode')
  if not zen then
    return
  end

  zen.setup({
    window = {
      backdrop = 1,
    },
  })

  map('n', '<leader>zf', ':ZenMode<CR>')
end
