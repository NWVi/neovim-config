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

  local sessions = safe_require('mini.sessions')
  if not sessions then
    return
  end

  local session_dir = vim.fn.stdpath('data') .. '/session'
  if vim.fn.isdirectory(session_dir) == 0 then
    vim.fn.mkdir(session_dir, 'p')
    print(session_dir)
  end

  sessions.setup({
    -- Whether to read latest session if Neovim opened without file arguments
    autoread = false,

    -- Whether to write current session before quitting Neovim
    autowrite = true,

    -- Directory where global sessions are stored (use `''` to disable)
    --directory = --<"session" subdir of user data directory from |stdpath()|>,

    -- File for local session (use `''` to disable)
    file = 'Session.vim',

    -- Whether to force possibly harmful actions (meaning depends on function)
    force = { read = false, write = true, delete = false },

    -- Hook functions for actions. Default `nil` means 'do nothing'.
    hooks = {
      -- Before successful action
      pre = { read = nil, write = nil, delete = nil },
      -- After successful action
      post = { read = nil, write = nil, delete = nil },
    },

    -- Whether to print session path after action
    verbose = { read = false, write = true, delete = true },
  })

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
      starter.sections.sessions(5, true),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.indexing('all', { 'Builtin actions' }),
      starter.gen_hook.padding(3, 2),
    },
  })
end
