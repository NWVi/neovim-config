return function()
  -- Move to previous/next
  vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
  vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>')
  -- Re-order to previous/next
  vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>')
  vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>')
  -- Goto buffer in position...
  vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
  vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
  vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
  vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
  vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
  vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
  vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
  vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
  vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
  vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>')
  -- Close buffer
  vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>')
  -- Close buffer
  vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>')
  -- Wipeout buffer
  --                 <Cmd>BufferWipeout<CR>
  -- Close commands
  --                 <Cmd>BufferCloseAllButCurrent<CR>
  --                 <Cmd>BufferCloseBuffersLeft<CR>
  --                 <Cmd>BufferCloseBuffersRight<CR>
  -- Magic buffer-picking mode
  vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>')
  -- Sort automatically by...
  vim.keymap.set('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>')
  vim.keymap.set('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>')
  vim.keymap.set('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>')
end
