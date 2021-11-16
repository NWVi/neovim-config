return {
  setup = function(client)
    local ts = require("nvim-lsp-ts-utils")
    -- vim.lsp.handlers["textDocument/codeAction"] = ts.code_action_handler
    ts.setup({
      disable_commands = false,
      enable_import_on_completion = false,
      import_on_completion_timeout = 5000,
      eslint_bin = "eslint_d", -- use eslint_d if possible!
      eslint_enable_diagnostics = true,
      -- eslint_fix_current = false,
      eslint_enable_disable_comments = true,
      enable_formatting = false
    })

    ts.setup_client(client)
  end,
}
-- return {
--   setup = function(client)
--     local ts = require("nvim-lsp-ts-utils")
--     ts.setup({
--       eslint_bin = "eslint_d",
--       eslint_enable_diagnostics = true,
--       eslint_enable_disable_comments = true,
--     })
--
--     ts.setup_client(client)
--   end
-- }
