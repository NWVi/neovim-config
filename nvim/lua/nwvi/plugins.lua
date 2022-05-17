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
      require('colorizer').setup() -- enable color higlighting
    end,
  })

  use({ -- colorscheme
    'olimorris/onedarkpro.nvim',
    config = conf('theme'),
  })

  use({
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup({
        undercurl = true, -- enable undercurls
        commentStyle = 'italic',
        functionStyle = 'NONE',
        keywordStyle = 'italic',
        statementStyle = 'bold',
        typeStyle = 'NONE',
        variablebuiltinStyle = 'italic',
        specialReturn = true, -- special highlight for the return keyword
        specialException = true, -- special highlight for exception handling keywords
        transparent = false, -- do not set background color
        dimInactive = true, -- dim inactive window `:h hl-NormalNC`
        globalStatus = true, -- adjust window separators highlight for laststatus=3
        colors = {},
        overrides = {
          IndentBlanklineChar = { style = 'nocombine' },
          IndentBlanklineSpaceChar = { style = 'nocombine' },
          IndentBlanklineSpaceCharBlankline = { style = 'nocombine' },
          BufferCurrent = { bg = '#363646' },
          BufferCurrentIndex = { bg = '#363646' },
          BufferCurrentMod = { bg = '#363646', fg = '#FF9E3B' },
          BufferCurrentSign = { bg = '#363646' },
          BufferCurrentTarget = { bg = '#363646' },
          BufferTabpageFill = { bg = '#16161d' },
        },
      })

      vim.cmd('colorscheme kanagawa')
    end,
  })

  use('ellisonleao/gruvbox.nvim')

  use('projekt0n/github-nvim-theme')

  use({
    'catppuccin/nvim',
    as = 'catppuccin',
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

  use({ -- Highlighting TODO comments
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = conf('todo'),
  })

  use({ -- Autocompletion plugin
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer', -- buffer completions
      'hrsh7th/cmp-path', -- path completions
      -- 'hrsh7th/cmp-cmdline', -- cmdline completions
      'saadparwaiz1/cmp_luasnip', -- snippet completions
      {
        'L3MON4D3/LuaSnip', -- Snippets plugin
        wants = 'friendly-snippets',
        config = conf('luasnip'),
      },
      {
        'danymat/neogen',
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
        requires = 'nvim-treesitter/nvim-treesitter',
      },
      'rafamadriz/friendly-snippets', -- a bunch of snippets
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
      'simrat39/rust-tools.nvim',
      'folke/lua-dev.nvim',
      'mfussenegger/nvim-dap', -- debugger
    },
    config = conf('lsp'),
  })

  use({
    'folke/trouble.nvim',
    event = 'BufReadPre',
    wants = 'nvim-web-devicons',
    cmd = { 'TroubleToggle', 'Trouble' },
    config = conf('trouble'),
  })

  use({ -- Git symbols in symbolline
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = conf('gitsigns'),
  })

  use({
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
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
  })

  use({
    'windwp/nvim-autopairs',
    config = conf('autopairs'),
  })

  use({
    'nvim-neorg/neorg',
    config = conf('neorg'),
    requires = {
      'nvim-neorg/neorg-telescope', -- Be sure to pull in the repo
      'nvim-lua/plenary.nvim',
    },
  })

  use({
    'akinsho/toggleterm.nvim',
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

  use({
    'folke/which-key.nvim',
    config = conf('keys'),
  })
end)
