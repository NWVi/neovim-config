return function()
  local lsp_installer = require('nvim-lsp-installer')
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local coq = require('coq')
  local lua_buf_map = require('nwvi.util.helpers').keymap.lua_buf_map

  local nglsPath = vim.fn.stdpath('data')..'/lsp_servers/angularls/node_modules'
  local tsserverPath = vim.fn.stdpath('data')..'/lsp_servers/tsserver/node_modules'
  local angular_cmd = {"ngserver", "--stdio", "--ngProbeLocations", nglsPath, "--tsProbeLocations", tsserverPath }

  local on_attach = function(client, bufnr)
    lua_buf_map('n', 'gD', 'vim.lsp.buf.declaration()')
    lua_buf_map('n', 'gd', 'vim.lsp.buf.definition()')
    lua_buf_map('n', 'K', 'vim.lsp.buf.hover()')
    lua_buf_map('n', 'gi', 'vim.lsp.buf.implementation()')
    lua_buf_map('n', '<C-k>', 'vim.lsp.buf.signature_help()')
    lua_buf_map('n', '<space>lwa', 'vim.lsp.buf.add_workspace_folder()')
    lua_buf_map('n', '<space>lwr', 'vim.lsp.buf.remove_workspace_folder()')
    lua_buf_map('n', '<space>lwl', 'print(vim.inspect(vim.lsp.buf.list_workspace_folders()))')
    lua_buf_map('n', '<leader>lD', 'vim.lsp.buf.type_definition()')
    lua_buf_map('n', '<leader>lr', 'vim.lsp.buf.rename()')
    lua_buf_map('n', '<leader>lca', 'vim.lsp.buf.code_action()')
    lua_buf_map('n', 'gr', 'vim.lsp.buf.references()')
    lua_buf_map('n', '<leader>le', 'vim.lsp.diagnostic.show_line_diagnostics()')
    lua_buf_map('n', '[d', 'vim.lsp.diagnostic.goto_prev()')
    lua_buf_map('n', ']d', 'vim.lsp.diagnostic.goto_next()')
    lua_buf_map('n', '<space>lq', 'vim.lsp.diagnostic.set_loclist()')
    lua_buf_map('n', '<leader>f', 'vim.lsp.buf.formatting()')
  end

  lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = on_attach
    }

    if server.name == "angularls" then
      opts.cmd = angular_cmd
      opts.on_new_config = function(new_config, new_root_dir)
        new_config.cmd = angular_cmd
      end
    end

    server:setup(coq.lsp_ensure_capabilities(opts))
  end)
end
