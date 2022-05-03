return function()
  local comment = safe_require('mini.comment')
  if not comment then
    return
  end

  comment.setup({
    mappings = {
      -- Toggle comment (like `gcip` - comment inner paragraph) for both
      -- Normal and Visual modes
      comment = 'gc',

      -- Toggle comment on current line
      comment_line = 'gcc',

      -- Define 'comment' textobject (like `dgc` - delete whole comment block)
      textobject = 'gc',
    },
    hooks = {
      pre = function()
        require('ts_context_commentstring.internal').update_commentstring()
      end,
    },
  })

  local cursorword = safe_require('mini.cursorword')
  if not cursorword then
    return
  end

  cursorword.setup({
    delay = 1000,
  })

  local surround = safe_require('mini.surround')
  if not surround then
    return
  end

  surround.setup({})

  local starter = safe_require('mini.starter')
  if not starter then
    return
  end

  starter.setup({
    evaluate_single = true,
    items = {
      starter.sections.builtin_actions(),
      starter.sections.recent_files(10, false),
      starter.sections.recent_files(10, true),
      -- Use this if you set up 'mini.sessions'
      -- starter.sections.sessions(5, true),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.indexing('all', { 'Builtin actions' }),
      starter.gen_hook.padding(3, 2),
    },
  })
end
