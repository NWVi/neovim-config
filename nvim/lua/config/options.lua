local opt = vim.opt

opt.completeopt = "menu,menuone,noselect,noinsert" 
opt.cursorline = true -- Highlight current line
opt.expandtab = true -- Use spaces instead of tabs
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit" -- preview incremental substitute
opt.list = true -- show invisible characters
opt.listchars = { space = '⋅', trail = '•', }
opt.mouse = "a" -- Enable mouse support
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup transparency level
opt.pumheight = 10 -- Max number of entries in popup
opt.relativenumber = true -- Show relative line numbers
opt.scrolloff = 4 -- lines of context vertical
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent to multiple of shiftwidth
opt.shiftwidth = 2 -- Round indent to multiple of shiftwidth
opt.showmode = false
opt.sidescrolloff = 8 -- Lines of context horizontal
opt.signcolumn = "yes" -- Always show signcolumn, avoids shifting text
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300 -- Time to wait in ms for a mapped sequence
opt.undofile = true
opt.undolevels = 10000
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false
opt.laststatus = 3

opt.formatoptions = "jcroqlnt" -- default: tcqj
-- j - remove comment leader where it makes sense when joining lines
-- c - auto-wrap comments using 'textwidth' inserting comment leader automatically
-- r - automatically insert the comment leader after <Enter> in insert mode
-- q - allow formatitng comments with 'gq'
-- l - long ines are not broken in insert mode.
-- n - when formatting text recognize numbered lists.
-- t - auto wrap text using 'textwidth'
