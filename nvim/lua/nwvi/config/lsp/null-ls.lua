local nls = require('null-ls')
local formatting = nls.builtins.formatting

local sources = {
  formatting.black,
  formatting.gofmt,
  formatting.prettierd,
  formatting.rustfmt,
  formatting.stylua,
  formatting.trim_whitespace,
}

local M = {}

M.setup = function(options)
  nls.setup({
    -- debug = true,
    sources = sources,

    on_attach = function(client) -- Format on save
      if client.resolved_capabilities.document_formatting then
        vim.cmd([[
          augroup LspFormatting
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
          augroup END
          ]])
      end
    end,
  })
end

function M.has_formatter(ft)
  -- local method = require('null-ls').methods.FORMATTING
  if sources then
    return true
  end
end

return M
