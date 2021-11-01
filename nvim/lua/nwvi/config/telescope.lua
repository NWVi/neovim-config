return function()
  local telescope = safe_require('telescope')
  if not telescope then
    return
  end

  local actions = require 'telescope.actions'
  telescope.setup({
    defaults = {
      mappings = {
        i = {
          ['<esc>'] = actions.close,
        },
      },
    },
  })
end
