local M = {}

function M.setup(options)
  local nls = require('null-ls')
  nls.config({
    debug = true,
    sources = {
      nls.builtins.formatting.prettierd,
      nls.builtins.formatting.gofmt,
      nls.builtins.formatting.rustfmt,
      nls.builtins.formatting.black,
      nls.builtins.formatting.trim_whitespace,
      nls.builtins.hover.dictionary,
    }
  })
  require('lspconfig')['null-ls'].setup(options)
end

function M.has_formatter(ft)
  print(ft)
  local sources = require("null-ls.info").get_active_sources()
  local method = require("null-ls").methods.FORMATTING
  if sources then
    print(vim.inspect(formatters))
    return true
  end
end

return M
