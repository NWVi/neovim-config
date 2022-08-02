return function()
  local dap, dapui = require('dap'), require('dapui')

  local dap_icons = {
    breakpoint = {
      text = '',
      texthl = 'DiagnosticError',
      linehl = '',
      numhl = '',
    },
    rejected = {
      text = '',
      texthl = 'DiagnosticHint',
      linehl = '',
      numhl = '',
    },
    stopped = {
      text = '栗',
      texthl = 'DiagnosticInfo',
      linehl = 'PMenu',
      numhl = 'DiagnosticsInfo',
    },
  }

  -- config extensions
  dapui.setup({})

  require('nvim-dap-virtual-text').setup({
    comment = true,
  })

  require('telescope').load_extension('dap')

  -- Automatically open UI
  dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
  end

  -- Enable virtual text
  vim.g.dap_virtual_text = true

  -- Icons
  vim.fn.sign_define('DapBreakpoint', dap_icons.breakpoint)
  vim.fn.sign_define('DapStopped', dap_icons.stopped)
  vim.fn.sign_define('DapBreakpointRejected', dap_icons.rejected)

  -- config debuggers
  local mason_registry = require('mason-registry')
  local debugpy = mason_registry.get_package('debugpy') -- note that this will error if you provide a non-existent package name
  local netcoredbg = mason_registry.get_package('netcoredbg') -- note that this will error if you provide a non-existent package name

  require('dap-go').setup()
  require('dap-python').setup(debugpy:get_install_path() .. '/venv/bin/python')

  -- dotnet wip
  dap.adapters.coreclr = {
    type = 'executable',
    command = netcoredbg:get_install_path() .. '/netcoredbg',
    args = { '--interpreter=vscode' },
  }
  dap.configurations.cs = {
    {
      type = 'coreclr',
      name = 'launch - netcoredbg',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
      end,
    },
  }

  require('nwvi.config.dap.keys')
end
