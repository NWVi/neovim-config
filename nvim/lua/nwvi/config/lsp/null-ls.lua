local nls = require('null-ls')
local formatting = nls.builtins.formatting

local sources = {
  formatting.black,
  formatting.prettierd,
  formatting.rustfmt,
  formatting.stylua,
  formatting.trim_whitespace,
}

local M = {}

M.setup = function(options)
  nls.setup({
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

return M
