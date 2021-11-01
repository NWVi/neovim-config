-- Packer packages --
return require('packer').startup(function()
  use {'wbthomason/packer.nvim', -- Package manager
  opt = true
}

  -- UI to select things (files, grep results, open buffers, etc...)
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'lukas-reineke/indent-blankline.nvim', -- Indentation guides
    config = function()
      require('indent_blankline').setup({
        filetype_exclude = {
          'man',
          'diagnosticpopup',
          'lspinfo',
          'packer',
          'TelescopePrompt',
          'TelescopeResults',
          ''
        },
        use_treesitter = true,
        show_current_context = true,
        buftype_exclude = { 'terminal' },
      })
    end
  }

  use 'christoomey/vim-tmux-navigator' -- Easy navigating between tmux and vim buffers
  use {
    'norcalli/nvim-colorizer.lua', -- Color highlighter
    config = function()
      require('colorizer').setup() -- enable color higlighting
    end
  }

  use {
    'NTBBloodbath/doom-one.nvim',
    config = function()
        require('doom-one').setup({
            cursor_coloring = false,
            terminal_colors = false,
            italic_comments = false,
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
                neogit = true,
                nvim_tree = true,
                dashboard = true,
                startify = true,
                whichkey = true,
                indent_blankline = true,
                vim_illuminate = false,
                lspsaga = false,
            },
        })
    end
  }

  use { -- Bufferline
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
  }

  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end 
  }

  -- Statusline
  use { 
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'onedark'
        }
      })
    end,
  }

  use { -- Git symbols in symbolline
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('nwvi.config.gitsigns')
    end
  }

  use { -- File explorer
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('nwvi.config.tree')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nwvi.config.treesitter')
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup({
          pre_hook = function(ctx)
            return require('ts_context_commentstring.internal').calculate_commentstring()
          end
        })
    end,
    requires = 'JoosepAlviste/nvim-ts-context-commentstring',
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require('nwvi.config.keys')
    end
  }

  use 'sindrets/diffview.nvim'

end)
