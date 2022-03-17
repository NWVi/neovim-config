local nls = require('null-ls')

local sources = {
  nls.builtins.formatting.prettierd,
  nls.builtins.formatting.gofmt,
  nls.builtins.formatting.rustfmt,
  nls.builtins.formatting.black,
  nls.builtins.formatting.trim_whitespace,
  nls.builtins.hover.dictionary,
}

local M = {}

M.setup = function(options)
  nls.setup({
    -- debug = true,
    sources = sources
  })
end

function M.has_formatter(ft)
  -- local sources = require("null-ls.info").get_active_sources()
  local method = require("null-ls").methods.FORMATTING
  if sources then
    return true
  end
end

return M
