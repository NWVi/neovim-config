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

    if server.name == 'rust_analyzer' then
      -- Initialize the LSP via rust-tools instead
      require('rust-tools').setup({
        -- The "server" property provided in rust-tools setup function are the
        -- settings rust-tools will provide to lspconfig during init.            --
        -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
        -- with the user's own settings (opts).
        server = vim.tbl_deep_extend('force', server:get_default_options(), default_opts),
      })
      server:attach_buffers()
      -- Only if standalone support is needed
      require('rust-tools').start_standalone_if_required()
    else
      server:setup(server_opts[server.name] and server_opts[server.name]() or default_opts)
    end

    vim.cmd('do User LspAttachBuffers')
  end)
end
