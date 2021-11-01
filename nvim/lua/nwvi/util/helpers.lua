local M = {}

M.reload_config = function()
    vim.cmd('source ~/dotfiles/nvim/init.lua')
    for pack, _ in pairs(package.loaded) do
        if pack:match('^config') or pack:match('^seblj') then
            package.loaded[pack] = nil
            require(pack)
        end
    end
    vim.api.nvim_echo({ { 'Reloaded config' } }, false, {}) -- Don't add to message history
end

M.keymap = {}

local options = { noremap = true, silent = true }

function M.keymap.map(mode, keys, actions, opts)
  vim.api.nvim_set_keymap(mode, keys, actions, opts or options)
end

return M
