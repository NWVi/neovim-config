-- Inspired by
-- https://github.com/williamboman/nvim-config/blob/main/lua/wb/lsp/init.lua

return function()
  require('nwvi.config.lsp.diagnostics')

  local lsp_installer = require('nvim-lsp-installer')
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  -- local coq = require('coq')
  local lua_buf_map = require('nwvi.util.helpers').keymap.lua_buf_map

  local ngserver = vim.fn.stdpath('data')..'/lsp_servers/angularls/node_modules/.bin/ngserver'
  local nglsPath = vim.fn.stdpath('data')..'/lsp_servers/angularls/node_modules'
  local tsserverPath = vim.fn.stdpath('data')..'/lsp_servers/tsserver/node_modules'
  local angular_cmd = {ngserver, "--stdio", "--ngProbeLocations", nglsPath, "--tsProbeLocations", tsserverPath }

  local on_attach = function(client, bufnr)
    lua_buf_map('n', 'gD', 'vim.lsp.buf.declaration()')
    -- lua_buf_map('n', 'gd', 'vim.lsp.buf.definition()')
    lua_buf_map('n', 'K', 'vim.lsp.buf.hover()')
    lua_buf_map('n', 'gi', 'vim.lsp.buf.implementation()')
    lua_buf_map('n', '<C-k>', 'vim.lsp.buf.signature_help()')
    lua_buf_map('n', '<space>lwa', 'vim.lsp.buf.add_workspace_folder()')
    lua_buf_map('n', '<space>lwr', 'vim.lsp.buf.remove_workspace_folder()')
    lua_buf_map('n', '<space>lwl', 'print(vim.inspect(vim.lsp.buf.list_workspace_folders()))')
    lua_buf_map('n', '<leader>lD', 'vim.lsp.buf.type_definition()')
    lua_buf_map('n', '<leader>lr', 'vim.lsp.buf.rename()')
    lua_buf_map('n', '<leader>lca', 'vim.lsp.buf.code_action()')
    -- lua_buf_map('n', 'gr', 'vim.lsp.buf.references()')
    lua_buf_map('n', '<leader>le', 'vim.lsp.diagnostic.show_line_diagnostics()')
    lua_buf_map('n', '[d', 'vim.lsp.diagnostic.goto_prev()')
    lua_buf_map('n', ']d', 'vim.lsp.diagnostic.goto_next()')
    lua_buf_map('n', '<space>lq', 'vim.lsp.diagnostic.set_loclist()')
    lua_buf_map('n', '<leader>f', 'vim.lsp.buf.formatting()')

    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end

  lsp_installer.on_server_ready(function(server)
    local default_opts = {
      on_attach = on_attach
    }

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

    server:setup(
      -- coq.lsp_ensure_capabilities(server_opts[server.name] and server_opts[server.name]() or default_opts)
        server_opts[server.name] and server_opts[server.name]() or default_opts
    )
    -- vim.cmd('do User LspAttachBuffers')
  end)
end
