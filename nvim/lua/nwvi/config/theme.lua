return function()
  local colors = require('onedarkpro').get_colors(vim.g.onedarkpro_style)

  require('onedarkpro').setup({
    plugins = {
      barbar = true,
      which_key_nvim = true,
      nvim_tree = true,
    },
    styles = {
      comments = 'italic',
      keywords = 'bold',
    },
    options = {
      window_unfocussed_color = true,
    },
    hlgroups = {
      IndentBlanklineContextChar = { fg = colors.white },
    },
  })
  require('onedarkpro').load()
end
