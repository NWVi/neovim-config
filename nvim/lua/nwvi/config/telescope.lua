return function()
  local telescope = safe_require('telescope')
  if not telescope then
    return
  end

  local actions = require 'telescope.actions'
  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--column',
        '--line-number',
        '--no-heading',
        '--color=never',
        '--smart-case',
        '--with-filename',
      },
      mappings = {
        i = {
          ['<esc>'] = actions.close,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = {
          'rg', '--files', '--hidden', '--glob', '!.git/*'
        }
      }
    }
  })


  local map = require('nwvi.util.helpers').keymap.map
  map('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
  map('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
  map('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]])
  map('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
  map('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]])
  map('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
  map('n', '<leader>sl', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
  map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]])
  map('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
end
