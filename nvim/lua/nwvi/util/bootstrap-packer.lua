local bootstrap_packer = function()
  --- Downloads packer ---
  -- From Iron-E
  -- https://github.com/wbthomason/packer.nvim/issues/53#issuecomment-732610544
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.mkdir(install_path, "p")
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  end
end

return function()
  if not pcall(require, "packer") then
    bootstrap_packer()

    return true
  end

  return false
end
