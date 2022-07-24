local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

local lspconfig = require('lspconfig')

local servers = { 'jsonls', 'omnisharp', 'gopls', 'angularls', 'tsserver', 'sumneko_lua', 'rust_analyzer', 'pyright' }

mason.setup({ })

require('mason-lspconfig').setup({
  ensure_installed = servers,
})

local win = require('lspconfig.ui.windows')
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = 'rounded'
  return opts
end

for _, server in pairs(servers) do
  local opts = {
    on_attach = require('nwvi.config.lsp.handlers').on_attach,
    capabilities = require('nwvi.config.lsp.handlers').capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, 'nwvi.config.lsp.settings.' .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend('force', server_custom_opts, opts)
  end

  if server == 'rust_analyzer' then
    local rt_ok, rust_tools = pcall(require, 'rust-tools')
    if not rt_ok then
      print('Failed to load rust-tools')
    else
      local rust_opts = {
        server = opts,
      }

      rust_tools.setup(rust_opts)
    end
  else
    lspconfig[server].setup(opts)
  end
end
