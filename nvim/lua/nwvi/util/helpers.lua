local M = {}

-- Make directory
function M.mkdir()
  local dir = vim.fn.expand('%:p:h')

  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, 'p')
  end
end

-- Reloads config for nvim so I don't need to reopen buffer in some cases
M.reload_config = function()
  for pkg, _ in pairs(package.loaded) do
    if pkg:match('^nwvi') then
      package.loaded[pkg] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.cmd('PackerCompile')

  vim.api.nvim_echo({ { 'Reloaded config' } }, true, {})
end

return M
