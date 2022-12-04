vim.cmd([[autocmd FileType cs setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4]])

vim.keymap.set(
  'n',
  '<F5>',
  ':!dotnet build && cp -r source/EsetServerApi/bin/Debug/net6.0/win-x64 ~/mnt/Desktop/eset-api/<CR>'
)
