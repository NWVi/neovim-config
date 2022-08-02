return function()
  local zen = safe_require('true-zen')
  if not zen then
    return
  end

  zen.setup({})
end
