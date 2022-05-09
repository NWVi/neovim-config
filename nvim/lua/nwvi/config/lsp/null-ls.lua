local nls_status_ok, nls = pcall(require, 'null-ls')
if not nls_status_ok then
  return
end

local formatting = nls.builtins.formatting

-- local diagnostics = nls.builtins.diagnostics

local sources = {
  formatting.black,
  formatting.prettierd,
  formatting.stylua,
  formatting.trim_whitespace.with({
    disabled_filetypes = { 'rust', 'cs' },
  }),
}

nls.setup({
  debug = false,
  sources = sources,
})
