local function conf(name)
  return require(string.format('nwvi.config.%s', name))
end

-- Bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  vim.cmd([[packadd packer.nvim]])
end

-- Packer packages --
return require('packer').startup(function()
  use('wbthomason/packer.nvim') -- Package manager

  use({
    'rebelot/kanagawa.nvim',
    config = conf('theme'),
  })

  use({
    'folke/which-key.nvim',
    config = conf('keys'),
  })

  use({
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
  })

  use({ -- Syntax tree
    'nvim-treesitter/nvim-treesitter-textobjects',
    'RRethy/nvim-treesitter-textsubjects',
    'JoosepAlviste/nvim-ts-context-commentstring',
    'p00f/nvim-ts-rainbow',
    'windwp/nvim-ts-autotag',
    requires = {
      'nvim-treesitter/nvim-treesitter',
      config = require('nwvi.config.treesitter'),
      run = ':TSUpdate',
    },
  })

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
    config = require('nwvi.config.telescope'),
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
    'NvChad/nvim-colorizer.lua', -- Color highlighter
    config = function()
      require('colorizer').setup({
        filetypes = { '*' },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes like Blue or blue
          RRGGBBAA = false, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = false, -- CSS rgb() and rgba() functions
          hsl_fn = false, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = 'background', -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = false, parsers = { css } }, -- Enable sass colors
          virtualtext = '■',
        },
      })
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
          globalstatus = true,
          disabled_filetypes = {
            winbar = {
              'Trouble',
              'toggleterm',
              'neo-tree',
            },
          },
        },
        winbar = {
          lualine_a = {},
          lualine_b = { { 'aerial', sep = ' ❯ ' } },
          lualine_c = {},
          lualine_x = { { 'filetype', icon_only = true }, { 'filename', path = 0 } },
          lualine_y = {},
          lualine_z = {},
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {},
          lualine_x = { { 'filetype', icon_only = true }, { 'filename', path = 0 } },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  })

  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    config = conf('neotree'),
  })

  use({
    'echasnovski/mini.nvim',
    branch = 'stable',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = conf('mini'),
  })

  use({ -- Autocompletion plugin
    'hrsh7th/nvim-cmp',
    config = conf('cmp'),
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
      {
        'windwp/nvim-autopairs',
        config = conf('autopairs'),
      },
    },
  })

  use({
    'mfussenegger/nvim-dap', -- debugger
    requires = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-telescope/telescope-dap.nvim',
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap-python',
      'leoluz/nvim-dap-go',
    },
    config = conf('dap'),
  })

  use({ -- LSP
    'neovim/nvim-lspconfig',
    requires = {
      'j-hui/fidget.nvim',
      'ray-x/lsp_signature.nvim',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      'jose-elias-alvarez/null-ls.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'simrat39/rust-tools.nvim',
      'folke/lua-dev.nvim',
      'j-hui/fidget.nvim',
      'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
      'Hoffs/omnisharp-extended-lsp.nvim',
    },
    after = { 'nvim-dap' },
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
    'Pocco81/true-zen.nvim',
    config = conf('zen'),
  })

  use({
    'nvim-neorg/neorg',
    requires = {
      'nvim-neorg/neorg-telescope', -- Be sure to pull in the repo
      'nvim-lua/plenary.nvim',
    },
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

  use({
    'nvim-neotest/neotest',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python',
      'rouge8/neotest-rust',
      'Issafalcon/neotest-dotnet',
      'nwvi/vim-test',
      'nvim-neotest/neotest-vim-test',
    },
    config = conf('neotest'),
  })

  use({
    '~/NWVi/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('octo').setup({
        use_local_fs = true,
      })
    end,
  })

  use({
    'phaazon/hop.nvim',
    config = conf('hop'),
  })

  use({
    'nvim-treesitter/nvim-treesitter-context',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('treesitter-context').setup({})
    end,
  })

  use({
    'stevearc/aerial.nvim',
    config = function()
      require('aerial').setup()
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
