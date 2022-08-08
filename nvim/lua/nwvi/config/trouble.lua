return function()
  local trouble = safe_require('trouble')
  if not trouble then
    return
  end

  trouble.setup({
    auto_open = false,
  })

  -- References of the word under the cursor from the builtin LSP client
  vim.keymap.set('n', 'gr', '<cmd>TroubleToggle lsp_references<CR>', {desc = 'Trouble references'})
  -- Definitions of the word under the cursor from the builtin LSP client
  -- map('n', 'gd', '<cmd>TroubleToggle lsp_definitions<CR>') -- not working
end
