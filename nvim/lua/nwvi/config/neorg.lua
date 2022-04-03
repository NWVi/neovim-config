return function()
  local neorg = safe_require('neorg')
  if not neorg then
    return
  end

  neorg.setup({
    load = {
      ['core.defaults'] = {},
      ['core.norg.dirman'] = {
        config = {
          workspaces = {
            work = '~/notes/work',
            home = '~/notes/home',
          },
        },
      },
      ['core.norg.completion'] = {
        config = {
          engine = 'nvim-cmp',
        },
      },
      ['core.keybinds'] = {
        config = { -- Note that this table is optional and doesn't need to be provided
          -- Configuration here
          default_bindings = true,
        },
      },
      ['core.norg.concealer'] = {
        config = {
          preset = 'basic',
          icons = {
            todo = {
              enabled = true,

              done = {
                enabled = true,
                icon = '',
                highlight = 'NeorgTodoItemDoneMark',
                query = '(todo_item_done) @icon',
                extract = function()
                  return 1
                end,
              },

              pending = {
                enabled = true,
                icon = '',
                highlight = 'NeorgTodoItemPendingMark',
                query = '(todo_item_pending) @icon',
                extract = function()
                  return 1
                end,
              },

              undone = {
                enabled = true,
                icon = '×',
                highlight = 'NeorgTodoItemUndoneMark',
                query = '(todo_item_undone) @icon',
                extract = function()
                  return 1
                end,
              },

              uncertain = {
                enabled = true,
                icon = '',
                highlight = 'NeorgTodoItemUncertainMark',
                query = '(todo_item_uncertain) @icon',
                extract = function()
                  return 1
                end,
              },

              on_hold = {
                enabled = true,
                icon = '',
                highlight = 'NeorgTodoItemOnHoldMark',
                query = '(todo_item_on_hold) @icon',
                extract = function()
                  return 1
                end,
              },

              cancelled = {
                enabled = true,
                icon = '',
                highlight = 'NeorgTodoItemCancelledMark',
                query = '(todo_item_cancelled) @icon',
                extract = function()
                  return 1
                end,
              },

              recurring = {
                enabled = true,
                icon = '↺',
                highlight = 'NeorgTodoItemRecurringMark',
                query = '(todo_item_recurring) @icon',
                extract = function()
                  return 1
                end,
              },

              urgent = {
                enabled = true,
                icon = '⚠',
                highlight = 'NeorgTodoItemUrgentMark',
                query = '(todo_item_urgent) @icon',
                extract = function()
                  return 1
                end,
              },
            },
          },
        },
      },
    },
  })
end
