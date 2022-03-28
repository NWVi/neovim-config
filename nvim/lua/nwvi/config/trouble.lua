return function()
  local trouble = safe_require('trouble')
  if not trouble then
    return
  end
  local map = require('nwvi.util.helpers').keymap.map

  trouble.setup({
    auto_open = false,
  })

  -- keybinds --
  map('n', '<leader>xx', '<cmd>TroubleToggle<CR>')
  -- workspace diagnostics from builtin LSP client
  map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>')
  -- Document diagnostics from builtin LSP client
  map('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostic<CR>')
  -- Quickfix items
  map('n', '<leader>xq', '<cmd>TroubleToggle quickfix<CR>')
  -- Items from the window's location list
  map('n', '<leader>xl', '<cmd>TroubleToggle loclist<CR>')
  -- References of the word under the cursor from the builtin LSP client
  map('n', 'gr', '<cmd>TroubleToggle lsp_references<CR>')
  -- Definitions of the word under the cursor from the builtin LSP client
  -- map('n', 'gd', '<cmd>TroubleToggle lsp_definitions<CR>') -- not working
end
