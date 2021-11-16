-- Inspired by
-- https://github.com/williamboman/nvim-config/blob/main/lua/wb/lsp/init.lua

return function()
  require('nwvi.config.lsp.diagnostics')

  local lsp_installer = require('nvim-lsp-installer')
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local ngserver = vim.fn.stdpath('data')..'/lsp_servers/angularls/node_modules/.bin/ngserver'
  local nglsPath = vim.fn.stdpath('data')..'/lsp_servers/angularls/node_modules'
  local tsserverPath = vim.fn.stdpath('data')..'/lsp_servers/tsserver/node_modules'
  local angular_cmd = {ngserver, "--stdio", "--ngProbeLocations", nglsPath, "--tsProbeLocations", tsserverPath }

  local function on_attach(client, bufnr)
    require('nwvi.config.lsp.formatting').setup(client, bufnr)
    require('nwvi.config.lsp.keys').setup(client, bufnr)

    if client.name == "typescript" or client.name == "tsserver" then
      require('nwvi.config.lsp.ts-utils').setup(client)
    end
  end

  local default_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  require('nwvi.config.lsp.null-ls').setup(default_opts)

  lsp_installer.on_server_ready(function(server)

    local server_opts = {
      ['sumneko_lua'] = function()
        return require("lua-dev").setup {
          lspconfig = default_opts,
        }
      end,

      ['angularls'] = function()
        return vim.tbl_deep_extend("force", default_opts, {
          cmd = angular_cmd,
          on_new_config = function(new_config)
            new_config.cmd = angular_cmd
          end
        })
      end,

      ['gopls'] = function()
        return vim.tbl_deep_extend("force", default_opts, {
          cmd = {'gopls'},
          settings = {
            gopls = {
              experimentalPostfixCompletions = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
            },
          }
        })
      end
    }

    server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
    vim.cmd('do User LspAttachBuffers')
  end)
end
