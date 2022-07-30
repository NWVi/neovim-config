local wk = safe_require('which-key')
if not wk then
  return
end

local keymap = {
  d = {
    name = 'Debug',
    R = { "<Cmd>lua require('dap').run_to_cursor()<CR>", 'Run to Cursor' },
    E = { "<Cmd>lua require('dapui').eval(vim.fn.input '[Expression] > ')<CR>", 'Evaluate Input' },
    C = { "<Cmd>lua require('dap').set_breakpoint(vim.fn.input '[Condition] > ')<CR>", 'Conditional Breakpoint' },
    U = { "<Cmd>lua require('dapui').toggle()<CR>", 'Toggle UI' },
    b = { "<Cmd>lua require('dap').step_back()<CR>", 'Step Back' },
    c = { "<Cmd>lua require('dap').continue()<CR>", 'Continue' },
    D = { "<Cmd>lua require('dap').disconnect()<CR>", 'Disconnect' },
    e = { "<Cmd>lua require('dapui').eval()<CR>", 'Evaluate' },
    g = { "<Cmd>lua require('dap').session()<CR>", 'Get Session' },
    h = { "<Cmd>lua require('dap.ui.widgets').hover()<CR>", 'Hover Variables' },
    S = { "<Cmd>lua require('dap.ui.widgets').scopes()<CR>", 'Scopes' },
    i = { "<Cmd>lua require('dap').step_into()<CR>", 'Step Into' },
    o = { "<Cmd>lua require('dap').step_over()<CR>", 'Step Over' },
    p = { "<Cmd>lua require('dap').pause.toggle()<CR>", 'Pause' },
    q = { "<Cmd>lua require('dap').close()<CR>", 'Quit' },
    r = { "<Cmd>lua require('dap').repl.toggle()<CR>", 'Toggle Repl' },
    s = { "<Cmd>lua require('dap').continue()<CR>", 'Start' },
    t = { "<Cmd>lua require('dap').toggle_breakpoint()<CR>", 'Toggle Breakpoint' },
    x = { "<Cmd>lua require('dap').terminate()<CR>", 'Terminate' },
    u = { "<Cmd>lua require('dap').step_out()<CR>", 'Step Out' },
  },
}

wk.register(keymap, {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})

local keymap_v = {
  name = 'Debug',
  e = { "<Cmd>lua require('dapui').eval()<CR>", 'Evaluate' },
}

wk.register(keymap_v, {
  mode = 'v',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
})
