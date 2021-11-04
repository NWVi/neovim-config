return function()
  local lsp_installer = require('nvim-lsp-installer')
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local coq = require('coq')

  local servers = { 'pyright', 'rust_analyzer', 'tsserver', 'angularls' }

  lsp_installer.on_server_ready(function(server)
    local opts = {}

    server:setup(coq.lsp_ensure_capabilities(opts))
  end)
end
