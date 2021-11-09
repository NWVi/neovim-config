return function()
  require('doom-one').setup({
      cursor_coloring = false,
      terminal_colors = false,
      italic_comments = true,
      enable_treesitter = true,
      transparent_background = false,
      pumblend = {
        enable = true,
        transparency_amount = 20,
      },
      plugins_integrations = {
        neorg = false,
        barbar = true,
        bufferline = false,
        gitgutter = false,
        gitsigns = true,
        telescope = true,
        neogit = false,
        nvim_tree = true,
        dashboard = false,
        startify = false,
        whichkey = true,
        indent_blankline = true,
        vim_illuminate = false,
        lspsaga = false,
      },
  })
end
