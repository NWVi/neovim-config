local function conf(name)
  return require(string.format('nwvi.config.%s', name))
end

-- Packer packages --
return require('packer').startup(function()
  use('wbthomason/packer.nvim') -- Package manager

  -- UI to select things (files, grep results, open buffers, etc...)
  use({
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = conf('telescope'),
  })

  use({
    'lukas-reineke/indent-blankline.nvim', -- Indentation guides
    config = function()
      require('nwvi.config.blankline')
    end,
  })

  -- Navigation
  use({
    'knubie/vim-kitty-navigator', -- Easy navigating between tmux and vim buffers
    run = 'cp ./*.py ~/.config/kitty/',
    opt = true,
    config = function()
      require('nwvi.config.navigate')
    end,
    cond = function()
      return vim.env.KITTY_PID ~= nil
    end,
  })

  use({
    'christoomey/vim-tmux-navigator', -- Easy navigating between tmux and vim buffers
    opt = true,
    config = function()
      require('nwvi.config.navigate')
    end,
    cond = function()
      return vim.env.KITTY_PID == nil
    end,
  })

  use({
    'norcalli/nvim-colorizer.lua', -- Color highlighter
    config = function()
      require('colorizer').setup() -- enable color higlighting
    end,
  })

  use({ -- colorscheme
    'olimorris/onedarkpro.nvim',
    config = conf('theme'),
  })

  use({ -- Embed in web browsers
    'glacambre/firenvim',
    run = function()
      vim.fn['firenvim#install'](0)
    end,
  })

  use({ -- Bufferline
    'romgrk/barbar.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = conf('barbar'),
  })

  use({ -- Statusline
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',
        },
      })
    end,
  })

  use({ -- Git symbols in symbolline
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = conf('gitsigns'),
  })

  use({ -- File explorer
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = conf('tree'),
  })

  use({ -- Syntax tree
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
      'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag',
    },
    config = function()
      require('nwvi.config.treesitter')
    end,
  })

  use({ -- Commenting
    'numToStr/Comment.nvim',
    requires = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      require('Comment').setup({
        pre_hook = function(ctx)
          return require('ts_context_commentstring.internal').calculate_commentstring()
        end,
      })
    end,
  })

  use({ -- Highlighting TODO comments
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup()
    end,
  })

  use({ -- Autocompletion plugin
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer', -- buffer completions
      'hrsh7th/cmp-path', -- path completions
      'hrsh7th/cmp-cmdline', -- cmdline completions
      'saadparwaiz1/cmp_luasnip', -- snippet completions
      {
        'L3MON4D3/LuaSnip', -- Snippets plugin
        wants = 'friendly-snippets',
      },
      use('rafamadriz/friendly-snippets'), -- a bunch of snippets to
    },
    config = conf('cmp'),
  })

  use({ -- LSP
    'neovim/nvim-lspconfig',
    after = 'nvim-cmp',
    requires = {
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      'jose-elias-alvarez/null-ls.nvim',
      'williamboman/nvim-lsp-installer', -- simple to use language server installer
      'folke/lua-dev.nvim',
    },
    config = conf('lsp'),
  })

  use('projekt0n/github-nvim-theme')

  use({
    'folke/trouble.nvim',
    event = 'BufReadPre',
    wants = 'nvim-web-devicons',
    cmd = { 'TroubleToggle', 'Trouble' },
    config = conf('trouble'),
  })

  use('sindrets/diffview.nvim')

  use('machakann/vim-sandwich') -- Surround

  use('mattn/emmet-vim')

  use({
    'Pocco81/TrueZen.nvim',
    config = conf('zen'),
  })

  use({
    'windwp/nvim-autopairs',
    config = conf('autopairs'),
  })

  use({
    'nvim-neorg/neorg',
    config = function()
      require('neorg').setup({
        load = {
          ['core.defaults'] = {},
          ['core.norg.dirman'] = {
            config = {
              workspaces = {
                work = '~/notes/work',
                home = '~/notes/home',
              },
            },
          },
          ['core.norg.completion'] = {
            config = {
              engine = 'nvim-cmp',
            },
          },
          ['core.keybinds'] = {
            config = { -- Note that this table is optional and doesn't need to be provided
              -- Configuration here
              default_bindings = true,
            },
          },
          ['core.norg.concealer'] = {
            config = {
              preset = 'basic',
              icons = {
                todo = {
                  enabled = true,

                  done = {
                    enabled = true,
                    icon = '',
                    highlight = 'NeorgTodoItemDoneMark',
                    query = '(todo_item_done) @icon',
                    extract = function()
                      return 1
                    end,
                  },

                  pending = {
                    enabled = true,
                    icon = '',
                    highlight = 'NeorgTodoItemPendingMark',
                    query = '(todo_item_pending) @icon',
                    extract = function()
                      return 1
                    end,
                  },

                  undone = {
                    enabled = true,
                    icon = '×',
                    highlight = 'NeorgTodoItemUndoneMark',
                    query = '(todo_item_undone) @icon',
                    extract = function()
                      return 1
                    end,
                  },

                  uncertain = {
                    enabled = true,
                    icon = '',
                    highlight = 'NeorgTodoItemUncertainMark',
                    query = '(todo_item_uncertain) @icon',
                    extract = function()
                      return 1
                    end,
                  },

                  on_hold = {
                    enabled = true,
                    icon = '',
                    highlight = 'NeorgTodoItemOnHoldMark',
                    query = '(todo_item_on_hold) @icon',
                    extract = function()
                      return 1
                    end,
                  },

                  cancelled = {
                    enabled = true,
                    icon = '',
                    highlight = 'NeorgTodoItemCancelledMark',
                    query = '(todo_item_cancelled) @icon',
                    extract = function()
                      return 1
                    end,
                  },

                  recurring = {
                    enabled = true,
                    icon = '↺',
                    highlight = 'NeorgTodoItemRecurringMark',
                    query = '(todo_item_recurring) @icon',
                    extract = function()
                      return 1
                    end,
                  },

                  urgent = {
                    enabled = true,
                    icon = '⚠',
                    highlight = 'NeorgTodoItemUrgentMark',
                    query = '(todo_item_urgent) @icon',
                    extract = function()
                      return 1
                    end,
                  },
                },
              },
            },
          },
        },
      })
    end,
    requires = 'nvim-lua/plenary.nvim',
  })

  use({
    'folke/which-key.nvim',
    config = conf('keys'),
  })
end)
