return function()
  local lsp_installer = require('nvim-lsp-installer')
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local coq = require('coq')

  local nglsPath = vim.fn.stdpath('data')..'/lsp_servers/angularls/node_modules'
  local tsserverPath = vim.fn.stdpath('data')..'/lsp_servers/tsserver/node_modules'
  local angular_cmd = {"ngserver", "--stdio", "--ngProbeLocations", nglsPath, "--tsProbeLocations", tsserverPath }

  lsp_installer.on_server_ready(function(server)
    local opts = {}

    if server.name == "angularls" then
      opts.cmd = angular_cmd
      opts.on_new_config = function(new_config, new_root_dir)
        new_config.cmd = angular_cmd
      end
    end

    server:setup(coq.lsp_ensure_capabilities(opts))
  end)
end
