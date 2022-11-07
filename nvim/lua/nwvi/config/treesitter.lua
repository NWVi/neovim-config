-- Insipred by Folke
-- https://github.com/folke/dot/blob/master/config/nvim/lua/config/treesitter.lua
local ts_configs = require('nvim-treesitter.configs')
ts_configs.setup({
  ensure_installed = {
    'bash',
    'c',
    'c_sharp',
    'cmake',
    'comment',
    'css',
    'go',
    'graphql',
    'html',
    'javascript',
    'jsonc',
    'json',
    'latex',
    'lua',
    'python',
    'regex',
    'rust',
    'svelte',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vue',
    'yaml',
    'rasi',
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  highlight = {
    enable = true,
    disabled = function(lang, bufnr) -- Disable in large buffers
      return vim.api.nvim_buf_line_count(bufnr) > 5000
    end,
    additiona_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  autotag = {
    enable = true,
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
    },
  },
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99

-- Add Markdown
local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
parser_config.jsonc.filetype_to_parsername = 'json'
parser_config.markdown = {
  install_info = {
    url = 'https://github.com/ikatyang/tree-sitter-markdown',
    files = { 'src/parser.c', 'src/scanner.cc' },
  },
}
