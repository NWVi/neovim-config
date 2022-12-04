vim.cmd([[setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4]])

vim.keymap.set('n', '<F5>', '<Cmd>RustRun<Cr>', { buffer = true }) -- Quit all windows
