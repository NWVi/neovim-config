-- Inspired by
-- https://github.com/williamboman/nvim-config/blob/main/lua/wb/lsp/init.lua

return function()
  require('nwvi.config.lsp.diagnostics')

  local lsp_installer = require('nvim-lsp-installer')

  local function on_attach(client, bufnr)
    require('nwvi.config.lsp.keys').setup(client, bufnr)

    if client.name == 'typescript' or client.name == 'tsserver' then
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      require('nwvi.config.lsp.ts-utils').setup(client)
    end
  end

  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  local default_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  require('nwvi.config.lsp.null-ls').setup(default_opts)

  lsp_installer.on_server_ready(function(server)
    local server_opts = {
      ['sumneko_lua'] = function()
        return require('lua-dev').setup({
          lspconfig = default_opts,
        })
      end,

      ['gopls'] = function()
        return vim.tbl_deep_extend('force', default_opts, {
          cmd = { 'gopls' },
          settings = {
            gopls = {
              experimentalPostfixCompletions = true,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              staticcheck = true,
            },
          },
        })
      end,
    }

    server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
    vim.cmd('do User LspAttachBuffers')
  end)
end
