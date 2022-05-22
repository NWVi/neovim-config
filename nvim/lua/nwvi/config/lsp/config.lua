local status_ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not status_ok then
  return
end

local lspconfig = require('lspconfig')

local servers = { 'jsonls', 'omnisharp', 'gopls', 'angularls', 'tsserver', 'sumneko_lua' }

lsp_installer.setup({
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
  lspconfig[server].setup(opts)
end

local rust_ok, rust = pcall(require, 'rust-tools')
if not rust_ok then
  return
end
rust.setup()
