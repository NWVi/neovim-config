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

  vim.g.dotnet_build_project = function()
    local default_path = vim.fn.getcwd() .. '/'
    if vim.g['dotnet_last_proj_path'] ~= nil then
      default_path = vim.g['dotnet_last_proj_path']
    end
    local path = vim.fn.input('Path to your *proj file', default_path, 'file')
    vim.g['dotnet_last_proj_path'] = path
    local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
    print('')
    print('Cmd to execute: ' .. cmd)
    local f = os.execute(cmd)
    if f == 0 then
      print('\nBuild: ' .. vim.g.gsign('✔️ ', 'OK'))
    else
      print('\nBuild: ' .. vim.g.gsign('❌', 'ERR') .. '(code: ' .. f .. ')')
    end
  end

  vim.g.dotnet_get_dll_path = function()
    local request = function()
      return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end

    if vim.g['dotnet_last_dll_path'] == nil then
      vim.g['dotnet_last_dll_path'] = request()
    else
      if
        vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1
      then
        vim.g['dotnet_last_dll_path'] = request()
      end
    end

    return vim.g['dotnet_last_dll_path']
  end

  local config = {
    {
      type = 'coreclr',
      name = 'launch - netcoredbg',
      request = 'launch',
      program = function()
        if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
          vim.g.dotnet_build_project()
        end
        return vim.g.dotnet_get_dll_path()
      end,
    },
  }

  dap.configurations.cs = config

  require('nwvi.config.dap.keys')
end
