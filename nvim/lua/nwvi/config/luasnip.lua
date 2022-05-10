return function()
  local ls = require('luasnip')

  ls.config.set_config({
    history = true,
    -- Update more often, :h events for more info.
    updateevents = 'TextChanged,TextChangedI',
    delete_check_events = 'TextChanged',
  })

  require('luasnip/loaders/from_vscode').lazy_load()

  require('luasnip.loaders.from_lua').lazy_load()

  vim.cmd([[ command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files() ]])
end
