return function()
  local nt = safe_require('neotest')
  local wk = safe_require('which-key')
  if not nt and not wk then
    return
  end

  nt.setup({
    adapters = {
      require('neotest-python')({
        dap = { justMyCode = false },
      }),
      require('neotest-rust'),
      require('neotest-go'),
      require('neotest-dotnet'),
      require('neotest-vim-test')({
        ignore_file_types = { 'python', 'go', 'rust', 'cs' },
      }),
    },
    icons = {
      passed = '',
      running = '',
      failed = '',
      unknown = '',
    },
  })

  wk.register({
    t = {
      n = {
        function()
          nt.run.run()
        end,
        'Run nearest test',
      },
      f = {
        function()
          nt.run.run(vim.fn.expand('%'))
        end,
        'Run tests in file',
      },
      b = {
        function()
          nt.run.run({ strategy = 'dap' })
        end,
        'Debug nearest test',
      },
      ['='] = {
        function()
          nt.summary.toggle()
        end,
        'Test summary toggle',
      },
      o = {
        function()
          nt.output.open()
        end,
        'Show test output',
      },
    },
  }, { prefix = '<leader>' })
end
