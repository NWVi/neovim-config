return function()
  local nvim_lsp = require('lspconfig')
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  vim.cmd('COQnow')
  -- local coq = require('coq')

  local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'angularls' }

  -- Enable the following language servers
  -- for _, server in ipairs(servers) do
  --   nvim_lsp[server].setup({coq.lsp_ensure_capabilities({
  --   })})
  -- end
    for _, lsp in ipairs(servers) do
      nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities({
      }))
    end
end
