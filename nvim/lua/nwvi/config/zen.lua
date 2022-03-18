return function()
  local map = require('nwvi.util.helpers').keymap.map
  local tz = safe_require('true-zen')
  if not tz then
    return
  end

  tz.setup({
    integrations = {
      tmux = true,
      gitsigns = true,
      lualine = true,
    },
  })

  map('n', '<leader>zf', ':TZFocus<CR>')
  map('n', '<leader>za', ':TZAtaraxis<CR>')
end
