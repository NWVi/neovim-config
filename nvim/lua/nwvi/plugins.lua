local function conf(name)
  return require(string.format('nwvi.config.%s', name))
end

-- Packer packages --
return require('packer').startup(function()
  use('wbthomason/packer.nvim') -- Package manager

  -- UI to select things (files, grep results, open buffers, etc...)
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
      }),
    },
    config = conf('telescope'),
  })

  use({ -- Dumb indentation detection
    'Darazaki/indent-o-matic',
    config = function()
      return require('indent-o-matic').setup({
        -- Space indentations that should be detected
        standard_widths = { 2, 4, 8 },
      })
    end,
  })

  use({
    'lukas-reineke/indent-blankline.nvim', -- Indentation guides
    config = conf('indentline'),
  })

  -- Navigation
  use({
    'knubie/vim-kitty-navigator', -- Easy navigating between tmux and vim buffers
    run = 'cp ./*.py ~/.config/kitty/',
    opt = true,
    config = conf('navigate'),
    cond = function()
      return vim.env.KITTY_PID ~= nil
    end,
  })

  use({
    'christoomey/vim-tmux-navigator', -- Easy navigating between tmux and vim buffers
    opt = true,
    config = conf('navigate'),
    cond = function()
      return vim.env.KITTY_PID == nil
    end,
  })

  use({
    'norcalli/nvim-colorizer.lua', -- Color highlighter
    config = function()
      require('colorizer').setup({ '*' }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all css features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        mode = 'background', -- Set the display mode
      }) -- enable color higlighting
    end,
  })

  use({
    'rebelot/kanagawa.nvim',
    config = conf('theme'),
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
          globalstatus = true,
        },
      })
    end,
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
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
      'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag',
    },
    config = conf('treesitter'),
  })

  use({
    'echasnovski/mini.nvim',
    branch = 'stable',
    after = 'nvim-treesitter',
    config = conf('mini'),
  })

  use({ -- Autocompletion plugin
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer', -- buffer completions
      'hrsh7th/cmp-path', -- path completions
      'saadparwaiz1/cmp_luasnip', -- snippet completions
      {
        'L3MON4D3/LuaSnip', -- Snippets plugin
        requires = 'rafamadriz/friendly-snippets', -- a bunch of snippets
        config = conf('luasnip'),
      },
      {
        'danymat/neogen',
        requires = 'nvim-treesitter/nvim-treesitter',
        config = function()
          require('neogen').setup({
            enabled = true,
            languages = {
              cs = {
                template = {
                  annotation_convention = 'xmldoc',
                },
              },
            },
          })
        end,
      },
    },
    config = conf('cmp'),
  })

  use({ -- LSP
    'neovim/nvim-lspconfig',
    after = 'nvim-cmp',
    requires = {
      'ray-x/lsp_signature.nvim',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      'jose-elias-alvarez/null-ls.nvim',
      'williamboman/nvim-lsp-installer', -- simple to use language server installer
      use({ 'simrat39/rust-tools.nvim' }),
      use({ 'folke/lua-dev.nvim' }),
      'mfussenegger/nvim-dap', -- debugger
    },
    config = conf('lsp'),
  })

  use({
    'folke/trouble.nvim',
    event = 'BufReadPre',
    requires = 'nvim-web-devicons',
    cmd = { 'TroubleToggle', 'Trouble' },
    config = conf('trouble'),
  })

  use({ -- Highlighting TODO comments
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'folke/trouble.nvim' },
    cmd = { 'TodoTrouble', 'TodoQuickFix', 'TodoTelescope', 'TodoLocList' },
    config = conf('todo'),
  })

  use({ -- Git symbols in symbolline
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = conf('gitsigns'),
  })

  use({ -- Git conflics
    'akinsho/git-conflict.nvim',
    config = function()
      require('git-conflict').setup({})
    end,
  })

  use({ -- Git and diff
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    opt = true,
    cmd = { 'Neogit', 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFileHistory' },
    config = function()
      require('neogit').setup({
        integrations = {
          diffview = true,
        },
      })
    end,
  })

  use('mattn/emmet-vim')

  use({
    'folke/zen-mode.nvim',
    config = conf('zen'),
    cmd = { 'ZenMode' },
  })

  use({
    'windwp/nvim-autopairs',
    config = conf('autopairs'),
  })

  use({
    'nvim-neorg/neorg',
    requires = {
      'nvim-neorg/neorg-telescope', -- Be sure to pull in the repo
      'nvim-lua/plenary.nvim',
    },
    cmd = { 'NeorgStart' },
    config = conf('neorg'),
  })

  use({
    'akinsho/toggleterm.nvim',
    cmd = { 'ToggleTerm', 'ToggleTermToggleAll', '2ToggleTerm' },
    config = conf('toggleterm'),
  })

  use({
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    setup = function()
      vim.g.mkdp_filetypes = { 'markdown' }
    end,
    ft = { 'markdown' },
  })

  use({ -- Code outline window (similar to gutentag)
    'stevearc/aerial.nvim',
    cmd = { 'AerialToggle' },
    config = conf('aerial'),
  })

  use({ -- smooth scrolling
    'declancm/cinnamon.nvim',
    config = function()
      require('cinnamon').setup({
        default_delay = 1,
      })
    end,
  })

  use({
    'nvim-neotest/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python',
      'nwvi/vim-test',
      'nvim-neotest/neotest-vim-test',
    },
    config = conf('neotest'),
  })

  use({
    'folke/which-key.nvim',
    config = conf('keys'),
  })

  use({
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('octo').setup()
    end,
  })

  use({
    'phaazon/hop.nvim',
    -- branch = 'v1', -- optional but strongly recommended
    config = conf('hop'),
  })
end)
