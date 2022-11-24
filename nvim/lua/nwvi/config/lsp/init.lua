-- Inspired by
-- https://github.com/LunarVim/Neovim-from-scratch/tree/master/lua/user/lsp

return function()
  require('nwvi.config.lsp.config')
  require('nwvi.config.lsp.diagnostics')
  require('nwvi.config.lsp.signature')
  require('nwvi.config.lsp.handlers').setup()
  require('nwvi.config.lsp.null-ls')
  require('fidget').setup()
end
