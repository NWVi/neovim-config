local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

local lspconfig = require('lspconfig')

local servers = { 'jsonls', 'omnisharp', 'gopls', 'angularls', 'tsserver', 'sumneko_lua', 'rust_analyzer', 'pyright' }

mason.setup({
  ui = {
    icons = {
      -- The list icon to use for installed packages.
      package_installed = '',
      -- The list icon to use for packages that are installing, or queued for installation.
      package_pending = '',
      -- The list icon to use for packages that are not installed.
      package_uninstalled = '',
    },
  },
})

require('mason-lspconfig').setup({
  ensure_installed = servers,
})

-- mason colors
local function sethi()
  local mbg = ('#%06x'):format(vim.api.nvim_get_hl_by_name('NormalFloat', true).background)
  local yellow = vim.g.terminal_color_3
  local blue = vim.g.terminal_color_4
  local muted = ('#%06x'):format(vim.api.nvim_get_hl_by_name('Comment', true).foreground)

  vim.api.nvim_set_hl(0, 'MasonHighlight', {
    fg = blue,
  })
  vim.api.nvim_set_hl(0, 'MasonHighlightBlock', {
    bg = blue,
    fg = mbg,
  })
  vim.api.nvim_set_hl(0, 'MasonHighlightBlockBold', {
    bold = true,
    bg = blue,
    fg = mbg,
  })
  vim.api.nvim_set_hl(0, 'MasonHighlightSecondary', {
    fg = yellow,
  })
  vim.api.nvim_set_hl(0, 'MasonHighlightBlockSecondary', {
    bg = yellow,
    fg = mbg,
  })
  vim.api.nvim_set_hl(0, 'MasonHighlightBlockBoldSecondary', {
    bold = true,
    bg = yellow,
    fg = mbg,
  })
  vim.api.nvim_set_hl(0, 'MasonLink', {
    link = 'MasonHighlight',
  })
  vim.api.nvim_set_hl(0, 'MasonMuted', {
    fg = muted,
  })
  vim.api.nvim_set_hl(0, 'MasonMutedBlock', {
    bg = muted,
    fg = mbg,
  })
  vim.api.nvim_set_hl(0, 'MasonMutedBlockBold', {
    bold = true,
    bg = muted,
    fg = mbg,
  })
  vim.api.nvim_set_hl(0, 'MasonHeading', {
    bold = true,
  })
  vim.api.nvim_set_hl(0, 'MasonHeader', {
    bold = true,
    bg = yellow,
    fg = mbg,
  })
  vim.api.nvim_set_hl(0, 'MasonHeaderSecondary', {
    bold = true,
    bg = blue,
    fg = mbg,
  })
  vim.api.nvim_set_hl(0, 'MasonError', {
    link = 'Error',
  })
end

vim.api.nvim_create_augroup('_mason', { clear = true })
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'mason.nvim',
  callback = function()
    sethi()
  end,
  group = '_mason',
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
    opts = vim.tbl_deep_extend('force', opts, server_custom_opts)
  end

  if server == 'rust_analyzer' then
    local rt_ok, rust_tools = pcall(require, 'rust-tools')
    if not rt_ok then
      print('Failed to load rust-tools')
    else
      local rust_opts = {
        server = vim.tbl_deep_extend('force', opts, { standalone = true }),
      }

      rust_tools.setup(rust_opts)
    end
  else
    lspconfig[server].setup(opts)
  end
end
