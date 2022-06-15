return function()
  require('kanagawa').setup({
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = true },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    dimInactive = true, -- dim inactive window `:h hl-NormalNC`
    globalStatus = true, -- adjust window separators highlight for laststatus=3
    colors = {},
    overrides = {
      IndentBlanklineChar = { nocombine = true },
      IndentBlanklineSpaceChar = { nocombine = true },
      IndentBlanklineSpaceCharBlankline = { nocombine = true },
      BufferCurrent = { bg = '#363646' },
      BufferCurrentIndex = { bg = '#363646' },
      BufferCurrentMod = { bg = '#363646', fg = '#FF9E3B' },
      BufferCurrentSign = { bg = '#363646' },
      BufferCurrentTarget = { bg = '#363646' },
      BufferTabpageFill = { bg = '#16161d' },
    },
  })

  vim.cmd('colorscheme kanagawa')
end
