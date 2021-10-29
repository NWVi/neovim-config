-- Bootstrap Packer --
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Packer packages --
return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
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
  use 'norcalli/nvim-colorizer.lua' -- Color highlighter

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
    end,
  }

  use { -- Bufferline
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- Statusline
  use { 
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },

    require('plenary.reload').reload_module('lualine', true), -- unload lualine before loading it, needed due to a reload bug
    require('lualine').setup({
      options = {
        theme = 'onedark'
      }
    })

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
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require('nwvi.config.tree')
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
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

  -- UI to select things (files, grep results, open buffers, etc...)
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use 'sindrets/diffview.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

