--- Options  ---
vim.opt.mouse = 'a' -- enable mouse mode

vim.opt.tabstop = 2 -- default spaces for tab
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.shiftwidth = 2 -- size of an indent
vim.opt.shiftround = true -- round indent to multiple of shiftwidth
vim.opt.breakindent = true -- Enable break indent
vim.opt.smartindent = true -- Smart autoindenting on new line

vim.opt.number = true -- show numbers
vim.opt.ignorecase = true -- Case insensitive
vim.opt.smartcase = true -- Case insensitive unless /C or capital in search
vim.opt.updatetime = 250 -- milliseconds from typing to saving swap file
vim.opt.termguicolors = true -- True color support
vim.opt.hidden = true -- Do not save when switching buffers

-- Display options for hidden charactrs --
vim.opt.list = true -- show some invisible characters
vim.opt.listchars = {
  space = '⋅',
  tab = '__',
  trail = '•',
  extends = '❯',
  precedes = '❮',
  nbsp = '_',
}

vim.opt.laststatus = 3
vim.opt.fillchars:append({
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┨',
  vertright = '┣',
  verthoriz = '╋',
})

vim.opt.guifont = 'FiraCode NF:h12'

vim.cmd([[autocmd FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4]])
vim.cmd([[autocmd FileType cs setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4]])

vim.cmd([[autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s]])
