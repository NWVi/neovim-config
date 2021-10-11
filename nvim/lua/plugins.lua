-- Bootstrap Packer --
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Packer packages --
return require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'lukas-reineke/indent-blankline.nvim' -- Indentation guides
  use 'christoomey/vim-tmux-navigator' -- Easy navigating between tmux and vim buffers
  use 'norcalli/nvim-colorizer.lua' -- Color highlighter
  use 'projekt0n/github-nvim-theme' -- another theme
  use { -- Bufferline
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
  } 
  -- Statusline
  use { 
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use { -- Git symbols in symbolline
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config.gitsigns')
    end
  }

  use { -- File explorer
  --  'kyazdani42/nvim-tree.lua',
  --  requires = 'kyazdani42/nvim-web-devicons',
  --  config = function()
  --    require('config.tree')
  --  end
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  use {
    "b3nj5m1n/kommentary",
    keys = { "gc", "gcc" },
    config = function()
      require('config.comments')
    end,
    requires = "JoosepAlviste/nvim-ts-context-commentstring",
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require('config.keys')
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

