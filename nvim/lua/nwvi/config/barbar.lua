return function()
  local map = require('nwvi.util.helpers').keymap.map

  -- Move to previous/next
  map('n', '<A-,>', ':BufferPrevious<CR>')
  map('n', '<A-.>', ':BufferNext<CR>')
  -- Re-order to previous/next
  map('n', '<A-<>', ':BufferMovePrevious<CR>')
  map('n', '<A->>', ' :BufferMoveNext<CR>')
  -- Goto buffer in position...
  map('n', '<A-1>', ':BufferGoto 1<CR>')
  map('n', '<A-2>', ':BufferGoto 2<CR>')
  map('n', '<A-3>', ':BufferGoto 3<CR>')
  map('n', '<A-4>', ':BufferGoto 4<CR>')
  map('n', '<A-5>', ':BufferGoto 5<CR>')
  map('n', '<A-6>', ':BufferGoto 6<CR>')
  map('n', '<A-7>', ':BufferGoto 7<CR>')
  map('n', '<A-8>', ':BufferGoto 8<CR>')
  map('n', '<A-9>', ':BufferGoto 9<CR>')
  map('n', '<A-0>', ':BufferLast<CR>')
  -- Close buffer
  map('n', '<A-c>', ':BufferClose<CR>')
    -- Close buffer
  map('n', '<A-c>', ':BufferClose<CR>')
  -- Wipeout buffer
  --                 :BufferWipeout<CR>
  -- Close commands
  --                 :BufferCloseAllButCurrent<CR>
  --                 :BufferCloseBuffersLeft<CR>
  --                 :BufferCloseBuffersRight<CR>
  -- Magic buffer-picking mode
  map('n', '<C-p>', ':BufferPick<CR>')
  -- Sort automatically by...
  map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>')
  map('n', '<Space>bd', ':BufferOrderByDirectory<CR>')
  map('n', '<Space>bl', ':BufferOrderByLanguage<CR>')
end
