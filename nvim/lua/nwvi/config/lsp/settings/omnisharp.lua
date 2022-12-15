local omni_ok, omnisharp_extended = pcall(require, 'omnisharp_extended')
if not omni_ok then
  print('Failed to load omnisharp_extended')
  return
end

return {
  enable_editorconfig_support = true,
  enable_roslyn_analyzers = true,
  enable_import_completion = false,

  handlers = {
    ['textDocument/definition'] = omnisharp_extended.handler,
  },
}
