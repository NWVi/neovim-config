return function()
  local ls = require('luasnip')

  ls.config.set_config({
    history = false,
    -- Update more often, :h events for more info.
    updateevents = 'TextChanged,TextChangedI',
  })

  -- Snippet creator
  -- s(<trigger>, <nodes>)
  local s = ls.s

  -- Format node
  -- Takes a format string, and a lsit of nodes
  -- fmt(<fmt_string>, {...nodes})
  local fmt = require('luasnip.extras.fmt').fmt

  -- Insert node
  -- Takes a position (like $1) and optionally some default text
  -- i(<position>, [default text])
  local i = ls.insert_node

  -- Repeat a node
  -- rep(<position>)
  local rep = require('luasnip.extras').rep

  require('luasnip.loaders.from_lua').lazy_load()

  vim.cmd([[ command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files() ]])
end
