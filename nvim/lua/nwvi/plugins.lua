local function conf(name)
  return require(string.format('nwvi.config.%s', name))
end

-- Packer packages --
return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  -- UI to select things (files, grep results, open buffers, etc...)
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = conf('telescope')
  }

  use {
    'lukas-reineke/indent-blankline.nvim', -- Indentation guides
    config = function()
      require('nwvi.config.blankline')
    end
  }

  use 'christoomey/vim-tmux-navigator' -- Easy navigating between tmux and vim buffers

  use {
    'norcalli/nvim-colorizer.lua', -- Color highlighter
    config = function()
      require('colorizer').setup() -- enable color higlighting
    end
  }

  use { -- Colorscheme
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
  }

  use { -- Embed in web browsers
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end
  }

  use { -- Bufferline
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = conf('barbar')
  }

  use { -- Statusline
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'onedark'
        }
      })
    end
  }

  use { -- Git symbols in symbolline
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = conf('gitsigns')
  }

  use { -- File explorer
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = conf('tree')
  }

  use { -- Syntax tree
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
      'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag'
    },
    config = function()
      require('nwvi.config.treesitter')
    end
  }

  use { -- Commenting
    'numToStr/Comment.nvim',
    requires = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
        require('Comment').setup({
         pre_hook = function(ctx)
           return require('ts_context_commentstring.internal').calculate_commentstring()
         end
        })
    end
  }

  use { -- Highlighting TODO comments
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup()
    end
  }

  use { -- Completion engine
    'ms-jpq/coq_nvim',
    branch = 'coq',
    event = 'VimEnter',
    requires = { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
    config = 'vim.cmd[[COQnow --shut-up]]'
  }

  use { -- LSP
    'neovim/nvim-lspconfig',
    after = 'coq_nvim',
    requires = { 'williamboman/nvim-lsp-installer' },
    config = conf('lsp')
  }

  use 'sindrets/diffview.nvim'

  use {
    'Pocco81/TrueZen.nvim',
    config = conf('zen')
  }

  use {
    'folke/which-key.nvim',
    config = conf('keys')
  }
end)
