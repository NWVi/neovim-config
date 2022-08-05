return function()
  local telescope = safe_require('telescope')
  local actions = safe_require('telescope.actions')
  if not telescope and actions then
    return
  end

  -- telescope.setup({
  --   defaults = {
  --     vimgrep_arguments = {
  --       'rg',
  --       '--color=never',
  --       '--no-heading',
  --       '--with-filename',
  --       '--line-number',
  --       '--column',
  --       '--smart-case',
  --       '--trim', -- add this value
  --     },
  --     mappings = {
  --       i = {
  --         ['<esc>'] = actions.close,
  --       },
  --     },
  --   },
  --   pickers = {
  --     find_files = {
  --       find_command = {
  --         'rg',
  --         '--files',
  --         '--hidden',
  --         '--ignore',
  --         '--glob',
  --         '!.git',
  --       },
  --     },
  --   },
  -- })
  local wk = safe_require('which-key')
  if wk then
    local keymap = {
      s = {
        name = 'Search',
        f = { [[<cmd>lua require('telescope.builtin').find_files()<CR>]], 'Files' },
        h = { [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], 'Help tags' },
        t = { [[<cmd>lua require('telescope.builtin').tags()<CR>]], 'Tags' },
        o = {
          [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]],
          'Tags current buffer',
        },
        s = { [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], 'String under cursor' },
        l = { [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], 'String' },
        b = {
          [[<cmd>lua require('telescope.builtin').live_grep({ grep_open_files = true })<CR>]],
          'String in open buffers',
        },
        c = { [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], 'String in current buffer' },
        ['?'] = { [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], 'Previously opened files' },
        [' '] = { [[<cmd>lua require('telescope.builtin').buffers()<CR>]], 'Buffer' },
      },
    }
    wk.register(keymap, {
      mode = 'n',
      prefix = '<leader>',
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = false,
    })
  else
    local map = require('nwvi.util.helpers').keymap.map
    map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
    map('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
    map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
    map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
    map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]])
    map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]])
    map('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
    map('n', '<leader>sl', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
    map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').live_grep({ grep_open_files = true })<CR>]])
    map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
  end

  telescope.setup({
    defaults = {

      prompt_prefix = ' ',
      selection_caret = '❯ ',
      path_display = { 'truncate' },
      selection_strategy = 'reset',
      sorting_strategy = 'ascending',
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },

      mappings = {
        i = {
          ['<C-n>'] = actions.cycle_history_next,
          ['<C-p>'] = actions.cycle_history_prev,

          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,

          ['<C-c>'] = actions.close,

          ['<Down>'] = actions.move_selection_next,
          ['<Up>'] = actions.move_selection_previous,

          ['<CR>'] = actions.select_default,
          ['<C-x>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,
          ['<C-t>'] = actions.select_tab,

          ['<C-u>'] = actions.preview_scrolling_up,
          ['<C-d>'] = actions.preview_scrolling_down,

          ['<PageUp>'] = actions.results_scrolling_up,
          ['<PageDown>'] = actions.results_scrolling_down,

          ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
          ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
          ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
          ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
          ['<C-l>'] = actions.complete_tag,
        },

        n = {
          ['<esc>'] = actions.close,
          ['<CR>'] = actions.select_default,
          ['<C-x>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,
          ['<C-t>'] = actions.select_tab,

          ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
          ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
          ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
          ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

          ['j'] = actions.move_selection_next,
          ['k'] = actions.move_selection_previous,
          ['H'] = actions.move_to_top,
          ['M'] = actions.move_to_middle,
          ['L'] = actions.move_to_bottom,

          ['<Down>'] = actions.move_selection_next,
          ['<Up>'] = actions.move_selection_previous,
          ['gg'] = actions.move_to_top,
          ['G'] = actions.move_to_bottom,

          ['<C-u>'] = actions.preview_scrolling_up,
          ['<C-d>'] = actions.preview_scrolling_down,

          ['<PageUp>'] = actions.results_scrolling_up,
          ['<PageDown>'] = actions.results_scrolling_down,
        },
      },
    },
    pickers = {},
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  })
  require('telescope').load_extension('fzf')
end
