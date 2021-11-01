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
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
    },
  },
})

-- Add Markdown
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.jsonc.used_by = 'json'
parser_config.markdown = {
  install_info = {
    url = "https://github.com/ikatyang/tree-sitter-markdown",
    files = { "src/parser.c", "src/scanner.cc" },
  }
}
