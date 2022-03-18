return function()
  local colors = require('onedarkpro').get_colors(vim.g.onedarkpro_style)
  local base0 = '#1B2229'
  local base1 = '#1c1f24'
  local base2 = '#202328'
  local base3 = '#23272e'
  local base4 = '#3f444a'
  local base5 = '#5B6268'
  local base6 = '#73797e'
  local base7 = '#9ca0a4'
  local base8 = '#DFDFDF'
  local base9 = '#E6E6E6'

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
      -- Indentline
      IndentBlanklineContextChar = { fg = colors.white },

      -- Barbar
      BufferCurrent = { fg = base9 },
      BufferCurrentIndex = { fg = base6 },
      BufferCurrentMod = { fg = colors.yellow },
      BufferCurrentSign = { fg = colors.purple },
      BufferCurrentTarget = { fg = colors.red },

      BufferInactive = { fg = base6, bg = base1 },
      BufferInactiveIndex = { fg = base6, bg = base1 },
      BufferInactiveMod = { fg = colors.yellow, bg = base1 },
      BufferInactiveSign = { fg = base4, bg = base1 },
      BufferInactiveTarget = { fg = colors.red, bg = base1 },

      BufferTabpages = { fg = colors.purple },
      BufferTabpageFill = { fg = base4, bg = base1 },
    },
  })
  require('onedarkpro').load()
end
