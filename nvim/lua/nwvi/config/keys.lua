return function()
  local wk = safe_require('which-key')
  if not wk then
    return
  end

  vim.o.timeoutlen = 500

  local leader_opts = {
    mode = 'n',
    prefix = '<leader>',
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local leader_mappings = {
    g = {
      name = 'Git',
      s = { '<Cmd>Neogit<CR>', 'Status' },
      f = { '<Cmd>!git fetch --all<CR>', 'Fetch' },
    },
    x = {
      name = 'Trouble',
      x = { '<Cmd>TroubleToggle<CR>', 'Toggle Trouble' },
      w = { '<Cmd>TroubleToggle workspace_diagnostics<CR>', 'Workspace diagnostics' },
      d = { '<Cmd>TroubleToggle document_diagnostics<CR>', 'Document diagnostics' },
      q = { '<Cmd>TroubleToggle quickfix<CR>', 'Quickfix' },
      l = { '<Cmd>TroubleToggle loclist<CR>', 'Loclist' },
      t = { '<Cmd>TodoTrouble<CR>', 'Todos' },
    },
    t = {
      t = { '<Cmd>ToggleTerm<CR>', 'Terminal' },
      a = { '<Cmd>ToggleTermToggleAll<CR>', 'All terminals' },
      s = { '<Cmd>2ToggleTerm<CR>', 'Terminal split' },
    },
    z = {
      name = 'Zen',
      f = { '<Cmd>TZFocus<CR>', 'Focus'},
      m = { '<Cmd>TZMinimalist<CR>', 'Minimalist'},
      a = { '<Cmd>TZAtaraxis<CR>', 'Ataraxis'},
    },
    ['.'] = { '<CMD>lcd %:p:h<CR><CMD>pwd<CR>', 'CD current dir' },
  }

  wk.setup({
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      presets = {
        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    operators = { gc = 'Comments' },
    key_labels = {
      -- override the label used to display some keys. It doesn't effect WK in any other way.
      ['<space>'] = 'SPC',
      ['<leader>'] = 'SPC',
    },
    icons = {
      breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
      separator = '➜', -- symbol used between a key and it's label
      group = '+', -- symbol prepended to a group
    },
    popup_mappings = {
      scroll_down = '<c-d>', -- binding to scroll down inside the popup
      scroll_up = '<c-u>', -- binding to scroll up inside the popup
    },
    window = {
      border = 'rounded', -- none, single, double, shadow
      position = 'bottom', -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
      align = 'left', -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = 'auto', -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
  })

  wk.register(leader_mappings, leader_opts)
end
